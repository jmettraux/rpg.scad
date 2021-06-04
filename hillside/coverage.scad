
//
// coverage.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
o2 = 0.2;
bd = 5; // ball diameter

td = 2 * bd; // trunk diameter
in2 = inch / 2;
k0 = bd + 2 * o2;
k1 = bd + td / 2 + 2 * o2;

rr = inch / 20;

module bal() { sphere(r=rr, $fn=12); }
module notch() { paslice(k1, k0, slice=60); }

module trunk(height, reach=inch / 2.1) {

  module root() {

    translate([ 0, 0, -0.4 ]) {

      ps = [
        [ reach, 0, 0 ], [ reach / 4, 0, reach/ 4 ], [ td / 2.8, 0, reach ] ];
      ps1 = _bezier_points(ps, 8);
      polyhulls(ps1) { bal(); }

      for (i = [ 0 : len(ps1) - 2 ])
        hull() {
          translate(ps1[i]) bal();
          translate(ps1[i + 1]) bal();
          translate([ 0, -bd / 2, 0 ]) bal();
          translate([ 0, bd / 2, 0 ]) bal();
        }
    }
  }

  difference() {

    cylinder(d=td, h=height, $fn=8);

    translate([ 0, 0, height - bd / 2 - 2 * o2 ])
      rotate([ 0, 90, 0 ])
        cylinder(d=bd, h=k1 - 2 * o2);
  }

  difference() {

    for (a = [ 0 : 90 : 270 ]) rotate([ 0, 0, a ]) root();

    translate([ 0, 0, -10 / 2 ])
      cube(size=[ 2 * inch, 2 * inch, 10 ], center=true);
  }

  translate([ inch, 0, 0 ]) cylinder(d=bd, h=k1);
}

module pyramidal(diameter, height, h1f=0.8) {
  r = diameter / 2;
  td1 = td + 3 * o2;
  h1 = h1f * height;
  difference() {
    hull()
      union() {
        translate([ 0, 0, height ]) bal();
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) translate([ 0, r - rr, rr ]) bal();
        }
      }
    #union() {
      translate([ 0, 0, -rr ]) cylinder(d=td1, h=h1, $fn=36);
      translate([ 0, -k0 / 2, -rr ]) cube(size=[ k1, k0, h1 ]);
      for (h2 = [ 2 * o2 : in2 : h1 ])
        rotate([ 0, 0, -30 ])
          translate([ 0, 0, h2 ]) notch();
    }
  }
}

//pyramidal(2 * inch, 3.1 * inch, h1f=0.58);

translate([ 2 * inch, 0, 0 ]) trunk(5 * inch);

