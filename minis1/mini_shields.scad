
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
      translate([ 0, 0, -0.2 ])
      difference() {
        sphere(d * 0.12);
        translate([ 0, 0, -d / 8 ]) cube(d / 3, center=true);
      }
    }
};

module roman_shield(height, width, depth) {

  h = height;
  w = width;
  d = depth;
  t = 0.8;

  cpoints = [ [ 0, 0 ], [ w / 2, d ], [ w, 0 ] ];
  bpoints = _bezier_points(cpoints, 10);
  bpoints1 = [ for (p = bpoints) p + [ 0, t ] ];

  ps = concat(bpoints, _reverse(bpoints1));
  linear_extrude(height=h) polygon(ps);

  translate([ w / 2, d * 0.7, h / 2 ])
    rotate([ -90, 0, 0 ])
      dome(radius=1.14);
};

