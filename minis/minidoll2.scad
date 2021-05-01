
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

function bpoints(body_points)=
  [ for (p = body_points) if (len(p) > 2) bpoint(body_points, p[0]) ];

function bpoint(body_points, name, default=undef)=
  let(
    p = _assoc(body_points, name, default),
    h = _get(body_points, "height"),
    hh = h * _get(body_points, "head height ratio"),
    l = hh * _get(body_points, p[3])
  )
  name == "origin" ? [ 0, 0, 0 ] :
  name == "z" ? - min([ for (p = bpoints(body_points)) p.z ]) :
  _to_point(l, [ p[1], p[2] ], bpoint(body_points, p[4]));


default_humanoid_body_points = [

  [ "height", 33 ],
  [ "head height ratio", 1 / 8 ], // to compute head height

  [ "side hip ratio", 0.5 ], // from now on, ratios are head height based
  [ "knee ratio", 2 ],
  [ "ankle ratio", 2 ],
  [ "ball ratio", 0.4 ],
  [ "toe ratio", 0.3 ],

  [ "side waist ratio", 0.56 ],

    // origin to waist : 1
    // waist to back : 1
    // back to neck : 1
  [ "waist ratio", 1 ],
  [ "back ratio", 1 ],
  [ "shoulder ratio", 0.5 ],
  [ "neck ratio", 0.4 ],
  [ "head ratio", 0.42 ],

  [ "side shoulder ratio", 1.1 ],
  [ "elbow ratio", 1.5 ],
  [ "wrist ratio", 1 ],
  [ "hand ratio", 0.5 ],

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
  [ "head", 90, 0, "head ratio", "neck" ],

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

function _merge_body_ratio(v0, entry)=
  entry;

function _merge_body_point(v0, entry)=
  let(
    k = entry[0],
    l = len(entry)
  )
  l > 4 ? entry :
  l == 4 ? [ k, entry[1], entry[2], entry[3], v0[4] ] :
  l == 3 ? [ k, entry[1], entry[2], v0[3], v0[4] ] :
  [ k, entry[1], 0, v0[3], v0[4] ];

function _merge_body_entry(points, entry)=
  let (
    k = entry[0],
    v0 = _assoc(points, k)
  )
  _app(
    points,
    k == "height" ? entry :
    _sindex(k, " ratio") ? _merge_body_ratio(v0, entry) :
    _merge_body_point(v0, entry));

function _merge_body_entries(points, entries, i=0)=
  let (
    e = entries[i]
  )
  e == undef ? points :
  _merge_body_entries(_merge_body_entry(points, e), entries, i + 1);


function make_humanoid_body_points(entries)=
  _merge_body_entries(default_humanoid_body_points, entries);


module draw_body_balls(body_points) {

  d = 0.7;

  _bal(bpoint(body_points, "origin"), d);

  for (p = body_points) {
    p0 = p[0];
    if (_sindex(p0, "ratio") == undef && _sindex(p0, "height") == undef) {
      c =
        _sstr(p0, 0, 2) == "l " ? "#0000FF" :
        _sstr(p0, 0, 2) == "r " ? "#FF0000" :
        "yellow";
      color(c) _bal(bpoint(body_points, p0), d);
    }
  }
}

module draw_body_hulls(body_points, body_hulls) {

  hs = [ for (h = body_hulls) if (is_list(h[1])) h ];

  dd = 0.7; // default diameter

  for (h = hs) {
    #hull() {
      for (p = h) {
        if ( ! is_string(p))
          _bal(
            bpoint(body_points, p[0]),
            _get(body_hulls, p[1], dd));
      }
    }
  }
}


//
// scaffolding tests...

$fn=12;

bps = make_humanoid_body_points([
  [ "knee ratio", 2 ],
  [ "hand ratio", 0.5 ],
  [ "r knee", -60 ],
  [ "l knee", -100, -20 ],
  [ "l ankle", -110, -10 ],
    ]);

translate([ 0, 0, bpoint(bps, "z") ])
  draw_body_balls(bps);

translate([ 0, 0, bpoint(bps, "z") ])
  draw_body_hulls(bps, [
    [ "knee diameter", 1 ],
    [ "leg diameter", 1.2 ],
    [ "hip diameter", 1.2 ],
    [ "shoulder diameter", 1.3 ],
    [ "neck diameter", 1.1 ],

    [ "l thigh",
      [ "l hip", "leg diameter" ],
      [ "l knee", "knee diameter" ] ],
    [ "l shin",
      [ "l knee", "knee diameter" ],
      [ "l ankle", "ankle diameter" ] ],
    [ "l palm",
      [ "l ankle", "ankle diameter" ],
      [ "l ball", "ball diameter" ] ],
    [ "l toe",
      [ "l ball", "ball diameter" ],
      [ "l toe", "toe diameter" ] ],

    [ "r thigh",
      [ "r hip", "leg diameter" ],
      [ "r knee", "knee diameter" ] ],
    [ "r shin",
      [ "r knee", "knee diameter" ],
      [ "r ankle", "ankle diameter" ] ],
    [ "r palm",
      [ "r ankle", "ankle diameter" ],
      [ "r ball", "ball diameter" ] ],
    [ "r toe",
      [ "r ball", "ball diameter" ],
      [ "r toe", "toe diameter" ] ],

    [ "basin",
      [ "l hip", "hip diameter" ],
      [ "r hip", "hip diameter" ],
      [ "l waist", "waist diameter" ],
      [ "r waist", "waist diameter" ] ],
    [ "torso",
      [ "l waist", "waist diameter" ],
      [ "r waist", "waist diameter" ],
      [ "l shoulder", "shoulder diameter" ],
      [ "r shoulder", "shoulder diameter" ],
      [ "shoulder", "neck diameter" ],
      [ "neck", "neck diameter" ] ],

    [ "neck",
      [ "neck", "neck diameter" ],
      [ "head", "neck diameter" ] ],

    [ "l arm",
      [ "l shoulder", "shoulder diameter" ],
      [ "l elbow", "elbow diameter" ] ],
    [ "l forearm",
      [ "l elbow", "elbow diameter" ],
      [ "l wrist", "wrist diameter" ] ],
    [ "l hand",
      [ "l wrist", "wrist diameter" ],
      [ "l hand", "hand diameter" ] ],

    [ "r arm",
      [ "r shoulder", "shoulder diameter" ],
      [ "r elbow", "elbow diameter" ] ],
    [ "r forearm",
      [ "r elbow", "elbow diameter" ],
      [ "r wrist", "wrist diameter" ] ],
    [ "r hand",
      [ "r wrist", "wrist diameter" ],
      [ "r hand", "hand diameter" ] ],
  ]);

