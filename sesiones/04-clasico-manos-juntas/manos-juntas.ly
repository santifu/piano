\version "2.24.0"
\header {
  title = "Manos juntas"
  subtitle = "Sesión 4 · Clásico"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: movimiento contrario, mismos dedos a la vez
rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  c4-1 d-2 e-3 f-4 | g-5 f-4 e-3 d-2 | c1-1 \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  g4-1 f-2 e-3 d-4 | c-5 d-4 e-3 f-2 | g1-1 \bar "|."
}

% B: lectura en posición de Sol
rhB = \fixed c' {
  \clef treble \key c \major \time 4/4
  g4-1 b a c' | b d'-5 c'2 | d'4 b c' a | b2 g | \break
  a4-2 c' b d' | c' a b2 | a4 b g a | g1 \bar "|."
}
lhB = \fixed c {
  \clef bass \key c \major \time 4/4
  g,1-5 | g, | d-1 | g, | d | g, | d | g, \bar "|."
}

% C: pieza a dos manos (original)
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Tranquilo" 4 = 60
  c4-1 e g-5 e | f d e2 | e4 g-5 f d | e2 c | \break
  d4-2 f e c | d e f2 | g4-5 f e d | c1 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  c1-5 | g-1 | c | c | g | g | g | c \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — manos juntas en movimiento contrario: las dos manos usan el mismo dedo a la vez. }
  \line { Primero cada mano sola, luego juntas. Tres veces seguidas a 60 antes de subir el metrónomo. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhA \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — posición de Sol: pulgar derecho en Sol4. Antes de tocar, sigue el dibujo }
  \line { con el dedo: ¿sube o baja?, ¿por grado o con salto? La izquierda solo cambia entre Sol2 (5) y Re3 (1). }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhB \new Staff \lhB >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Pieza (7')" — «Paseo en Do». Primero la derecha sola; luego juntas, empezando a 50. }
  \line { La izquierda solo cambia en los compases 2, 3, 5 y 8: prepárala un pulso antes. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhC \new Staff \lhC >>
  \layout { }
  \midi { \tempo 4 = 60 }
}
