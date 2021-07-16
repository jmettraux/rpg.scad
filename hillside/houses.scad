
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

//celtic_base(3 * inch, 2 * m, 1);
//celtic_roof(3.5 * inch, 2 * inch);

module tprism(l, w, h) {

  polyhedron(
    points=[
      [ 0, 0, 0 ], [ l, 0, 0 ], [ l, w, 0 ], [ 0, w, 0 ], [ 0, w, h ],
      [ l, w, h ] ],
    faces=[
      [ 0, 1, 2, 3 ], [ 5, 4, 3, 2 ], [ 0, 4, 5, 1 ], [ 0, 3, 4 ], [ 5,2,1 ] ]
  );
}

module viking_aframe(length, width, height) {

  l0 = length;

  l = length * 0.7;
  w = width / 2;
  h = height;
  wall = 4 * o2;
  tness = wall * 9;

  bph = height * 0.87;

  difference() {
    tprism(l0, w, h);
    translate([ - l0 * 0.05, tness, - wall ]) tprism(l0 * 1.1, w, h);
  }

  ld = (length - l) / 2;

  translate([ ld, 0, 0 ]) difference() {
    tprism(l, w, h);
    translate([ wall, wall / 2, - wall / 2 ])
      tprism(l - wall * 2, w + wall, h - wall);
  }

  // magnet poles

  translate([ ld + bpr, w - bpr, 0 ]) balpole(bph, $fn=36);
  translate([ ld + l - bpr, w - bpr, 0 ]) balpole(bph, $fn=36);

  // door

  dw = inch / 2;
  dh = 1.2 * inch; // 1.79 door height

  #translate([ ld + l, w - dw, 0 ]) cube(size=[ wall, dw, dh ]);
}

viking_aframe(4.2 * inch, 3.5 * inch, 2.4 * inch);

