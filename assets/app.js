const app = document.getElementById("app");
const SOUNDFONT = "https://storage.googleapis.com/magentadata/js/soundfonts/salamander";
pdfjsLib.GlobalWorkerOptions.workerSrc =
  "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js";

let sesiones = [];
let reproductorActivo = null;

const esc = (s) => String(s ?? "").replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]);
const nombre = (ruta) => decodeURIComponent(ruta.split("/").pop()).replace(/\.[^.]+$/, "").replace(/[-_]/g, " ");
const mmss = (s) => `${Math.floor(s / 60)}:${String(Math.floor(s % 60)).padStart(2, "0")}`;
const ICON_PLAY = '<svg viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>';
const ICON_PAUSA = '<svg viewBox="0 0 24 24"><path d="M6 5h4v14H6zm8 0h4v14h-4z"/></svg>';

async function iniciar() {
  try {
    sesiones = await (await fetch("sessions.json", { cache: "no-store" })).json();
  } catch {
    sesiones = [];
  }
  window.addEventListener("hashchange", ruta);
  ruta();
}

function ruta() {
  pararReproductor();
  const [, seccion, id] = location.hash.split("/");
  document.querySelectorAll("[data-nav]").forEach((a) =>
    a.classList.toggle("activo", a.dataset.nav === (seccion === "diario" ? "diario" : "sesiones"))
  );
  window.scrollTo(0, 0);
  if (seccion === "diario") return vistaDiario();
  vistaSesion(seccion === "sesion" ? decodeURIComponent(id || "") : null);
}

/* ---------- Sesiones ---------- */

function vistaSesion(id) {
  if (!sesiones.length) {
    app.innerHTML = '<p class="vacio">Todavía no hay sesiones.</p>';
    return;
  }
  const s = sesiones.find((x) => x.id === id) || sesiones[0];
  const esUltima = s === sesiones[0];

  app.innerHTML = `
    <div class="layout">
      <article>
        <p class="etiqueta-sup">${esUltima ? "Última sesión" : `Sesión ${esc(s.num)}`}${s.fecha ? ` · ${esc(s.fecha)}` : ""}</p>
        <h1>${esc(s.titulo)} <span class="tipo ${esc(s.tipo)}">${esc(s.tipo)}</span></h1>
        ${s.descripcion ? `<p class="desc">${esc(s.descripcion)}</p>` : ""}
        ${s.teoria ? seccion("teoria", "Teoría", "", `<div id="teoria" class="teoria"><p class="vacio">Cargando…</p></div>`) : ""}
        ${s.midi.length ? seccion("escuchar", "Escuchar", "", `<div id="midis"></div>`) : ""}
        ${s.teclado?.length ? seccion("teclado", "Posición en el teclado",
            `<span class="leyenda"><i class="mi"></i>Izquierda <i class="md"></i>Derecha</span>`,
            s.teclado.map((a) => htmlAcorde(a, rango(s.teclado))).join("")) : ""}
        ${s.audio.map((a, i) => seccion(`audio-${i}`, nombre(a), "",
            `<audio controls preload="none" src="${encodeURI(a)}" style="width:100%"></audio>`)).join("")}
        ${s.pdf.map((p, i) => seccion(i ? `partitura-${i}` : "partitura", nombre(p),
            `<a class="boton" href="${encodeURI(p)}" target="_blank" rel="noopener">Abrir PDF</a>`,
            `<div class="partitura" id="pdf-${i}"><p class="vacio">Cargando partitura…</p></div>`)).join("")}
        <div class="descargas">
          ${[...s.pdf, ...s.midi].map((f) => `<a class="boton" href="${encodeURI(f)}" download>↓ ${esc(decodeURIComponent(f.split("/").pop()))}</a>`).join("")}
        </div>
      </article>
      <aside class="lateral">
        <h2>Todas las sesiones</h2>
        <ul class="lista">
          ${sesiones.map((x) => `
            <li><a href="#/sesion/${encodeURIComponent(x.id)}" class="${x === s ? "activo" : ""}">
              <span><span class="num">${esc(x.num)}</span>${esc(x.titulo)}</span>
              <span class="tipo ${esc(x.tipo)}">${esc(x.tipo)}</span>
            </a></li>`).join("")}
        </ul>
      </aside>
    </div>`;

  app.querySelectorAll("details[data-clave]").forEach((d) =>
    d.addEventListener("toggle", () => {
      const cerradas = new Set(leerCerradas());
      d.open ? cerradas.delete(d.dataset.clave) : cerradas.add(d.dataset.clave);
      try { localStorage.setItem("secciones-cerradas", JSON.stringify([...cerradas])); } catch {}
    })
  );
  const midis = document.getElementById("midis");
  s.midi.forEach((m) => midis.appendChild(crearReproductor(m)));
  s.pdf.forEach((p, i) => pintarPdf(p, document.getElementById(`pdf-${i}`)));
  if (s.teoria) {
    fetch(encodeURI(s.teoria), { cache: "no-store" })
      .then((r) => r.text())
      .then((md) => { document.getElementById("teoria").innerHTML = marked.parse(md); })
      .catch(() => { document.getElementById("teoria").innerHTML = ""; });
  }
}

