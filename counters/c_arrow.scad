
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;

ab_2 = arrow_base / 2;
thickness12 = 1.2 * thickness;
diameter_2 = diameter / 2;
fs = 0.4 * arrow_base; // feather side
fs2 = 2 * fs;


difference() {

  union() {
    cylinder(d=diameter, h=thickness, center=true);
  }

  union() {

    translate([ 0, 0, 0 ])
      cube([ slit_width, 0.7 * diameter, thickness12 ], center=true);

    translate([ 0, diameter_2 - 1.2 * ab_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([
          [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);

    translate([ 0, -0.84 * diameter_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([ [ 0, fs ], [ 0, fs2 ], [ fs, fs ], [ fs, 0 ] ]);
    translate([ 0, -0.5 * diameter_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([ [ 0, fs ], [ 0, fs2 ], [ fs, fs ], [ fs, 0 ] ]);

    translate([ 0, -0.84 * diameter_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([ [ 0, fs ], [ 0, fs2 ], [ -fs, fs ], [ -fs, 0 ] ]);
    translate([ 0, -0.5 * diameter_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([ [ 0, fs ], [ 0, fs2 ], [ -fs, fs ], [ -fs, 0 ] ]);
  }
}

