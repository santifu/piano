\version "2.24.0"
\header {
  title = "Boogie en Do y «When the Saints» a tempo"
  subtitle = "Sesión 13 · Jazz · canción tradicional, arreglo original"
  tagline = ##f
}
#(set-global-staff-size 17)
\paper { #(set-paper-size "a4") indent = 0 }

% Patrón de boogie en la izquierda: 5ª y 6ª alternadas sobre la fundamental
boogieC = \fixed c { <c-5 g-2>4 <c-5 a-1> <c g> <c a> }
boogieF = \fixed c { <f,-5 c-2>4 <f,-5 d-1> <f, c> <f, d> }
boogieG = \fixed c { <g,-5 d-2>4 <g,-5 e-1> <g, d> <g, e> }

% Riff de la derecha (fundamental, 3ª menor → 3ª mayor, 5ª, 3ª)
riffC = \fixed c' { c4-1 ees8-2 e-3 g4-5 e-3 }
riffF = \fixed c' { f4-1 aes8-2 a-3 c'4-5 a-3 }
riffG = \fixed c' { g4-1 bes8-2 b-3 d'4-5 b-3 }

% A: el boogie solo
harmA = \chordmode { c1 c f f g g c c }
lhA = {
  \clef bass \key c \major \time 4/4
  \boogieC | \boogieC | \boogieF | \boogieF | \break
  \boogieG | \boogieG | \boogieC | \fixed c { <c g>1 } \bar "|."
}

% B: blues en Do con boogie y riff
harmBlues = \chordmode {
  c1:7 f:7 c:7 c:7 f:7 f:7 c:7 c:7 g:7 f:7 c:7 g:7
}
rhB = {
  \clef treble \key c \major \time 4/4 \tempo "Shuffle" 4 = 112
  \riffC | \riffF | \riffC | \riffC | \break
  \riffF | \riffF | \riffC | \riffC | \break
  \riffG | \riffF | \riffC | \riffG \bar "|."
}
lhB = {
  \clef bass \key c \major \time 4/4
  \boogieC | \boogieF | \boogieC | \boogieC |
  \boogieF | \boogieF | \boogieC | \boogieC |
  \boogieG | \boogieF | \boogieC | \boogieG \bar "|."
}

% C: «When the Saints» con boogie
harmSaints = \chordmode {
  c1 c c c c c c g:7
  c c:7 f f c c g:7 c
}
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Alegre" 4 = 132
  r4 c-1 e-3 f-4 | g1-5 | r4 c-1 e f | g1 | \break
  r4 c-1 e f | g2 e | c e | d1-2 | \break
  r4 e-3 e d | c2.-1 c4 | e2-3 g-5 | g4 f2. | \break
  r4 e-3 f g | e2 c | d1-2 | c1-1 \bar "|."
}
lhC = {
  \clef bass \key c \major \time 4/4
  \boogieC | \boogieC | \boogieC | \boogieC |
  \boogieC | \boogieC | \boogieC | \boogieG |
  \boogieC | \boogieC | \boogieF | \boogieF |
  \boogieC | \boogieC | \boogieG | \fixed c { <c g>1 } \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — el boogie: el meñique fijo en la fundamental y los dedos 2 y 1 alternan }
  \line { 5ª y 6ª. Sin parar al cambiar de acorde: la mano entera salta y el patrón sigue. Empieza a 80, sube a 112. }
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
  \line { \bold "Ejercicio B (blues, 4')" — boogie abajo y el riff con nota azul arriba (ya lo conoces de la sesión 9, }
  \line { ahora en Do). Primero 4 compases, luego 8, luego los 12. Corcheas en swing: larga-corta. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new PianoStaff << \new Staff \rhB \new Staff \lhB >> >>
  \layout { }
  \midi { \tempo 4 = 112 }
}

\pageBreak
\markup \column {
  \line { \bold "Canción (7')" — «When the Saints» con boogie: la misma melodía, con energía. El audio va a 132; }
  \line { empieza a 90. La izquierda no para nunca: si la derecha se pierde, sigue con el boogie y vuelve a entrar. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmSaints
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 132 }
}
