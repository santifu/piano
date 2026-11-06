\version "2.24.0"
\header {
  title = "Turnaround y «When the Saints Go Marching In»"
  subtitle = "Sesión 11 · Jazz · canción tradicional, arreglo sencillo"
  tagline = ##f
}
#(set-global-staff-size 16)
\paper { #(set-paper-size "a4") indent = 0 }

% A: turnaround I–vi–ii–V con guide tones
harmA = \chordmode {
  c1:maj7 a:m7 d:m7 g:7 c:maj7 a:m7 d:m7 g:7
}
rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  <e-1 b-5>1 | <g-1 c'-4> | <f-1 c'-5> | <f-1 b-4> | \break
  <e-1 b-5> | <g-1 c'-4> | <f-1 c'-5> | <f-1 b-4> \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  c1-5 | a,-5 | d-5 | g,-5 | c | a, | d | g, \bar "|."
}

% «When the Saints»: forma de 16 compases
harmSaints = \chordmode {
  c1 c c c c c c g:7
  c c:7 f f c c g:7 c
}
barras = {
  \clef bass \key c \major \time 4/4
  \improvisationOn
  \repeat unfold 8 { d4 d d d | } \break
  \repeat unfold 8 { d4 d d d | }
  \improvisationOff \bar "|."
}

% C: melodía tradicional (derecha) y shells (izquierda)
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Swing" 4 = 96
  r4 c-1 e-3 f-4 | g1-5 | r4 c-1 e f | g1 | \break
  r4 c-1 e f | g2 e | c e | d1-2 | \break
  r4 e-3 e d | c2.-1 c4 | e2-3 g-5 | g4 f2. | \break
  r4 e-3 f g | e2 c | d1-2 | c1-1 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  <c-5 e-3>1 | <c e> | <c e> | <c e> |
  <c e> | <c e> | <c e> | <g,-5 f-1> |
  <c e> | <c-5 bes-1> | <f,-5 a,-3> | <f, a,> |
  <c e> | <c e> | <g, f> | <c e> \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — el turnaround I–vi–ii–V: Cmaj7, Am7, Dm7, G7, y vuelta a empezar. }
  \line { El Am7 es el acorde que añadiste tú en la sesión 7. Izquierda: solo la fundamental. }
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
  \line { \bold "Ejercicio B (lectura de cifrado, 4')" — los acordes de la canción: toca el shell de cada uno con la izquierda. }
  \line { C: Do y Mi (1-3). C7: Do y Si bemol (1-7). F: Fa y La (1-3). G7: Sol y Fa (1-7). }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmSaints
     \new Staff \with { \remove "Time_signature_engraver" } \barras >>
  \layout { }
}

\markup \column {
  \vspace #1
  \line { \bold "Canción (7')" — «When the Saints Go Marching In». La melodía no sale de la posición de Do. }
  \line { Primero la derecha sola y cantando; luego juntas, empezando a 72. Cada frase empieza en el pulso 2. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmSaints
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 96 }
}
