
//
// minidoll2.scad
//

include <minilib.scad>;

// point
//   [ name, inclination, azimuth, distance, parent_name ]

// body_points
//   points: dict

// hull
//  [ point_name_0, diameter_0, pn1, d1, ... ]

// body
//   points: dict
//   hulls: array (point names)

bps = [
  [ "origin", 0, 0, 0, undef ],
  [ "left hip", 45, 45, 3, "origin" ],
  [ "left knee", 60, 60, 7, "left hip" ],
  [ "right hip", 45, -45, 3, "origin" ],
  [ "right knee", 60, -60, 7, "right hip" ],
];

//function _to_point(length, angles, sp=[ 0, 0, 0 ]) =

function bpoint(body_points, name, default=undef)=
  let(
    p = _assoc(body_points, name, default)
  )
  name == "origin" ? [ 0, 0, 0 ] :
  _to_point(p[3], [ p[1], p[2] ], bpoint(body_points, p[4]));

echo(bpoint(bps, "left hip"));

module _bal(p, d) {
  translate(p) sphere(d);
};
_bal(bpoint(bps, "origin"), 1);
_bal(bpoint(bps, "left hip"), 1);
_bal(bpoint(bps, "left knee"), 1);
_bal(bpoint(bps, "right hip"), 1);
_bal(bpoint(bps, "right knee"), 1);

