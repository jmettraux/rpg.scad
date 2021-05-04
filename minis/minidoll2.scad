
//
// minidoll2.scad
//

include <minilib.scad>;


module _bal(p, d) {
  translate(p) sphere(d);
};

function bpoints(body_points)=
  [ for (p = body_points) if (len(p) > 2) bpoint(body_points, p[0]) ];

function _bpoint_z(body_points)=
  - min([ for (p = bpoints(body_points)) p.z ]);

function _bpoint_hh(body_points)=
    _get(body_points, "height") * _get(body_points, "head height ratio");

  // [ "r thigh", "r knee", 0.5 ],
  //   [ "r knee", -90, 0, "knee ratio", "r hip" ],
  //
function _bpoint_lin(body_points, p)=
  let(
    p1 = _assoc(body_points, p[1]),
    p0 = bpoint(body_points, p1[4]), // p1's parent
    l1 = _bpoint_hh(body_points) * _get(body_points, p1[3])
  )
  _to_point(l1 * p[2], [ p1[1], p1[2] ], p0);

  // [ "l chop", "l waist", "l shoulder", 3 ],
function _bpoint_mid(body_points, p)=
  let(
    p1 = bpoint(body_points, p[1]),
    p2 = bpoint(body_points, p[2]),
    sx = _to_spherical(p2 - p1)
  )
  _to_point(sx[0] * p[3], sx[1], p1);

function _bpoint_v1(body_points, pname)= // when receiving one point name
  let(
    p0name = _assoc(body_points, pname)[4],
    p0 = bpoint(body_points, p0name),
    p = bpoint(body_points, pname)
  )
  p - p0;
function _bpoint_v2(body_points, pnames)= // when receive two point names
  let(
    pa = bpoint(body_points, pnames[0]),
    pb = bpoint(body_points, pnames[1])
  )
  pb - pa;

  // [ "sternum", "back", 0.4, "back", [ "l shoulder", "r shoulder" ] ],
  //
function _bpoint_cross(body_points, p)=
  let(
    p0 = bpoint(body_points, p[1]),
    l = p[2] * _bpoint_hh(body_points),
    v0 = is_string(p[3]) ?
      _bpoint_v1(body_points, p[3]) : _bpoint_v2(body_points, p[3]),
    v1 = is_string(p[4]) ?
      _bpoint_v1(body_points, p[4]) : _bpoint_v2(body_points, p[4]),
    cro = cross(v0, v1),
    ele_dir = _to_spherical(cro)[1]
  )
  _to_point(l, ele_dir, p0);

function _bpoint_point(body_points, p)=
  let(
    r = is_string(p[3]) ? _get(body_points, p[3]) : p[3],
    l = _bpoint_hh(body_points) * r
  )
  _to_point(l, [ p[1], p[2] ], bpoint(body_points, p[4]));

function bpoint(body_points, name, default=undef)=
  let(
    p = _assoc(body_points, name, default),
    s1 = is_string(p[1]),
    s2 = is_string(p[2])
  )
  name == "origin" ? [ 0, 0, 0 ] :
  s1 && len(p) > 4 ? _bpoint_cross(body_points, p) :
  s1 && s2 ? _bpoint_mid(body_points, p) :
  s1 ? _bpoint_lin(body_points, p) :
  name == "z" ? _bpoint_z(body_points) :
  _bpoint_point(body_points, p);

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

    // relative points
  [ "l hip",        0,  90, "side hip ratio", "origin" ],
  [ "l knee",     -90,   0, "knee ratio", "l hip" ],
  [ "l ankle",    -90,   0, "ankle ratio", "l knee" ],
  [ "l ball",       0,   0, "ball ratio", "l ankle" ],
  [ "l toe",        0,   0, "toe ratio", "l ball" ],

  [ "r hip",        0, -90, "side hip ratio", "origin" ],
  [ "r knee",     -90,   0, "knee ratio", "r hip" ],
  [ "r ankle",    -90,   0, "ankle ratio", "r knee" ],
  [ "r ball",       0,   0, "ball ratio", "r ankle" ],
  [ "r toe",        0,   0, "toe ratio", "r ball" ],

  [ "waist",       90,   0, "waist ratio", "origin" ],
  [ "back",        90,   0, "back ratio", "waist" ],
  [ "shoulder",    90,   0, "shoulder ratio", "back" ],
  [ "neck",        90,   0, "neck ratio", "shoulder" ],
  [ "head",        90,   0, "head ratio", "neck" ],

  [ "l waist",      0,  90, "side waist ratio", "waist" ],
  [ "r waist",      0, -90, "side waist ratio", "waist" ],

  [ "l shoulder",   0,  90, "side shoulder ratio", "shoulder" ],
  [ "l elbow",    -90,   0, "elbow ratio", "l shoulder" ],
  [ "l wrist",    -90,   0, "wrist ratio", "l elbow" ],
  [ "l hand",     -90,   0, "hand ratio", "l wrist" ],

  [ "r shoulder",   0, -90, "side shoulder ratio", "shoulder" ],
  [ "r elbow",    -90,   0, "elbow ratio", "r shoulder" ],
  [ "r wrist",    -90,   0, "wrist ratio", "r elbow" ],
  [ "r hand",     -90,   0, "hand ratio", "r wrist" ],


    // line points
  [ "r thigh", "r knee", 0.4 ], // 0.4 between "r knee" and its parent "r hip"
  [ "l thigh", "l knee", 0.4 ], // ...

    // mid points
  [ "r chop", "r waist", "r shoulder", 0.5 ], // right between rwai and rsho...
  [ "l chop", "l waist", "l shoulder", 0.5 ],

    // cross points
  [ "sternum", "back", 0.25, "back", [ "l shoulder", "r shoulder" ] ],

  //[ "r x", 0, 0, 2.5, "r thigh" ], literal ratio
];

