
//
// chexes.scad
//

// unit is mm

//a = 0; x = -3; y = -7; symbol = "\u2665", size=16); // heart
//a = 0; x = -7; y = -7; symbol = "\u25BC"; size = 16; // head down triangle
//a = 0; x = -7; y = -7; symbol = "\u2660"; size = 16; // spade
//a = 0; x = -7; y = -7; symbol = "\u2663"; size = 16; // club
//a = 0; x = -7; y = -7; symbol = "\u2666"; size = 16; // diamond

sz = 9;

symbols = [ [ 0, "\u2190" ], [ 1, "\u2191" ], [ 2, "\u2192" ], [ 3, "\u2193" ], [ 4, "\u2194" ], [ 5, "\u2195" ] ];

for (is = symbols) {
  t = str(is[0], " ", is[1]);
  echo(t);
  translate([ 0, is[0] * 10, 0 ]) linear_extrude(5) text(t, size=sz);
}


// arrows
symbols = [ [ 0, "\u2190" ], [ 1, "\u2191" ], [ 2, "\u2192" ], [ 3, "\u2193" ], [ 4, "\u2194" ], [ 5, "\u2195" ] ];

