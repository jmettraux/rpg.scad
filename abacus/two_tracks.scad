
$fn=6;

// unit is mm

holdia = 10; // hole diameter
holdis = holdia * 1.2; // distance between two adjacent center holes
holdis1 = holdia * 1.4;
cen2bor = holdia * 1.1; // center to border top

delta = holdia / 2;

len0 = cen2bor + 1 * holdis + holdis1 + 4 * holdis + cen2bor;
wid0 = cen2bor + holdis1 + cen2bor;

len1 = len0 + delta * 2;
wid1 = wid0 + delta * 2;

hei = 10; // height
thk = 2; // thickness


module base() {
  points = [
    /* 0 */ [ 0, 0, 0 ],
    /* 1 */ [ len1, 0, 0 ],
    /* 2 */ [ len1, wid1, 0 ],
    /* 3 */ [ 0, wid1, 0 ],
    /* 4 */ [ delta, delta, hei ],
    /* 5 */ [ len0 + delta, delta, hei ],
    /* 6 */ [ len0 + delta, wid0 + delta, hei ],
    /* 7 */ [ delta, wid0 + delta, hei ]
  ];
  faces = [
    [ 0, 1, 2, 3 ], // bottom
    [ 4, 5, 1, 0 ], // front
    [ 7, 6, 5, 4 ], // top
    [ 5, 6, 2, 1 ], // right
    [ 6, 7, 3, 2 ], // back
    [ 7, 4, 0, 3 ]  // left
  ];
  polyhedron(points, faces);
}
module cyl() {
  cylinder(d=holdia, h=hei * 2);
}

dc = delta + cen2bor;
h4 = -hei / 4;
s1 = dc + holdis + holdis1;

difference() {

  base();
  translate([ 0, 0, -thk ]) base();

  // TODO slit for card

  translate([ dc, dc, h4 ]) cyl();
  translate([ dc + holdis, dc, h4 ]) cyl();

  translate([ s1 + 0 * holdis, dc, h4 ]) cyl();
  translate([ s1 + 1 * holdis, dc, h4 ]) cyl();
  translate([ s1 + 2 * holdis, dc, h4 ]) cyl();
  translate([ s1 + 3 * holdis, dc, h4 ]) cyl();
  translate([ s1 + 4 * holdis, dc, h4 ]) cyl();

  translate([ dc, dc + holdis1, h4 ]) cyl();
  translate([ dc + holdis, dc + holdis1, h4 ]) cyl();

  translate([ s1 + 0 * holdis, dc + holdis1, h4 ]) cyl();
  translate([ s1 + 1 * holdis, dc + holdis1, h4 ]) cyl();
  translate([ s1 + 2 * holdis, dc + holdis1, h4 ]) cyl();
  translate([ s1 + 3 * holdis, dc + holdis1, h4 ]) cyl();
  translate([ s1 + 4 * holdis, dc + holdis1, h4 ]) cyl();

  // TODO tracks between holes
  // TODO separation between fives and ones
}

