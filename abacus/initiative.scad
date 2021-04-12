
//
// initiative.scad
//

$fn=6;

use <cadence.scad>;


// unit is mm


baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center
//holdis1 = baldia * 1.3;
//trkdis = baldia * 1.11; // distance between the two tracks

rad = 3.5 * baldia;
//echo(rad * 2);

twi = 2.8; // track width

hei = 4.2; // height

out = rad * 0.65; // outcentering...


module base() {
  difference() {
    cylinder(d = rad * 2.1 + baldia, h=hei, $fn=12);
    translate([ 0, 0, - hei * 0.5 ])
      cylinder(d=rad * 1.60, h=hei * 2, $fn=12);
  }
  //translate([ 0, 0, hei * 0.5 ])
  //  cube(size=[ baldia * 2, rad * 2, hei ], center=true);
  //module paslice(radius, depth, slice=45, radius1=0) {
  translate([ out, 0, 0 ]) // that's the center of rotation ....
    rotate([ 0, 0, 60 + 90 + 12 ])
      paslice(rad * 1.2, hei, 145, rad * 0.6, $fn=36);
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

  // minute holes

  mins = 30;
  md = 360 / mins;

  for (i = [0:mins - 2]) {

    a = - i * md;

    rotate([ 0, 0, a ]) translate([ rad, 0, 0 ]) cyl(a);
    rotate([ 0, 0, a ]) translate([ rad * 0.99, 3.3, 0 ]) canal();

    if ((i + 1) % 5 == 0) {

      rotate([ 0, 0, a ]) translate([ rad * 0.80, 0, hei * 0.6 ])
        rotate([ 0, 0, -73 ])
          linear_extrude(hei * 0.6) text(str(i + 1), size=5.6);
    }
  }

  translate([ out, 0, 0 ]) { // that's the center of rotation ....

    dd = 360 / 30;

    for(i = [0:8]) {
      a = 90 + 45 - 3.0 + i * dd;
      rotate([ 0, 0, a ]) translate([ rad * 1.05, 0, 0 ]) cyl(a);
      rotate([ 0, 0, a ]) translate([ rad * 1.05 - holdis, 0, 0 ]) cyl(a);
    }
  }
}

