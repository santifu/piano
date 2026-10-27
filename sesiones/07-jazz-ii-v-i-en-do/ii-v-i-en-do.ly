\version "2.24.0"
\header {
  title = "ii–V–I en Do"
  subtitle = "Sesión 7 · Jazz"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

harmA = \chordmode {
  d1:m7 g:7 c:maj7 c:maj7 d:m7 g:7 c:maj7 c:maj7
}
% A: guide tones del ii–V–I (derecha) y fundamental (izquierda)
rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  <f-1 c'-5>1 | <f-1 b-4> | <e-1 b-5> | <e b> | \break
  <f-1 c'-5> | <f-1 b-4> | <e-1 b-5> | <e b> \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  d1-5 | g,-5 | c-5 | c | d | g, | c | c \bar "|."
}

% B: lectura de cifrado, en otro orden
harmB = \chordmode {
  c1:maj7 d:m7 g:7 c:maj7 d:m7 g:7 c:maj7 g:7
}
barras = {
  \clef treble \key c \major \time 4/4
  \improvisationOn
  \repeat unfold 4 { b'4 b' b' b' | } \break
  \repeat unfold 4 { b'4 b' b' b' | }
  \improvisationOff \bar "|."
}

% C: shells en la izquierda y melodía original en la derecha
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Swing" 4 = 60
  f4-1 a-3 c'-5 a | b2-4 g4-2 f-1 | e-1 g-2 b2-4 | c'1-5 | \break
  d'4-5 c'-4 a-2 f-1 | g-3 f-2 d2-1 | e4-2 g-3 b-5 g-3 | e1-2 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  <d-5 f-3>1 | <g,-5 f-1> | <c-5 e-3> | <c e> |
  <d f> | <g, f> | <c e> | <c e> \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — guide tones del ii–V–I. Fíjate en la derecha: de Dm7 a G7 solo baja }
  \line { el Do a Si; de G7 a Cmaj7 solo baja el Fa a Mi. Una nota se mueve, la otra se queda. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmA
     \new PianoStaff << \new Staff \rhA \new Staff \lhA >> >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura de cifrado, 4')" — los mismos tres acordes en otro orden. Toca las guide tones }
  \line { con la derecha y la fundamental con la izquierda, una redonda por compás. Di el tipo: «menor 7», «7», «maj7». }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmB
     \new Staff \with { \remove "Time_signature_engraver" } \barras >>
  \layout { }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio C (progresión, 7')" — izquierda: shells (1-3, 1-7, 1-3). Derecha: una melodía sobre los acordes. }
  \line { Primero la izquierda sola hasta que no mires; luego juntas, a 60. Toca las negras un poco separadas. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmA
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 60 }
}
