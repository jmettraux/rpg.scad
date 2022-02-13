
// magbase.scad
//
// unit is mm

o2 = 0.2;
br = 1.7; // ball radius

module balcyl() {

  hf = 2;
  h = br * hf + o2;

  dz = hf > 2 ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module magbase0(rad, height) {
  difference() {
    union() {
      translate([ rad/2, rad/2, 0 ]) cube([ rad, rad, height ], center=true);
      cylinder(h=height, r=rad, center=true);
    }
    balcyl();
  }
}

magbase0(25/2, 5, $fn=64);

