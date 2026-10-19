\version "2.24.0"
\header {
  title = "Blues en Do — guide tones en negras"
  subtitle = "Sesión 3 · Jazz"
  tagline = ##f
}
#(set-global-staff-size 17)
\paper { #(set-paper-size "a4") indent = 0 }

% Ejercicio A: cambios sueltos entre acordes
harmA = \chordmode {
  c2:7 f:7 | c:7 f:7 | c:7 g:7 | c:7 g:7 | f:7 g:7 | f:7 g:7 | c:7 f:7 | c1:7
}
rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  <e-1 bes-4>2 <ees-1 a-4> | <e-1 bes-4> <ees-1 a-4> |
  <e-1 bes-4> <f-1 b-4> | <e-1 bes-4> <f-1 b-4> | \break
  <ees-1 a-4> <f-1 b-4> | <ees-1 a-4> <f-1 b-4> |
  <e-1 bes-4> <ees-1 a-4> | <e-1 bes-4>1 \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  c2-5 f, | c f, | c g, | c g, | f, g, | f, g, | c f, | c1 \bar "|."
}

% Blues de 12 compases (ejercicios B y C)
harmBlues = \chordmode {
  c1:7 f:7 c:7 c:7 f:7 f:7 c:7 c:7 g:7 f:7 c:7 g:7
}
barras = {
  \clef treble \key c \major \time 4/4
  \improvisationOn
  \repeat unfold 4 { b'4 b' b' b' | } \break
  \repeat unfold 4 { b'4 b' b' b' | } \break
  \repeat unfold 4 { b'4 b' b' b' | }
  \improvisationOff \bar "|."
}

cSiete = \fixed c' { <e-1 bes-4>4-. <e bes>-. <e bes>-. <e bes>-. }
fSiete = \fixed c' { <ees-1 a-4>4-. <ees a>-. <ees a>-. <ees a>-. }
gSiete = \fixed c' { <f-1 b-4>4-. <f b>-. <f b>-. <f b>-. }
rhC = {
  \clef treble \key c \major \time 4/4 \tempo "Swing" 4 = 60
  \cSiete | \fSiete | \cSiete | \cSiete | \break
  \fSiete | \fSiete | \cSiete | \cSiete | \break
  \gSiete | \fSiete | \cSiete | \gSiete \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  c1-5 | f, | c | c | f, | f, | c | c | g, | f, | c | g, \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — siempre dedos 1 y 4 en la derecha: la mano no cambia de forma, solo se desliza. }
  \line { De C7 a F7 baja medio tono; de C7 a G7 sube medio tono. Muévete sin mirar el teclado. }
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
  \line { \bold "Ejercicio B (lectura de cifrado, 4')" — aquí no hay notas: lee el acorde y toca tú }
  \line { las guide tones (derecha, 1–4) y la fundamental (izquierda, 5), una redonda por compás. }
  \line { Di el nombre del acorde en voz alta antes de tocarlo. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new Staff \with { \remove "Time_signature_engraver" } \barras >>
  \layout { }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio C (blues, 7')" — guide tones en negras cortas. Metrónomo a 60 en los pulsos 2 y 4 si puedes; }
  \line { cuando salga tres veces seguidas sin parar, súbelo de 4 en 4. }
  \vspace #0.5
}
\score {
  << \new ChordNames \harmBlues
     \new PianoStaff << \new Staff \rhC \new Staff \lhC >> >>
  \layout { }
  \midi { \tempo 4 = 60 }
}
