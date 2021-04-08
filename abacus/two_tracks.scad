
$fn=6;

// unit is mm

baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center
holdis1 = baldia * 1.5;
trkdis = baldia * 1.2; // distance between the two tracks
cen2bor = holdia * 0.6; // center to border top

delta = holdia / 2;

len0 = cen2bor + 1 * holdis + holdis1 + 4 * holdis + cen2bor;
wid0 = cen2bor + trkdis + cen2bor;

len1 = len0 + delta * 2;
wid1 = wid0 + delta * 2;

hei = 12; // height
thk = 2.5; // thickness

twi = 4; // track width
swi = 1.1; // slit width

sla = -10; // slit angle


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

h4 = hei / 4;
l9 = len1 / 5;

module cyl() {
  translate([ 0, 0, -h4 ]) cylinder(d=holdia, h=hei * 2);
}
module cub() {
  translate([ 0, 0, h4 ]) cube(size=[ holdis, twi, hei * 2 ], center=true);
}
module tooth() {
  translate([ 0, 0, -h4 ]) cube(l9, center=false);
}

dc = delta + cen2bor;
dch2 = dc + holdis / 2;
dch3 = dch2 + holdis + holdis1;
s1 = dc + holdis + holdis1;

difference() {

  base();
  translate([ 0, 0, -thk ]) base();

  // slit

  translate([ cen2bor * 0.63, wid1 / 2, hei + thk ])
    rotate([ 0, sla, 0 ])
      cube(size=[ swi, wid1, hei * 2 ], center=true);

  // holes

  translate([ dc, dc, 0 ]) cyl();
  translate([ dc + holdis, dc, 0 ]) cyl();

  translate([ s1 + 0 * holdis, dc, 0 ]) cyl();
  translate([ s1 + 1 * holdis, dc, 0 ]) cyl();
  translate([ s1 + 2 * holdis, dc, 0 ]) cyl();
  translate([ s1 + 3 * holdis, dc, 0 ]) cyl();
  translate([ s1 + 4 * holdis, dc, 0 ]) cyl();

  translate([ dc, dc + trkdis, 0 ]) cyl();
  translate([ dc + holdis, dc + trkdis, 0 ]) cyl();

  translate([ s1 + 0 * holdis, dc + trkdis, 0 ]) cyl();
  translate([ s1 + 1 * holdis, dc + trkdis, 0 ]) cyl();
  translate([ s1 + 2 * holdis, dc + trkdis, 0 ]) cyl();
  translate([ s1 + 3 * holdis, dc + trkdis, 0 ]) cyl();
  translate([ s1 + 4 * holdis, dc + trkdis, 0 ]) cyl();

  // tracks

  translate([ dch2, dc, 0 ]) cub();
  translate([ dch2, dc + trkdis, 0 ]) cub();

  translate([ dch3 + 0 * holdis, dc, 0 ]) cub();
  translate([ dch3 + 1 * holdis, dc, 0 ]) cub();
  translate([ dch3 + 2 * holdis, dc, 0 ]) cub();
  translate([ dch3 + 3 * holdis, dc, 0 ]) cub();

  translate([ dch3 + 0 * holdis, dc + trkdis, 0 ]) cub();
  translate([ dch3 + 1 * holdis, dc + trkdis, 0 ]) cub();
  translate([ dch3 + 2 * holdis, dc + trkdis, 0 ]) cub();
  translate([ dch3 + 3 * holdis, dc + trkdis, 0 ]) cub();

  // TODO separation between fives and ones

  // teeth

  ty0 = -l9 * 0.8;
  translate([ 0 * l9, ty0, 0 ]) tooth();
  translate([ 2 * l9, ty0, 0 ]) tooth();
  translate([ 4 * l9, ty0, 0 ]) tooth();
  ty1 = -l9 * 0.7 + wid1 + l9 / 2;
  translate([ 1 * l9, ty1, 0 ]) tooth();
  translate([ 3 * l9, ty1, 0 ]) tooth();
}

