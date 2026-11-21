\version "2.24.0"
\header {
  title = "Boogie: cambios rápidos y «Jingle Bells»"
  subtitle = "Sesión 15 · Jazz"
  composer = "J. L. Pierpont (1857)"
  arranger = "arreglo original con boogie"
  tagline = ##f
}
#(set-global-staff-size 17)
\paper { #(set-paper-size "a4") indent = 0 }

% Patrones de boogie (5ª y 6ª sobre la fundamental)
bC  = \fixed c { <c-5 g-2>4 <c-5 a-1> <c g> <c a> }
bF  = \fixed c { <f,-5 c-2>4 <f,-5 d-1> <f, c> <f, d> }
bG  = \fixed c { <g,-5 d-2>4 <g,-5 e-1> <g, d> <g, e> }
bD  = \fixed c { <d-5 a-2>4 <d-5 b-1> <d a> <d b> }
bBb = \fixed c { <bes,-5 f-2>4 <bes,-5 g-1> <bes, f> <bes, g> }

% A: cambios de acorde de compás en compás (incluye el nuevo D7)
harmA = \chordmode { c1 f c g c d:7 g:7 c }
lhA = {
  \clef bass \key c \major \time 4/4
  \bC | \bF | \bC | \bG | \break
  \bC | \bD | \bG | \fixed c { <c g>1 } \bar "|."
}

% B: blues en Fa, solo cifrado: el boogie con la izquierda
harmB = \chordmode {
  f1:7 bes:7 f:7 f:7 bes:7 bes:7 f:7 f:7 c:7 bes:7 f:7 c:7
}
barras = {
  \clef bass \key f \major \time 4/4
  \improvisationOn
  \repeat unfold 4 { d4 d d d | } \break
  \repeat unfold 4 { d4 d d d | } \break
  \repeat unfold 4 { d4 d d d | }
  \improvisationOff \bar "|."
}

% C: «Jingle Bells» (estribillo) con boogie
harmC = \chordmode {
  c1 c c c f c d:7 g:7
  c c c c f c g:7 c
}
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Alegre" 4 = 132
  e4-3 e e2 | e4 e e2 | e4 g-5 c4.-1 d8-2 | e1-3 | \break
  f4-4 f f4. f8 | f4 e e e8 e | e4 d d e | d2-2 g-5 | \break
  e4-3 e e2 | e4 e e2 | e4 g-5 c4.-1 d8-2 | e1-3 | \break
  f4-4 f f f | f e e e8 e | g4-5 g f d | c1-1 \bar "|."
}
lhC = {
  \clef bass \key c \major \time 4/4
  \bC | \bC | \bC | \bC |
  \bF | \bC | \bD | \bG |
  \bC | \bC | \bC | \bC |
  \bF | \bC | \bG | \fixed c { <c g>1 } \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — el boogie cambiando de acorde en cada compás, y un acorde nuevo: D7. }
  \line { Sube el metrónomo de 8 en 8 desde 80. Objetivo: 112 sin mirar la mano. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmA
     \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 112 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura de cifrado, 4')" — blues en Fa: toca el boogie de cada acorde con la izquierda. }
  \line { F: Fa, Do, Re. Bb: Si bemol, Fa, Sol. C: Do, Sol, La. Es la misma forma de siempre en otra tonalidad. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmB
     \new Staff \with { \remove "Time_signature_engraver" } \barras >>
  \layout { }
}

\pageBreak
\markup \column {
  \line { \bold "Canción (7')" — «Jingle Bells» con boogie. La melodía cabe en la posición de Do y usa la negra con puntillo }
  \line { del Himno (compases 3 y 11). Empieza a 90; el audio va a 132. La izquierda no para nunca. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmC
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 132 }
}
