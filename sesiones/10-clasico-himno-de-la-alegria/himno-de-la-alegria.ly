\version "2.24.0"
\header {
  title = "Himno de la alegría"
  subtitle = "Sesión 10 · Clásico · L. van Beethoven (1824), arreglo sencillo"
  tagline = ##f
}
#(set-global-staff-size 18)
\paper { #(set-paper-size "a4") indent = 0 }

% A: negra con puntillo, movimiento contrario
rhA = \fixed c' {
  \clef treble \key c \major \time 4/4
  c4.-1 d8-2 e4.-3 f8-4 | g4.-5 f8 e4. d8 | c1-1 \bar "|."
}
lhA = \fixed c {
  \clef bass \key c \major \time 4/4
  g4.-1 f8-2 e4.-3 d8-4 | c4.-5 d8 e4. f8 | g1-1 \bar "|."
}

% B: lectura con negra con puntillo, mano derecha
rhB = \fixed c' {
  \clef treble \key c \major \time 4/4
  e4.-3 f8 g4 e | d4. e8 c2 | e4. f8 g4 g | f4. e8 d2 | \break
  e4. d8 c4 e | d4. c8 d2 | e4 f g-5 e | c1-1 \bar "|."
}

% Pieza: tema del «Himno de la alegría» (Novena sinfonía, dominio público)
rhC = \fixed c' {
  \clef treble \key c \major \time 4/4 \tempo "Allegro moderato" 4 = 72
  e4-3 e f g-5 | g f e d | c-1 c d e | e4.-3 d8 d2 | \break
  e4-3 e f g-5 | g f e d | c-1 c d e | d4.-2 c8 c2 \bar "|."
}
lhC = \fixed c {
  \clef bass \key c \major \time 4/4
  c1-5 | g-1 | c | g | c | g | c | g2 c-5 \bar "|."
}

\markup \column {
  \line { \bold "Ejercicio A (técnica, 3')" — la negra con puntillo dura un pulso y medio; la corchea que la sigue, medio. }
  \line { Cuenta «UN-o-y DOS» en voz alta. Manos juntas en movimiento contrario, como ya sabes. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhA \new Staff \lhA >>
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Ejercicio B (lectura, 4')" — solo la derecha, en posición de Do. La corchea siempre cae en el «y» }
  \line { del segundo pulso: no la adelantes. Si dudas, da palmas el ritmo antes de tocar. }
  \vspace #0.5
}
\score {
  \new Staff \rhB
  \layout { }
  \midi { \tempo 4 = 60 }
}

\markup \column {
  \vspace #1
  \line { \bold "Canción (7')" — el «Himno de la alegría». Seguro que la reconoces en cuanto toques los primeros }
  \line { compases. Primero la derecha sola; luego juntas. Fíjate: los compases 5–7 repiten los 1–3. }
  \vspace #0.5
}
\score {
  \new PianoStaff << \new Staff \rhC \new Staff \lhC >>
  \layout { }
  \midi { \tempo 4 = 72 }
}
