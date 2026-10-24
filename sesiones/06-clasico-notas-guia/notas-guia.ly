\version "2.24.0"
\header {
  title = "Notas guía y manos juntas por trozos"
  subtitle = "Sesión 6 · Clásico"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: movimiento contrario en posición de Sol
rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  g4-1 a-2 b-3 c'-4 | d'-5 c'-4 b-3 a-2 | g1-1 \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  d4-1 c-2 b,-3 a,-4 | g,-5 a,-4 b,-3 c-2 | d1-1 \bar "|."
}

% B1: lectura, mano derecha
rhB = \fixed c' {
  \clef treble \key c \major \time 4/4
  g4-5^"Sol" e f d | c-1^"Do" e g2 | f4 d e c | d2 g | \break
  e4 f g e | d c d2 | e4 d c d | c1 \bar "|."
}

% B2: lectura, mano izquierda
lhB = \fixed c {
  \clef bass \key c \major \time 4/4
  f4-2^"Fa" e d c-5^"Do" | d e f2 | g4-1 f e d | c1 \bar "|."
}

% Pieza: «Paseo en Do» (sesión 4), ahora por trozos y más lento
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Tranquilo" 4 = 50
  c4-1 e g-5 e | f d e2 | e4 g-5 f d | e2 c | \break
  d4-2 f e c | d e f2 | g4-5 f e d | c1 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  c1-5 | g-1 | c | c | g | g | g | c \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — movimiento contrario, ahora en posición de Sol. Pulgares juntos }
  \line { (Re3 y Sol4) y las manos se abren: el mismo dedo a la vez. Primero cada mano sola. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhA \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — localiza primero las notas guía marcadas (Sol y Do arriba, Fa y Do abajo) }
  \line { y lee el resto desde ellas, por intervalos. Primero la derecha, luego la izquierda. Sin juntar manos. }
  \vspace #0.5
}
\score {
  \new Staff \rhB
  \layout { }
  \midi { \tempo 4 = 60 }
}
\score {
  \new Staff \lhB
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Pieza (7')" — «Paseo en Do» a dos manos, por trozos: compases 1–2 tres veces, luego 3–4, }
  \line { luego 1–4 seguidos; igual con 5–8. Al final, entera. Metrónomo a 50. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhC \new Staff \lhC >>
  \layout { }
  \midi { \tempo 4 = 50 }
}
