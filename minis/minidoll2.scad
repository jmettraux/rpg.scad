
//
// minidoll2.scad
//

include <minilib.scad>;

// point
//   [ name, inclination, azimuth, distance_ratio, parent_name ]

// body_points
//   points: dict

// hull
//  [ point_name_0, diameter_0, pn1, d1, ... ]

// body
//   points: dict
//   hulls: array (point names)

module _bal(p, d) {
  translate(p) sphere(d);
};

function bpoint(body_points, name, default=undef)=
  let(
    p = _assoc(body_points, name, default),
    h = _get(body_points, "height"),
    hh = h * _get(body_points, "head ratio"),
    l = hh * _get(body_points, p[3])
  )
  name == "origin" ? [ 0, 0, 0 ] :
  _to_point(l, [ p[1], p[2] ], bpoint(body_points, p[4]));


default_humanoid_body = [

  [ "height", 33 ],
  [ "head ratio", 1 / 8 ], // to compute head height

  [ "knee ratio", 2 ],
  [ "ankle ratio", 2 ],
  [ "ball ratio", 0.4 ],
  [ "toe ratio", 0.3 ],
  [ "waist ratio", 1 ],
  [ "back ratio", 1 ],
  [ "shoulder ratio", 3 / 4 ],
  [ "neck ratio", 1 / 4 ],
  [ "elbow ratio", 1.5 ],
  [ "wrist ratio", 1 ],
  [ "hand ratio", 1 / 2 ],

  [ "side hip ratio", 3 / 4 ], // from now on, ratios are head height based
  [ "side waist ratio", 0.7 ],
  [ "side shoulder ratio", 1.1 ],

  [ "l hip", 0, 90, "side hip ratio", "origin" ],
  [ "l knee", -90, 0, "knee ratio", "l hip" ],
  [ "l ankle", -90, 0, "ankle ratio", "l knee" ],
  [ "l ball", 0, 0, "ball ratio", "l ankle" ],
  [ "l toe", 0, 0, "toe ratio", "l ball" ],

  [ "r hip", 0, -90, "side hip ratio", "origin" ],
  [ "r knee", -90, 0, "knee ratio", "r hip" ],
  [ "r ankle", -90, 0, "ankle ratio", "r knee" ],
  [ "r ball", 0, 0, "ball ratio", "r ankle" ],
  [ "r toe", 0, 0, "toe ratio", "r ball" ],

  [ "waist", 90, 0, "waist ratio", "origin" ],
  [ "back", 90, 0, "back ratio", "waist" ],
  [ "shoulder", 90, 0, "shoulder ratio", "back" ],
  [ "neck", 90, 0, "neck ratio", "shoulder" ],

  [ "l waist", 0, 90, "side waist ratio", "waist" ],
  [ "r waist", 0, -90, "side waist ratio", "waist" ],

  [ "l shoulder", 0, 90, "side shoulder ratio", "shoulder" ],
  [ "l elbow", -90, 0, "elbow ratio", "l shoulder" ],
  [ "l wrist", -90, 0, "wrist ratio", "l elbow" ],
  [ "l hand", -90, 0, "hand ratio", "l wrist" ],

  [ "r shoulder", 0, -90, "side shoulder ratio", "shoulder" ],
  [ "r elbow", -90, 0, "elbow ratio", "r shoulder" ],
  [ "r wrist", -90, 0, "wrist ratio", "r elbow" ],
  [ "r hand", -90, 0, "hand ratio", "r wrist" ],
];
//function make_humanoid(entries)=


//
// scaffolding tests...

bps = default_humanoid_body;

color("yellow") _bal(bpoint(bps, "l hip"), 1);
color("yellow") _bal(bpoint(bps, "l knee"), 1);
color("yellow") _bal(bpoint(bps, "l ankle"), 1);
color("yellow") _bal(bpoint(bps, "l ball"), 1);
color("yellow") _bal(bpoint(bps, "l toe"), 1);

color("yellow") _bal(bpoint(bps, "r hip"), 1);
color("yellow") _bal(bpoint(bps, "r knee"), 1);
color("yellow") _bal(bpoint(bps, "r ankle"), 1);
color("yellow") _bal(bpoint(bps, "r ball"), 1);
color("yellow") _bal(bpoint(bps, "r toe"), 1);

color("blue") _bal(bpoint(bps, "origin"), 1);
color("blue") _bal(bpoint(bps, "waist"), 1);
color("blue") _bal(bpoint(bps, "back"), 1);
color("blue") _bal(bpoint(bps, "shoulder"), 1);
color("cyan") _bal(bpoint(bps, "neck"), 1);

color("blue") _bal(bpoint(bps, "l waist"), 1);
color("blue") _bal(bpoint(bps, "r waist"), 1);

color("red") _bal(bpoint(bps, "l shoulder"), 1);
color("red") _bal(bpoint(bps, "l elbow"), 1);
color("red") _bal(bpoint(bps, "l wrist"), 1);
color("red") _bal(bpoint(bps, "l hand"), 1);

color("red") _bal(bpoint(bps, "r shoulder"), 1);
color("red") _bal(bpoint(bps, "r elbow"), 1);
color("red") _bal(bpoint(bps, "r wrist"), 1);
color("red") _bal(bpoint(bps, "r hand"), 1);

