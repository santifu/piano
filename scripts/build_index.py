#!/usr/bin/env python3
"""Genera sessions.json a partir de las carpetas de sesiones/.

Cada carpeta se llama NN-tipo-tema (p. ej. 01-jazz-blues-guide-tones).
Un info.json opcional dentro de la carpeta sobrescribe titulo, tipo,
fecha y descripcion.
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SESIONES = ROOT / "sesiones"

EXT = {
    "pdf": (".pdf",),
    "midi": (".mid", ".midi"),
    "audio": (".mp3", ".m4a", ".wav", ".ogg"),
}


def sesion(carpeta: Path) -> dict:
    m = re.match(r"(\d+)-(jazz|clasico|clásico)-(.+)", carpeta.name)
    num, tipo, slug = m.groups() if m else ("", "", carpeta.name)
    info_path = carpeta / "info.json"
    info = json.loads(info_path.read_text(encoding="utf-8")) if info_path.exists() else {}
    archivos = sorted(f.name for f in carpeta.iterdir() if f.is_file())
    datos = {
        "id": carpeta.name,
        "num": num,
        "tipo": info.get("tipo", "clásico" if tipo.startswith("cl") else tipo),
        "titulo": info.get("titulo", slug.replace("-", " ").capitalize()),
        "fecha": info.get("fecha"),
        "descripcion": info.get("descripcion", ""),
        "teclado": info.get("teclado", []),
        "teoria": f"sesiones/{carpeta.name}/teoria.md" if (carpeta / "teoria.md").exists() else None,
    }
    for clave, extensiones in EXT.items():
        datos[clave] = [
            f"sesiones/{carpeta.name}/{f}" for f in archivos if f.lower().endswith(extensiones)
        ]
    return datos


def main() -> None:
    carpetas = sorted(p for p in SESIONES.iterdir() if p.is_dir()) if SESIONES.exists() else []
    indice = [sesion(c) for c in reversed(carpetas)]
    (ROOT / "sessions.json").write_text(
        json.dumps(indice, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(f"sessions.json: {len(indice)} sesiones")


if __name__ == "__main__":
    main()
