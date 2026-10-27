\version "2.24.0"
\header {
  title = "El compás de 3/4: primer minueto"
  subtitle = "Sesión 8 · Clásico"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: movimiento contrario en 3/4
rhA = \fixed c' {
  \clef treble \key c \major \time 3/4
  c4-1-> d-2 e-3 | f-4-> g-5 f-4 | e-3-> d-2 c-1 | c2.-1 \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 3/4
  g4-1-> f-2 e-3 | d-4-> c-5 d-4 | e-3-> f-2 g-1 | g2.-1 \bar "|."
}

% B: lectura en 3/4, mano derecha
rhB = \fixed c' {
  \clef treble \key c \major \time 3/4
  e4-3 f g | e2 c4 | d4 e f | d2. | \break
  e4 d c | g2-5 e4 | d4 e d | c2.-1 \bar "|."
}

% Pieza: «Minueto en Do» (original)
rhC = \fixed c' {
  \clef treble \key c \major \time 3/4 \tempo "Moderato" 4 = 60
  e4-3 c d | e2 g4-5 | f4 e d | e2. | \break
  g4-5 f e | d e f | e d c | d2. | \break
  e4-3 c d | e2 g4-5 | f4 e d | e2 c4 | \break
  d4-2 f e | d c d | e2 d4 | c2.-1 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 3/4
  c2.-5 | c | g-1 | c | c | g | c | g |
  c | c | g | c | f-2 | g-1 | c | c \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — movimiento contrario en compás de 3/4: acentúa el primer pulso }
  \line { de cada compás (>) y toca los otros dos más suaves. Cuenta en voz alta «UN-dos-tres». }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhA \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 72 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — 8 compases en 3/4, solo la derecha. Ojo con las blancas con puntillo: }
  \line { duran los tres pulsos. Antes de tocar, busca las notas guía: Do4 y Sol4. }
  \vspace #0.5
}
\score {
  \new Staff \rhB
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Pieza (7')" — «Minueto en Do». Dos frases de 8 compases que empiezan igual. Primero la derecha sola; }
  \line { luego juntas por trozos de 4 compases. La izquierda toca una sola nota por compás, en el primer pulso. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhC \new Staff \lhC >>
  \layout { }
  \midi { \tempo 4 = 60 }
}