function leerCerradas() {
  try { return JSON.parse(localStorage.getItem("secciones-cerradas")) || []; } catch { return []; }
}

// Sección desplegable; recuerda en este navegador cuáles has cerrado.
function seccion(clave, titulo, extra, cuerpo) {
  const abierta = !leerCerradas().includes(clave);
  return `
    <details class="bloque" data-clave="${esc(clave)}"${abierta ? " open" : ""}>
      <summary class="bloque-cab">
        <h2>${esc(titulo)}</h2>
        <span class="cab-extra">${extra}<svg class="flecha" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9l6 6 6-6"/></svg></span>
      </summary>
      <div class="bloque-cuerpo">${cuerpo}</div>
    </details>`;
}

/* ---------- Audio en iOS ---------- */

// iOS silencia Web Audio con el interruptor de silencio. Pasar la sesión a
// «playback» y mantener un <audio> mudo sonando lo evita.
let silencio = null;

function wavMudo() {
  const n = 800, buf = new ArrayBuffer(44 + n), v = new DataView(buf);
  const txt = (o, s) => [...s].forEach((c, i) => v.setUint8(o + i, c.charCodeAt(0)));
  txt(0, "RIFF"); v.setUint32(4, 36 + n, true); txt(8, "WAVEfmt ");
  v.setUint32(16, 16, true); v.setUint16(20, 1, true); v.setUint16(22, 1, true);
  v.setUint32(24, 8000, true); v.setUint32(28, 8000, true); v.setUint16(32, 1, true); v.setUint16(34, 8, true);
  txt(36, "data"); v.setUint32(40, n, true);
  for (let i = 0; i < n; i++) v.setUint8(44 + i, 128);
  return URL.createObjectURL(new Blob([buf], { type: "audio/wav" }));
}

function desbloquearAudio() {
  try { if (navigator.audioSession) navigator.audioSession.type = "playback"; } catch {}
  if (!silencio) {
    silencio = new Audio(wavMudo());
    silencio.loop = true;
    silencio.setAttribute("playsinline", "");
  }
  silencio.play().catch(() => {});
}

function silenciarDesbloqueo() {
  if (silencio) silencio.pause();
}

/* ---------- Teclado ---------- */

const CLASE = { C: 0, D: 2, E: 4, F: 5, G: 7, A: 9, B: 11 };
const SOLFEO = { C: "Do", D: "Re", E: "Mi", F: "Fa", G: "Sol", A: "La", B: "Si" };
const NEGRAS = [1, 3, 6, 8, 10];

