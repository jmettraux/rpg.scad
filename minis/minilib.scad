
//
// minilib.scad
//

// unit is mm


//
// point base

module base(
  diameter=25,
  thickness=3,
  arrow_base=7, text="", font="helvetica", font_size=6, font_spacing=0.7,
  fn=12) {

  d_2 = diameter / 2;
  ab_2 = arrow_base / 2;
  t12 = 1.2 * thickness;

  translate([ 0, 0, - thickness / 2 ]) // place base just under horizon
    difference() {

      union() {

        // base
        cylinder(d=diameter, h=thickness, center=true, $fn=fn);

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


//
// point methods

  // Accept a single angle instead of [ angle0, angle1 ]
  //
function to_xyz(length, angles, sp=[ 0, 0, 0 ]) =
  let(
    as = is_num(angles) ? [ angles, 0 ] : angles,
    elevation = as[0],
    direction = as[1] + 90
  )
    sp + [
      length * cos(elevation) * cos(direction),
      length * cos(elevation) * sin(direction),
      length * sin(elevation) ];

function to_spherical(point) =
  let(
    l = sqrt(pow(point.x, 2) + pow(point.y, 2) + pow(point.z, 2)),
    ele = asin(point.z / l),
    dir = acos(point.x / (sqrt(pow(point.x, 2) + pow(point.y, 2))))
  ) [ l, [ ele, dir - 90 ] ];

function midpoint(p0, p1, ratio=0.5) =
  let(
    s = to_spherical(p1 - p0)
  )
    to_xyz(ratio * s[0], s[1], p0);

function vlen(vector) =
  sqrt(pow(vector.x, 2) + pow(vector.y, 2) + pow(vector.z, 2));

