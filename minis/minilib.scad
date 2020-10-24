
//
// minilib.scad
//

use <cadence.scad>;


//
// point base

module base(
  diameter=25,
  thickness=3,
  arrow_base=7, text="", font="helvetica", font_size=6, font_spacing=0.7
) {

  d_2 = diameter / 2;
  ab_2 = arrow_base / 2;
  t12 = 1.2 * thickness;

  translate([ 0, 0, - thickness / 2 ]) // place base just under horizon
    difference() {

      union() {

        // base
        cylinder(d=diameter, h=thickness, center=true);

        // text
        translate([ - diameter / 2.6, -diameter / 3, thickness / 2 ])
          linear_extrude(0.7)
            text(text, size=font_size, font=font, spacing=font_spacing);
      }

      // arrow
      translate([ 0, d_2 - 1.2 * ab_2, -0.5 * t12 ])
        linear_extrude(t12)
          polygon([ [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
    }
}

