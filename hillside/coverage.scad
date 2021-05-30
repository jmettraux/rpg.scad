
//
// coverage.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
o2 = 0.2;
td = 5 * 2; // trunk diameter

in2 = inch / 2;
k0 = 5 + 2 * o2;
k1 = 5 + td / 2 + 2 * o2;

rr = inch / 20;

module bal() { sphere(r=rr, $fn=12); }
module notch() { paslice(k1, k0, slice=90); }

module trunk(height) {
}

module pyramidal(diameter, height) {
  r = diameter / 2;
  td1 = td + 3 * o2;
  h1 = height * 0.7;
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
      for (h2 = [ in2 : inch : h1 ]) {
        rotate([ 0, 0, 0 ])
          translate([ 0, 0, h2 ]) notch();
      }
      for (h2 = [ inch : inch : h1 ]) {
        //rotate([ 0, 0, -90 ])
        rotate([ 0, 0, 0 ])
          translate([ 0, 0, h2 ]) notch();
      }
    }
  }
}

pyramidal(3 * inch, 4 * inch);

