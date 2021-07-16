
//
// houses.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
br = 1.7; // ball radius
o2 = 0.2;
m = inch / 1.5;

bch = br * 2.8 + o2;
bpr = br + 6 * o2;


module balcyl(deeper=false) {

  h = deeper ? br * 2.8 + o2 : br * 2 + o2;
  dz = deeper ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module balpole(height) {

  difference() {
    translate([ 0, 0, height / 2 ])
      cylinder(r=bpr, h=height, center=true);
      h0 = 5 * o2;
      h1 = height;
      //#translate([ 0, -5, 0 ]) {
      translate([ 0, 0, bch / 2 + h0 ]) balcyl(true);
      if (height > 2 * br) translate([ 0, 0, h1 - bch / 2 ]) balcyl(true);
      //}
  }
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
  }

  translate([ bpr, r - bpr - 4 * o2, 0 ])
    balpole(height, $fn=36);

  translate([ r - bpr - 4 * o2, 0, 0 ])
    balpole(height, $fn=36);

  bph = 2 * br + 12 * o2;
  translate([ bpr, - r + bpr + 4 * o2, height - bph ])
    balpole(bph, $fn=36);
}

module celtic_roof(diameter, height) {

  difference() {
    cylinder(d1=diameter, d2=0, h=height);
    translate([ 0, 0, -5 * o2 ]) cylinder(d1=diameter, d2=0, h=height);
  }
}

//balpole(2 * m);
//celtic_base(3 * inch, 2 * m, 1);

celtic_roof(3.5 * inch, 2 * inch);

