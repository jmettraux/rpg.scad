
$fn=6;

// unit is mm


baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center
//holdis1 = baldia * 1.3;
//trkdis = baldia * 1.11; // distance between the two tracks

rad = 3.5 * baldia;

twi = 2.8; // track width

hei = 4.2; // height


module base() {
  cylinder(d = rad * 2.1 + baldia, h=hei, $fn=12);
}
module cyl(a) {
  translate([ 0, 0, - hei * 0.5 ])
    rotate([ 0, 0, -a ])
      cylinder(d=holdia, h=hei * 2);
}
module canal() {
  translate([ 0, 0, hei * 0.9 ])
    cube(size=[ twi, baldia, hei * 0.5 ], center=true);
}

difference() {

  base();

  // hollow center

  translate([ 0, 0, - hei * 0.5 ])
    cylinder(d=rad * 1.70, h=hei * 2, $fn=12);

  // minute holes

  mins = 30;
  md = 360 / mins;

  for (i = [0:mins - 2]) {
    a = i * md;
    rotate([ 0, 0, a ]) translate([ rad, 0, 0 ]) cyl(a);
    rotate([ 0, 0, a ]) translate([ rad * 0.99, 3.3, 0 ]) canal();
  }

  // 12

  //translate([ hourrad * 0.8, -3.3, hei * 0.6 ]) rotate([ 0, 0, -90 ])
  //  linear_extrude(hei * 0.6) text("12", size=6.1);
}
