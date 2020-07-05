
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;
support_height = 9;

ab_2 = arrow_base / 2;
ab_4 = arrow_base / 4;
thickness_2 = thickness / 2;
thickness_4 = thickness / 4;
thickness12 = 1.2 * thickness;
diameter_2 = diameter / 2;
diameter_4 = diameter / 4;
diameter_8 = diameter / 8;
sw_2 = slit_width / 2;
sh_2 = support_height / 2;


difference() {

  union() {

    // base

    cylinder(d=diameter, h=thickness, center=true);

    // support

    translate([ 0, thickness_4 + sw_2, thickness_2 + sh_2 ])
      cube([ diameter_4, thickness_2, support_height ], center=true);
    translate([ 0, -thickness_4 - sw_2, thickness_2 + sh_2 ])
      cube([ diameter_4, thickness_2, support_height ], center=true);
  }

  union() {

    // H

    translate([ 0, 0, 0 ])
      cube([ diameter_4, slit_width, thickness12 ], center=true);
    translate([ -diameter_8 - sw_2, -ab_4, 0 ])
      cube([ slit_width, 0.6 * diameter, thickness12 ], center=true);
    translate([ diameter_8 + sw_2, -ab_4, 0 ])
      cube([ slit_width, 0.6 * diameter, thickness12 ], center=true);

    // arrow

    translate([ 0, diameter_2 - 1.2 * ab_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([
          [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
  }
}

