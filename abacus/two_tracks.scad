
$fn=6;

// unit is mm

baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center
holdis1 = baldia * 1.3;
trkdis = baldia * 1.11; // distance between the two tracks
cen2bor = holdia * 0.6; // center to border top

delta = holdia / 2;

len0 = cen2bor + 1 * holdis + holdis1 + 4 * holdis + cen2bor;
wid0 = cen2bor + trkdis + cen2bor;

len1 = len0 + delta * 2;
wid1 = wid0 + delta * 2;

hei = 8.4; // height
thk = 2.5; // thickness

twi = 4.1; // track width
swi = 0.84; // slit width

sla = -10; // slit angle

//hih = 2; // hill height
//hiw = 1.4; // hill thickness

tood = 0.02; // tooth delta, to allow slotting


module base() {
  cube(size=[ len1, wid1, hei ], center=false);
  translate([ len1, wid1 / 2, 0 ]) cylinder(d=wid1, h=hei, $fn=12);
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
  //translate([ 0, 0, -thk ]) base();

  // slit

  translate([ cen2bor * 0.63, wid1 / 2, hei + thk ])
    rotate([ 0, sla, 0 ])
      cube(size=[ swi, wid1 * 1.1, hei * 2 ], center=true);
  translate([ cen2bor * 0.63 - 3.5 * swi, wid1 / 2, hei + thk ])
    rotate([ 0, sla, 0 ])
      cube(size=[ swi, wid1 * 1.1, hei * 2 ], center=true);

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

  // hills
  //#translate([ 0, -ty0, hei ]) cube(size=[ len1, hiw, hih ]);

  // teeth

  ty0 = -l9 * 0.8;
  translate([ 0 * l9, ty0, 0 ]) tooth();
  translate([ 0 * l9 - 1, ty0, 0 ]) tooth(); // cancel ghost border
  translate([ 2 * l9, ty0, 0 ]) tooth();
  translate([ 4 * l9, ty0, 0 ]) tooth();
  translate([ 4.9 * l9, ty0, 0 ]) tooth(); // cancel ghost border

  ty1 = -l9 * 0.7 + wid1 + l9 / 2;

  translate([ 1 * l9, ty1, 0 ]) tooth();
  translate([ 1 * l9 - tood, ty1, 0 ]) tooth(); //
  translate([ 1 * l9 + tood, ty1, 0 ]) tooth(); // allow slotting...

  translate([ 3 * l9, ty1, 0 ]) tooth();
  translate([ 3 * l9 - tood, ty1, 0 ]) tooth(); //
  translate([ 3 * l9 + tood, ty1, 0 ]) tooth(); // allow slotting...
}

