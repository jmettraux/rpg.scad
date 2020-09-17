
//
// minis_shields.scad
//


module tear_shield(height, width, thickness=1) {

  t = thickness;

  rotate([ 270, 0, 0 ])
    hull() {
      translate([ 0, 0, 0 ])
        cylinder(d=width, h=t, center=true);
      translate([ 0, height, 0 ])
        cylinder(d=d, h=t, center=true);
    }
};

module round_shield(diameter, thickness=1) {

  d = diameter;
  t = thickness;

  rotate([ 270, 0, 0 ])
    union() {
      cylinder(d=d, h=t, center=true);
      translate([ 0, 0, -0.5 ])
      difference() {
        sphere(d / 10);
        translate([ 0, 0, -d / 8 ]) cube(d / 3, center=true);
      }
    }
};

