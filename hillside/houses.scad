
//
// houses.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
br = 1.7; // ball radius
o2 = 0.2;
m = inch / 1.5;


module balcyl(deeper=false) {

  h = deeper ? br * 2.8 + o2 : br * 2 + o2;
  dz = deeper ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module celtic_base(diameter, height, width) {

  r = diameter / 2;
  dw = height / 2;
  w2 = width / 2;
  w4 = width * 4;

  difference() {

    paslice(r, height, slice=180, radius1=r - width, $fn=16);

    translate([ 0, - r + 2, height / 3 ]) rotate([ 90, 0, 0 ])
      cylinder(r=dw, h=w4, center=true, $fn=36);
    translate([ 0, -r + 2, 0 ])
      cube(size=[ dw * 2, w4, height / 1.4 ], center=true);

    #translate([ 0, -0, 0 ]) {

      h0 = br + 3.5 * o2;
      h1 = height * 0.94 - o2;
      l = r - w2 - o2;

      for (a = [ -5 ]) {
        rotate([ 0, 0, a ]) translate([ 0, l, h0 ]) balcyl(false);
      }
      for (a = [ -5, 185 ]) {
        rotate([ 0, 0, a ]) translate([ 0, l, h1 ]) balcyl(true);
      }
    }
  }
}

celtic_base(3 * inch, 2 * m, 5 + 4 * o2);