function midiDe(nota) {
  const [, letra, alt, oct] = nota.match(/^([A-G])(b|#)?(-?\d)$/);
  return 12 * (Number(oct) + 1) + CLASE[letra] + (alt === "#" ? 1 : alt === "b" ? -1 : 0);
}

function nombreNota(nota) {
  const [, letra, alt] = nota.match(/^([A-G])(b|#)?/);
  return SOLFEO[letra] + (alt === "b" ? "♭" : alt === "#" ? "♯" : "");
}

function rango(acordes) {
  const notas = acordes.flatMap((a) => [...(a.mi || []), ...(a.md || [])]).map(midiDe);
  return [12 * Math.floor(Math.min(...notas) / 12), 12 * Math.floor(Math.max(...notas) / 12) + 11];
}

function svgTeclado(mi, md, [desde, hasta]) {
  const W = 20, H = 92, NW = 12, NH = 58;
  const marcadas = new Map();
  mi.forEach((n) => marcadas.set(midiDe(n), { mano: "mi", n }));
  md.forEach((n) => marcadas.set(midiDe(n), { mano: "md", n }));
  let blancas = "", negras = "", etiquetas = "", x = 0;
  for (let m = desde; m <= hasta; m++) {
    const marca = marcadas.get(m);
    const relleno = marca ? `var(--${marca.mano})` : null;
    if (NEGRAS.includes(m % 12)) {
      const cx = x;
      negras += `<rect x="${cx - NW / 2}" y="0" width="${NW}" height="${NH}" rx="2" fill="${relleno || "var(--tecla-negra)"}"/>`;
      if (marca) etiquetas += `<text x="${cx}" y="${H + 16}" class="et ${marca.mano}">${nombreNota(marca.n)}</text>`;
    } else {
      const cx = x + W / 2;
      blancas += `<rect x="${x}" y="0" width="${W}" height="${H}" rx="3" fill="${relleno || "var(--tecla-blanca)"}" stroke="var(--tecla-borde)"/>`;
      if (marca) etiquetas += `<text x="${cx}" y="${H + 16}" class="et ${marca.mano}">${nombreNota(marca.n)}</text>`;
      else if (m === 60) etiquetas += `<text x="${cx}" y="${H - 8}" class="do-central">Do4</text>`;
      x += W;
    }
  }
  return `<svg class="teclado" viewBox="-1 -1 ${x + 2} ${H + 24}" role="img"
    aria-label="Izquierda: ${mi.map(nombreNota).join(", ")}. Derecha: ${md.map(nombreNota).join(", ")}">
    ${blancas}${negras}${etiquetas}</svg>`;
}

function htmlAcorde(a, r) {
  return `
    <div class="acorde">
      <p class="acorde-cab"><strong>${esc(a.acorde)}</strong>${a.compases ? ` <span>${/^\d/.test(a.compases) ? "compases " : ""}${esc(a.compases)}</span>` : ""}</p>
      ${svgTeclado(a.mi || [], a.md || [], r)}
      ${a.nota ? `<p class="acorde-nota">${esc(a.nota)}</p>` : ""}
    </div>`;
}

async function pintarPdf(url, contenedor) {
  try {
    const pdf = await pdfjsLib.getDocument(encodeURI(url)).promise;
    contenedor.innerHTML = "";
    const ancho = contenedor.clientWidth || 600;
    for (let n = 1; n <= pdf.numPages; n++) {
      const pagina = await pdf.getPage(n);
      const base = pagina.getViewport({ scale: 1 });
      const escala = (ancho / base.width) * Math.min(window.devicePixelRatio || 1, 3);
      const vp = pagina.getViewport({ scale: escala });
      const canvas = document.createElement("canvas");
      canvas.width = vp.width;
      canvas.height = vp.height;
      contenedor.appendChild(canvas);
      await pagina.render({ canvasContext: canvas.getContext("2d"), viewport: vp }).promise;
    }
  } catch (e) {
    contenedor.innerHTML = `<p class="vacio">No se pudo mostrar la partitura. Usa «Abrir PDF».</p>`;
  }
}

/* ---------- Reproductor MIDI ---------- */

function crearReproductor(url) {
  const el = document.createElement("div");
  el.className = "midi";
  el.innerHTML = `
    <p class="midi-nombre">${esc(nombre(url))}</p>
    <div class="midi-fila">
      <button class="play" aria-label="Reproducir" disabled>${ICON_PLAY}</button>
      <div class="progreso">
        <div class="barra"><div></div></div>
        <div class="tiempos"><span class="actual">0:00</span><span class="total">–:––</span></div>
      </div>
    </div>
    <label class="tempo">Tempo
      <input type="range" min="30" max="160" step="5">
      <output>♩ = –</output>
    </label>`;

  const boton = el.querySelector(".play");
  const barra = el.querySelector(".barra > div");
  const actual = el.querySelector(".actual");
  const total = el.querySelector(".total");
  const slider = el.querySelector("input");
  const salida = el.querySelector("output");

  let original = null;
  let qpmOriginal = 120;
  let secuencia = null;
  let estado = "parado";
  let t0 = 0;
  let transcurrido = 0;
  let raf = 0;

  const player = new core.SoundFontPlayer(SOUNDFONT, undefined, undefined, undefined, {
    run: () => {},
    stop: () => { if (estado === "sonando") fin(); },
  });

  const control = {
    parar() {
      if (estado !== "parado") player.stop();
      fin();
    },
  };

  function escalar() {
    const factor = qpmOriginal / Number(slider.value);
    const s = core.sequences.clone(original);
    s.notes.forEach((n) => {
      n.startTime *= factor;
      n.endTime *= factor;
      n.program = 0;
      n.isDrum = false;
    });
    s.totalTime = original.totalTime * factor;
    s.tempos = [{ time: 0, qpm: Number(slider.value) }];
    secuencia = s;
    total.textContent = mmss(s.totalTime);
    salida.textContent = `♩ = ${slider.value}`;
  }

  function pintar() {
    const t = estado === "sonando" ? (performance.now() - t0) / 1000 : transcurrido;
    const pct = Math.min(100, (t / secuencia.totalTime) * 100);
    barra.style.width = `${pct}%`;
    actual.textContent = mmss(Math.min(t, secuencia.totalTime));
    if (estado === "sonando") raf = requestAnimationFrame(pintar);
  }

  function fin() {
    silenciarDesbloqueo();
    estado = "parado";
    transcurrido = 0;
    cancelAnimationFrame(raf);
    boton.innerHTML = ICON_PLAY;
    boton.setAttribute("aria-label", "Reproducir");
    barra.style.width = "0%";
    actual.textContent = "0:00";
    if (reproductorActivo === control) reproductorActivo = null;
  }

  boton.addEventListener("click", async () => {
    desbloquearAudio();
    if (window.Tone && Tone.context.state !== "running") await Tone.start();
    if (estado === "sonando") {
      player.pause();
      silenciarDesbloqueo();
      transcurrido = (performance.now() - t0) / 1000;
      estado = "pausa";
      cancelAnimationFrame(raf);
      boton.innerHTML = ICON_PLAY;
      boton.setAttribute("aria-label", "Reproducir");
      return;
    }
    if (reproductorActivo && reproductorActivo !== control) reproductorActivo.parar();
    reproductorActivo = control;
    boton.innerHTML = ICON_PAUSA;
    boton.setAttribute("aria-label", "Pausar");
    if (estado === "pausa") {
      player.resume();
      t0 = performance.now() - transcurrido * 1000;
    } else {
      boton.disabled = true;
      await player.loadSamples(secuencia);
      boton.disabled = false;
      t0 = performance.now();
      player.start(secuencia);
    }
    estado = "sonando";
    pintar();
  });

  slider.addEventListener("input", () => {
    if (!original) return;
    if (estado !== "parado") control.parar();
    escalar();
  });

  core.urlToNoteSequence(encodeURI(url))
    .then((ns) => {
      original = ns;
      qpmOriginal = Math.round(ns.tempos?.[0]?.qpm || 120);
      slider.value = qpmOriginal;
      escalar();
      boton.disabled = false;
    })
    .catch(() => {
      el.querySelector(".midi-nombre").textContent += " (no se pudo cargar)";
    });

  el._control = control;
  return el;
}

function pararReproductor() {
  if (reproductorActivo) reproductorActivo.parar();
}

/* ---------- Diario ---------- */

async function vistaDiario() {
  let texto = "";
  try {
    texto = await (await fetch("diario.md", { cache: "no-store" })).text();
  } catch {}
  const bloques = texto.replace(/<!--[\s\S]*?-->/g, "").split(/^## /m).slice(1).map((b) => "## " + b.trim());
  const entradas = bloques.map((b) => {
    const cab = b.split("\n")[0];
    const fecha = (cab.match(/\d{4}-\d{2}-\d{2}/) || [])[0];
    const min = Number((cab.match(/(\d+)\s*min/) || [])[1] || 0);
    const md = b.replace(/^(\s*[-*]\s+)([^:\n]{1,30}):/gm, "$1**$2:**");
    return { fecha, min, html: marked.parse(md) };
  });
  const minutos = entradas.reduce((a, e) => a + e.min, 0);
  const ultima = entradas.map((e) => e.fecha).filter(Boolean).sort().pop();

  app.innerHTML = `
    <h1>Diario</h1>
    <div class="stats">
      <div class="stat"><span>Sesiones</span><strong>${entradas.length}</strong></div>
      <div class="stat"><span>Minutos</span><strong>${minutos}</strong></div>
      <div class="stat"><span>Última</span><strong>${ultima ? ultima.slice(5).split("-").reverse().join("/") : "–"}</strong></div>
    </div>
    ${entradas.length
      ? entradas.reverse().map((e) => `<div class="entrada">${e.html}</div>`).join("")
      : '<p class="vacio">Todavía no hay entradas. Aparecerán aquí al acabar la primera sesión.</p>'}`;
}

iniciar();
