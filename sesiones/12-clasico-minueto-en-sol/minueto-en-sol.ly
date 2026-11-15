\version "2.24.0"
\header {
  title = "Minueto en Sol"
  subtitle = "Sesión 12 · Clásico"
  composer = "C. Petzold, atrib. a J. S. Bach (1725)"
  arranger = "compases 1–8, bajo simplificado"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: escala de Sol mayor con paso del pulgar
rhA = \fixed c' {
  \clef treble \key g \major \time 4/4
  g4-1 a-2 b-3 c'-1 | d'-2 e'-3 fis'-4 g'-5 | \break
  fis'-4 e'-3 d'-2 c'-1 | b-3 a-2 g2-1 \bar "|."
}

% B: lectura en 3/4 con corcheas, posición de Sol
rhB = \fixed c' {
  \clef treble \key g \major \time 3/4
  g8-1 a b c' d'4-5 | b4-3 g g | c'8-4 b a b c'4 | a2.-2 | \break
  b8-3 c' d' c' b4 | c'8 b a g a4 | b8 a g a b4 | g2.-1 \bar "|."
}

% Pieza: Minueto en Sol, compases 1–8
rhC = \fixed c' {
  \clef treble \key g \major \time 3/4 \tempo "Allegretto" 4 = 108
  d'4-5 g8-1 a-2 b-3 c'-4 | d'4-5 g-1 g | e'4-5 c'8-1 d'-2 e'-3 fis'-4 | g'4-5 g-1 g | \break
  c'4-4 d'8-5 c' b-3 a-2 | b4-3 c'8-4 b a g-1 | fis4-2 g8-1 a-2 b-3 g-1 | a2.-2 \bar "|."
}
lhC = \fixed c {
  \clef bass \key g \major \time 3/4
  g2.-5 | b-3 | c'-2 | b-3 | a-4 | g-5 | d'-1 | d-5 \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — escala de Sol mayor, solo la derecha. Subiendo, el pulgar pasa por debajo }
  \line { del 3 para llegar a Do; bajando, el 3 pasa por encima del pulgar. Fa siempre es Fa sostenido (♯). }
  \vspace #0.5
}
\score {
  \new Staff \rhA
  \layout { }
  \midi { \tempo 4 = 80 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — corcheas en 3/4: dos corcheas por pulso. Cuenta «UN-y dos-y tres-y». }
  \line { Es el ritmo del minueto: léelo aquí primero, más fácil, en posición de Sol. }
  \vspace #0.5
}
\score {
  \new Staff \rhB
  \layout { }
  \midi { \tempo 4 = 80 }
}

\markup \column {
  \vspace #1
  \line { \bold "Pieza (7')" — Minueto en Sol. El audio va a tempo real (108): bájalo a 60 para empezar. }
  \line { La derecha cambia de posición en los compases 3, 4 y 5: practica esos saltos solos. Luego, juntas. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhC \new Staff \lhC >>
  \layout { }
  \midi { \tempo 4 = 108 }
}
