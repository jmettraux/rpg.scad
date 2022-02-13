
// magbase.scad
//
// unit is mm

o2 = 0.2;
br = 1.7; // ball radius

module balcyl() {

  cylinder(r=br + 2 * o2, h=br * 2 + o2, center=true, $fn=36);
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

module magbase1(rad, height, scale=0.9) {
  difference() {
    translate([ 0, 0, -height / 2 ])
      linear_extrude(height=height, scale=scale) {
        translate([ rad/2, rad/2, 0 ]) square([ rad, rad ], center=true);
        circle(r=rad);
      }
    balcyl();
  }
}

//translate([ 30, 0, 0 ]) magbase0(25/2, 5, $fn=64);
magbase1(25/2, 4, $fn=64);

