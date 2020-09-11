
//
// minilib.scad
//

// unit is mm

module base(diameter=25, thickness=3, arrow_base=7, fn=12) {

  d_2 = diameter / 2;
  ab_2 = arrow_base / 2;
  t12 = 1.2 * thickness;

  translate([ 0, 0, - thickness / 2 ]) // place base just under horizon
    difference() {

      // base
      cylinder(d=diameter, h=thickness, center=true, $fn=fn);

      // arrow
      translate([ 0, d_2 - 1.2 * ab_2, -0.5 * t12 ])
        linear_extrude(t12)
          polygon([ [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
    }
}

