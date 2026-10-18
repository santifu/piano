# Piano

Método de piano personal (jazz y clásico) para retomar el instrumento con sesiones de 15 minutos en días alternos. Esta web reúne el material de cada sesión para abrirlo desde cualquier dispositivo, también el móvil, y practicar con él.

**Web:** https://santifu.github.io/piano/

## Qué hay

- **Sesiones:** cada sesión empieza con un poco de teoría, muestra en un teclado dónde van las notas de cada acorde (mano izquierda y derecha) y tiene su partitura (PDF, que se ve dentro de la página) y uno o varios MIDI con reproductor. El reproductor permite bajar el tempo sin cambiar la altura de las notas.
- **Diario:** registro de cada sesión: qué se trabajó, qué salió, dónde hubo atascos y qué toca la próxima vez.

El método sigue el temario ABRSM (objetivo: Grado 1), Faber *Adult Piano Adventures* como base, y en jazz la progresión blues → guide tones → shell voicings → ii–V–I. Las partituras son ejercicios originales o de dominio público, generados con LilyPond.

## Estructura

```
index.html            la web (estática, sin servidor)
assets/               estilos y lógica (pdf.js, Magenta.js, marked)
sesiones/
  NN-tipo-tema/       una carpeta por sesión: PDF, MIDI, teoria.md e info.json
diario.md             entradas del diario
scripts/build_index.py  genera sessions.json a partir de sesiones/
.github/workflows/    publica en GitHub Pages en cada push a main
```

`info.json` (opcional) sobrescribe los datos que se sacan del nombre de la carpeta:

```json
{
  "titulo": "Blues en Do · guide tones", "tipo": "jazz", "fecha": "2026-10-19", "descripcion": "…",
  "teclado": [{ "acorde": "C7", "compases": "1, 3–4", "mi": ["C3"], "md": ["E4", "Bb4"], "nota": "3ª y 7ª" }]
}
```

`teclado` dibuja un teclado por acorde (`mi` = mano izquierda, `md` = mano derecha, notas en cifrado inglés con octava, Do central = C4). `teoria.md` se muestra al principio de la sesión.

## Añadir una sesión

Los originales se guardan fuera del repo, en la carpeta del proyecto. Desde allí:

```bash
./publicar.sh
```

Copia `sesiones/` y `diario.md` a este repo y regenera el índice. Después, commit y push: la Action publica la web sola.

## Ver en local

```bash
python3 scripts/build_index.py && python3 -m http.server 8765
```

Y abre http://localhost:8765.

## Etiqueta de contribución cognitiva (CCL)

**AI-first**

```
CCL v2.0 — Piano by Santi Fuentemilla
R4 I1 D4 C4 P4 O4 M3 F3
```

La idea es mía: una web para tener el método de piano y el material de práctica siempre a mano. Lo demás lo hizo Claude (Anthropic): la metodología y el plan de estudio, las partituras y los MIDI, el diseño y el código de la web, la publicación y esta documentación. Yo decidí la estructura de carpetas, creé el repositorio y revisé y di el visto bueno a cada paso.

**Human-first**

```
CCL Human-first v2.0 — Piano by Santi Fuentemilla
E3 L1 R0 B1 K1 J2
```

Lo que aporto yo: la necesidad real (retomar el piano siendo adulto, con poco tiempo), mi práctica diaria, que es de donde sale el diario, y el criterio sobre qué me sirve y qué no.

Arquetipo: **Delegated**. La IA hizo la mayor parte; mi aportación es la idea y la práctica.

```json
{
  "ccl_version": "2.0",
  "project": "Piano",
  "author": "Santi Fuentemilla",
  "date": "2026-10-18",
  "language": "es",
  "ai_first": { "R": 4, "I": 1, "D": 4, "C": 4, "P": 4, "O": 4, "M": 3, "F": 3 },
  "human_first": { "E": 3, "L": 1, "R": 0, "B": 1, "K": 1, "J": 2 },
  "archetype": "Delegated"
}
```

Badge: https://santifu.github.io/ccl/

## Licencia

[CC0 1.0](LICENSE): dominio público.
