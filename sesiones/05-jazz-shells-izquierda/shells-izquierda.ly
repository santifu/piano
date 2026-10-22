\version "2.24.0"
\header {
  title = "Shell voicings en la izquierda"
  subtitle = "Sesión 5 · Jazz"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: shells 1-7 solos en la izquierda
harmA = \chordmode {
  c2:7 f:7 | c:7 f:7 | c:7 g:7 | c:7 g:7 | f:7 g:7 | f:7 g:7 | c:7 f:7 | c1:7
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  <c-5 bes-1>2 <f,-5 ees-1> | <c-5 bes-1> <f,-5 ees-1> |
  <c-5 bes-1> <g,-5 f-1> | <c-5 bes-1> <g,-5 f-1> | \break
  <f,-5 ees-1> <g,-5 f-1> | <f,-5 ees-1> <g,-5 f-1> |
  <c-5 bes-1> <f,-5 ees-1> | <c-5 bes-1>1 \bar "|."
}

% Blues de 12 compases
harmBlues = \chordmode {
  c1:7 f:7 c:7 c:7 f:7 f:7 c:7 c:7 g:7 f:7 c:7 g:7
}
barras = {
  \clef bass \key c \major \time 4/4
  \improvisationOn
  \repeat unfold 4 { d4 d d d | } \break
  \repeat unfold 4 { d4 d d d | } \break
  \repeat unfold 4 { d4 d d d | }
  \improvisationOff \bar "|."
}

% C: blues con shells (izquierda) y la 3ª (derecha)
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Swing" 4 = 60
  e1-1 | a-4 | e-1 | e | \break
  a-4 | a | e-1 | e | \break
  b-4 | a | e-1 | b-4 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  <c-5 bes-1>1 | <f,-5 ees-1> | <c bes> | <c bes> |
  <f, ees> | <f, ees> | <c bes> | <c bes> |
  <g,-5 f-1> | <f, ees> | <c bes> | <g, f> \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — solo la izquierda: fundamental con el 5 y 7ª con el pulgar. }
  \line { La mano no cambia de forma, solo se mueve. Sin mirar el teclado en cuanto puedas. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmA
     \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura de cifrado, 4')" — lee el acorde y toca su shell 1-7 con la izquierda, }
  \line { una redonda por compás. Di en voz alta la fundamental y la 7ª antes de tocar: «C7: Do y Si bemol». }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new Staff \with { \remove "Time_signature_engraver" } \barras >>
  \layout { }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio C (blues, 7')" — izquierda: el shell. Derecha: solo la 3ª del acorde. Juntas suenan }
  \line { fundamental, 3ª y 7ª: el acorde completo de jazz. Primero cada mano sola, luego juntas a 60. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 60 }
}
