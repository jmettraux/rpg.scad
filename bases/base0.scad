
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;
support_height = 10;

ab_2 = arrow_base / 2;
thickness12 = 1.2 * thickness;
diameter_2 = diameter / 2;


difference() {

  union() {

    // base

    cylinder(d=diameter, h=thickness, center=true);

    // support

    translate([ 0, 0, 0 ]) difference() {
      translate([ 0, 0, -0.7 * diameter_2 + support_height  ])
        rotate([ 45, 0, 0 ])
          cube([ thickness, diameter_2, diameter_2 ], center=true);
      translate([ 0, 0, -diameter_2 ])
        cube([ diameter, diameter, diameter ], center=true);
    }
    //translate([ thickness, 0, 0 ]) difference() {
    //  translate([ 0, 0, -0.7 * diameter_2 + support_height  ])
    //    rotate([ 45, 0, 0 ])
    //      cube([ thickness, diameter_2, diameter_2 ], center=true);
    //  translate([ 0, 0, -diameter_2 ])
    //    cube([ diameter, diameter, diameter ], center=true);
    //}
  }

  union() {

    // slit

    #translate([ 0, 0, diameter_2 + 0.0 * thickness ])
      cube([ diameter, slit_width, diameter ], center=true);

    // arrow

    translate([ 0, diameter_2 - 1.2 * ab_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([
          [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
  }
}

