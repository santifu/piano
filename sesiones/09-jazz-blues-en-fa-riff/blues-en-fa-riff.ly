\version "2.24.0"
\header {
  title = "Blues en Fa con riff"
  subtitle = "Sesión 9 · Jazz"
  tagline = ##f
}
#(set-global-staff-size 17)
\paper { #(set-paper-size "a4") indent = 0 }

% El riff sobre cada acorde: fundamental, 3ª menor → 3ª mayor, 5ª, 3ª
riffF  = \fixed c' { f4-1 aes8-2 a-3 c'4-5 a-3 }
riffBb = \fixed c  { bes4-1 des'8-2 d'-3 f'4-5 d'-3 }
riffC  = \fixed c' { c4-1 ees8-2 e-3 g4-5 e-3 }

% A: el riff en los tres acordes, solo la derecha
harmA = \chordmode { f1:7 f:7 bes:7 bes:7 c:7 c:7 f:7 f:7 }
rhA = {
  \clef treble \key f \major \time 4/4
  \riffF | \riffF | \riffBb | \riffBb | \break
  \riffC | \riffC | \riffF | \fixed c' { f1-1 } \bar "|."
}

% B: blues en Fa, solo cifrado
harmBlues = \chordmode {
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

% C: blues completo, shells en la izquierda y riff en la derecha
rhC = {
  \clef treble \key f \major \time 4/4 \tempo "Swing" 4 = 80
  \riffF | \riffBb | \riffF | \riffF | \break
  \riffBb | \riffBb | \riffF | \riffF | \break
  \riffC | \riffBb | \riffF | \riffC \bar "|."
}
lhC = \fixed c {
  \clef bass \key f \major \time 4/4
  <f,-5 ees-1>1 | <bes,-5 d-3> | <f, ees> | <f, ees> |
  <bes, d> | <bes, d> | <f, ees> | <f, ees> |
  <c-5 e-3> | <bes, d> | <f, ees> | <c e> \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — el riff es la misma forma de mano sobre cada acorde: 1, 2-3 (corcheas), 5, 3. }
  \line { El 2 toca la 3ª menor y resbala al 3 en la 3ª mayor: es la «nota azul». Corcheas en swing: larga-corta. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmA
     \new Staff \rhA >>
  \layout { }
  \midi { \tempo 4 = 80 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura de cifrado, 4')" — blues en Fa: lee el acorde y toca su shell con la izquierda, }
  \line { una redonda por compás. F7: Fa y Mi bemol (1-7). Bb7: Si bemol y Re (1-3). C7: Do y Mi (1-3). }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new Staff \with { \remove "Time_signature_engraver" } \barras >>
  \layout { }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio C (blues, 7')" — las dos manos: shell abajo, riff arriba. Empieza a 60 y sube a 80 }
  \line { cuando salga entero. La izquierda cae en el pulso 1 de cada compás; la derecha no se para. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 80 }
}
