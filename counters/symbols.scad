
//
// chexes.scad
//

// unit is mm

//a = 0; x = -7; y = -7; symbol = "\u25BC"; size = 16; // head down triangle

sz = 9;

//symbols = [ [ 0, "\u2190" ], [ 1, "\u2191" ], [ 2, "\u2192" ], [ 3, "\u2193" ], [ 4, "\u2194" ], [ 5, "\u2195" ] ]; // arrows
//symbols = [ [ 0, "\u263a" ], [ 1, "\u263b" ], [ 2, "\u263c" ], [ 3, "\u2640" ], [ 4, "\u2642" ], [ 5, "\u2660" ], [ 6, "\u2663" ], [ 7, "\u2665" ], [ 8, "\u2666" ], [ 9, "\u266a" ], [ 10, "\u266b" ], [ 11, "\u266f" ] ]; // miscellaneous symbols
//symbols = [ [ 0, "\u2202" ], [ 1, "\u2206" ], [ 2, "\u2211" ], [ 3, "\u2212" ], [ 4, "\u2215" ], [ 5, "\u2219" ], [ 6, "\u221a" ], [ 7, "\u221e" ], [ 8, "\u221f" ], [ 9, "\u2229" ], [ 10, "\u222b" ], [ 11, "\u2248" ], [ 12, "\u2249" ], [ 13, "\u2260" ], [ 14, "\u2261" ], [ 15, "\u2262" ], [ 16, "\u2264" ], [ 17, "\u2265" ], [ 18, "\u226e" ], [ 19, "\u226f" ], [ 20, "\u2270" ], [ 21, "\u2271" ] ]; // mathematical operators
//symbols = [ [ 0, "\u2302" ], [ 1, "\u2310" ], [ 2, "\u2320" ], [ 3, "\u2321" ] ]; // misc technical
//symbols = []; // dingbats
//symbols = []; // runes

for (is = symbols) {
  t = str(is[0], " ", is[1]);
  echo(t);
  translate([ 0, is[0] * 10, 0 ]) linear_extrude(5) text(t, size=sz);
}

