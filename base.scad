
$fn=12;

// unit is mm

diameter = 23;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;

ab_2 = arrow_base / 2;
thickness12 = 1.2 * thickness;
diameter_2 = diameter / 2;


difference() {

  union() {
    cylinder(d=diameter, h=thickness, center=true);
  }

  union() {

    translate([ thickness, 0, 0 ])
      cube([ diameter, slit_width, thickness12 ], center=true);

    translate([ 0, diameter_2 - 1.2 * ab_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([
          [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
  }
}

