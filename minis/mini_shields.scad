
//
// minis_shields.scad
//


module tear_shield(height, width) {

  d = 1; // depth

  rotate([ 270, 0, 0 ])
    hull() {
      translate([ 0, 0, 0 ])
        cylinder(d=width, h=d, center=true);
      translate([ 0, height, 0 ])
        cylinder(d=d, h=d, center=true);
    }
};

module round_shield(diameter) {

  dm = diameter;
  dp = 1; // depth

  rotate([ 270, 0, 0 ])
    union() {
      cylinder(d=dm, h=dp, center=true);
      translate([ 0, 0, -0.5 ])
      difference() {
        sphere(dm / 10);
        translate([ 0, 0, -dm / 8 ]) cube(dm / 3, center=true);
      }
    }
};