function _rework_body_entry(points, entry)=
  let(
    k = entry[0],
    v0 = _assoc(points, k)
  )
  [ for (i = [ 0 : len(v0) - 1 ]) entry[i] == undef ? v0[i] : entry[i] ];

function _merge_body_entry(points, entry)=
  let(
    k = entry[0]
  )
  k == "-" ? _del(points, entry[1]) :
  _assoc(points, k) == undef ? _app(points, entry) :
  _app(points, _rework_body_entry(points, entry));

function _merge_body_entries(points, entries, i=0)=
  entries[i] == undef ? points :
  _merge_body_entries(_merge_body_entry(points, entries[i]), entries, i + 1);


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
//echo(p0, bpoint(body_points, p0));
      color(c) _bal(bpoint(body_points, p0), d);
    }
  }
}

module _draw_hull(body_points, body_hulls, h) {

  dd = _get(body_hulls, "default diameter", 0.7);

  #hull() {
    for (p = h) {
      if ( ! is_string(p))
        _bal(
          bpoint(body_points, p[0]),
          _get(body_hulls, p[1], dd));
    }
  }
}

module _draw_bezier_hull(body_points, body_hulls, h) {

  dd = _get(body_hulls, "default diameter", 0.7);
  bsc = _get(body_hulls, "bezier sample count", 6);

  ps0 = _slist(h, 2);
  ps = [ for (p = ps0) bpoint(body_points, p[0]) ];
  ps1 = _bezier_points(ps, bsc);

  ds = [ ps0[0][1], _slist(ps0, -1)[0][1] ];
  dl = (ds[1] - ds[0]) / (bsc + 1);

  for (i = [ 0 : len(ps1) - 2 ]) {
    #hull() {
      _bal(ps1[i], ds[0] + i * dl);
      _bal(ps1[i + 1], ds[0] + (i + 1) * dl);
    }
  }
}

module draw_body_hulls(body_points, body_hulls) {

  hs = [ for (h = body_hulls) if (is_list(h[2]) || is_list(h[1])) h ];

  for (h = hs) {
    if (h[1] == "bez") {
      _draw_bezier_hull(body_points, body_hulls, h);
    }
    else {
      _draw_hull(body_points, body_hulls, h);
    }
  }
}

default_humanoid_body_hulls = [

    // diameters

    [ "knee diameter", 1 ],
    [ "leg diameter", 1.2 ],
    [ "thigh diameter", 1.4 ],
    [ "hip diameter", 1.2 ],
    [ "shoulder diameter", 1.3 ],
    [ "neck diameter", 1.1 ],
    [ "tail diameter", 1.2 ],
    [ "tail end diameter", 0.2 ],

    // hulls

    [ "l thigh",
      [ "l hip", "leg diameter" ],
      [ "l thigh", "thigh diameter" ],
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
      [ "r thigh", "thigh diameter" ],
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
      [ "sternum", "neck diameter" ],
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
  ];

function _merge_hull_entry(hulls, entry)=
  entry[0] == "?" ? _del(hulls, entry[1]) :
  _app(hulls, entry);

function _merge_hull_entries(hulls, entries, i=0)=
  entries[i] == undef ? hulls :
  _merge_hull_entries(_merge_hull_entry(hulls, entries[i]), entries, i + 1);

function make_humanoid_body_hulls(entries)=
  _merge_hull_entries(default_humanoid_body_hulls, entries);

