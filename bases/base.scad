
$fn=12;

// unit is mm

size = 1;
  // 0.5 tiny / 1 small/medium / 2 large / 3 huge / 4 gargantuan
support_height = 9;
  // the height of the "clench", 9mm for ground creature, >20mm for flying

thickness = 3;        // the height of the base
slit_width = 1.0;    // used 0.8 initially, 1.0 or 1.1 should be better
hratio = 0.6;         // "H" height vs diameter

arrow_base = size < 1 ? 2 : 7;  // the x width of the "front" indicating arrow
diameter = size * 25; // medium is thus 25mm

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

  union() { // adding

    // base

    cylinder(d=diameter, h=thickness, center=true);

    // support

    translate([ 0, thickness_4 + sw_2, thickness_2 + sh_2 ])
      cube([ diameter_4, thickness_2, support_height ], center=true);
    translate([ 0, -thickness_4 - sw_2, thickness_2 + sh_2 ])
      cube([ diameter_4, thickness_2, support_height ], center=true);
  }

  union() { // removing

    // H

    translate([ 0, 0, 0 ])
      cube([ 1.1 * diameter_4, slit_width, thickness12 ], center=true);
    translate([ -diameter_8 - sw_2, -ab_4, 0 ])
      cube([ slit_width, hratio * diameter, thickness12 ], center=true);
    translate([ diameter_8 + sw_2, -ab_4, 0 ])
      cube([ slit_width, hratio * diameter, thickness12 ], center=true);

    // arrow

    translate([ 0, diameter_2 - 1.2 * ab_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        polygon([
          [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
  }
}

