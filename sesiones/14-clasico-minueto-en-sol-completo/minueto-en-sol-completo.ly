\version "2.24.0"
\header {
  title = "Minueto en Sol — primera parte completa"
  subtitle = "Sesión 14 · Clásico"
  composer = "C. Petzold, atrib. a J. S. Bach (1725)"
  arranger = "compases 1–16, bajo simplificado"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: escala de Sol mayor, mano izquierda
lhA = \fixed c {
  \clef bass \key g \major \time 4/4
  g,4-5 a,-4 b,-3 c-2 | d-1 e-3 fis-2 g-1 | \break
  fis-2 e-3 d-1 c-2 | b,-3 a,-4 g,2-5 \bar "|."
}

% B: lectura en 3/4, posición de Sol, con saltos
rhB = \fixed c' {
  \clef treble \key g \major \time 3/4
  b4-3 d'8-5 c' b a | g4-1 b d' | c'8-4 b a b c' a | b2.-3 | \break
  d'4-5 b8 c' d' b | c'4 a8 b c' a | b8 a g a b a | g2.-1 \bar "|."
}

% Pieza: Minueto en Sol, compases 1–16
fraseA = \fixed c' {
  d'4-5 g8-1 a-2 b-3 c'-4 | d'4-5 g-1 g | e'4-5 c'8-1 d'-2 e'-3 fis'-4 | g'4-5 g-1 g | \break
  c'4-4 d'8-5 c' b-3 a-2 | b4-3 c'8-4 b a g-1 |
}
rhC = {
  \clef treble \key g \major \time 3/4 \tempo "Allegretto" 4 = 108
  \fraseA
  \fixed c' { fis4-2 g8-1 a-2 b-3 g-1 | a2.-2 | } \break
  \fraseA
  \fixed c' { a4-3 b8-4 a-3 g-2 fis-1 | g2.-2 } \bar "|."
}
bajoA = \fixed c { g2.-5 | b-3 | c'-2 | b-3 | a-4 | g-5 | }
lhC = {
  \clef bass \key g \major \time 3/4
  \bajoA \fixed c { d'2.-1 | d-5 | }
  \bajoA \fixed c { d'2.-1 | g-5 } \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — escala de Sol con la izquierda. Subiendo, el pulgar (en Re) deja paso }
  \line { al 3, que cruza por encima hasta Mi; bajando, el pulgar pasa por debajo hasta Re. Fa♯ con el 2. }
  \vspace #0.5
}
\score {
  \new Staff \lhA
  \layout { }
  \midi { \tempo 4 = 80 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — corcheas en 3/4 con saltos de 3ª. La mano no se mueve de la posición de Sol: }
  \line { lee los saltos como «salto un dedo». Primero a 60; si sale limpio, a 80. }
  \vspace #0.5
}
\score {
  \new Staff \rhB
  \layout { }
  \midi { \tempo 4 = 72 }
}

\markup \column {
  \vspace #1
  \line { \bold "Pieza (7')" — la primera parte entera del minueto. Los compases 9–14 repiten los 1–6: solo hay dos }
  \line { compases nuevos (15–16), con el pulgar que pasa por debajo hasta Fa♯. Objetivo de hoy: a 80. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhC \new Staff \lhC >>
  \layout { }
  \midi { \tempo 4 = 108 }
}
