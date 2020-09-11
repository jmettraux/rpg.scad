
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
arrow_base = 7;

diameter_2 = diameter / 2;
d2 = diameter / 2;
thickness12 = 1.2 * thickness;
fs = 0.4 * arrow_base; // feather side
fs2 = 2 * fs;


difference() {

  union() {

    cylinder(d=diameter, h=thickness, center=true);
  }

  translate([ -diameter / 7, -0.07 * diameter, 0 ]) scale([ 0.77, 0.77, 1 ])
    union() {

        d = diameter / 6;
        s = diameter / 12;

        translate([ 0, 0, -0.5 * thickness12 ])
          linear_extrude(thickness12)
            polygon([
              [ s, 0 ], [ s, s ], [ 0, 2.7 * d ],
              [ -s, s ], [ -s, 0 ], [ 0, -1.2 * d ] ]);

        translate([ 0, -0.84 * diameter_2, -0.5 * thickness12 ])
          linear_extrude(thickness12)
            polygon([ [ 0, fs ], [ 0, fs2 ], [ fs, fs ], [ fs, 0 ] ]);
        translate([ 0, -0.84 * diameter_2, -0.5 * thickness12 ])
          linear_extrude(thickness12)
            polygon([ [ 0, fs ], [ 0, fs2 ], [ -fs, fs ], [ -fs, 0 ] ]);
    }
}

