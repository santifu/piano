\version "2.24.0"
\header {
  title = "Posición de Do y lectura por intervalos"
  subtitle = "Sesión 2 · Clásico"
  tagline = ##f
}
\paper { #(set-paper-size "a4") indent = 0 }

rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  c4-1 d-2 e-3 f-4 | g-5 f e d | c1 | R1*3 | \break
  g4-1 a-2 b-3 c'-4 | d'-5 c' b a | g1 | R1*3 \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  R1*3 | c4-5 d-4 e-3 f-2 | g-1 f e d | c1 |
  R1*3 | g,4-5 a,-4 b,-3 c-2 | d-1 c b, a, | g,1 \bar "|."
}

rhB = \fixed c' {
  \clef treble \key c \major \time 4/4
  c4-1 d e c | e-3 f g2-5 | g4 f e d | c2 e | \break
  d4-2 e f d | e f g2 | g4 e d d | c1 \bar "|."
}
lhB = \fixed c {
  \clef bass \key c \major \time 4/4
  c1-5 | c | g-1 | c | g | c | g | c \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — cinco dedos, manos separadas: primero la derecha, luego la izquierda. }
  \line { Primero en Do y después en Sol. Cada dedo sobre su tecla antes de empezar; el peso cae desde el brazo. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhA \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — antes de tocar, di en voz alta si cada nota sube o baja y si va por grado o salta. }
  \line { La mano derecha no sale de la posición de Do. Metrónomo a 60; si te paras, baja a 50. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhB \new Staff \lhB >>
  \layout { }
  \midi { \tempo 4 = 60 }
}
