
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;

diameter_2 = diameter / 2;
t2 = thickness / 2;


union() {

  difference() {

    union() {
      cylinder(d=diameter, h=thickness, center=true);
    }

    union() {

      translate([ -0.64 * diameter_2, -0.70 * diameter_2, -thickness ])
        linear_extrude(2 * thickness)
        text("D", size=19);
      translate([ -0.2 * diameter_2, -0.4 * diameter_2, -thickness ])
        linear_extrude(2 * thickness)
        text("\u2665", size=11);
    }
  }

  translate([ -0.1 * diameter_2, -0.6 * diameter_2, 0 ])
    cube([ thickness, thickness, thickness ], center=true);
  translate([ -0.1 * diameter_2, 0.65 * diameter_2, 0 ])
    cube([ thickness, thickness, thickness ], center=true);
  translate([ 0.66 * diameter_2, 0.0 * diameter_2, 0 ])
    cube([ thickness, thickness, thickness ], center=true);
}

