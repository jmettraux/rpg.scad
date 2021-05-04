
//
// minidoll2.scad
//

include <minilib.scad>;
include <minidoll2_defaults.scad>;


module _bal(p, d) {
  translate(p) sphere(d);
};

function bpoints(body_points)=
  [ for (p = body_points) if (len(p) > 2) bpoint(body_points, p[0]) ];

function _bpoint_z(body_points)=
  - min(concat([ 0 ], [ for (p = bpoints(body_points)) p.z ]));

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
  name == undef ? undef :
  name == "origin" ? [ 0, 0, 0 ] :
  s1 && len(p) > 4 ? _bpoint_cross(body_points, p) :
  s1 && s2 ? _bpoint_mid(body_points, p) :
  s1 ? _bpoint_lin(body_points, p) :
  name == "z" ? _bpoint_z(body_points) :
  _bpoint_point(body_points, p);

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
      color(c) _bal(bpoint(body_points, p0), d);
    }
  }
}

function _get_dia(body_hulls, hull_name, p)=
  let(
    p0 = p[0],
    dd = _get(body_hulls, "default diameter", 0.7),
    hd = _get(body_hulls, str(hull_name, " diameter"), dd),
    pd = _get(body_hulls, str(p0, " diameter"), hd),
    p1 = p[1]
  )
  is_num(p1) ? p1 :
  is_string(p1) ? _get(body_hulls, p1, pd) :
  pd;

module _draw_hull(body_points, body_hulls, h) {

  #hull() {
    for (p = h) {
      if ( ! is_string(p)) {
        xyz = bpoint(body_points, p[0]);
        if (xyz) _bal(xyz, _get_dia(body_hulls, h[0], p));
      }
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

function _merge_hull_entry(hulls, entry)=
  entry[0] == "?" ? _del(hulls, entry[1]) :
  _app(hulls, entry);

function _merge_hull_entries(hulls, entries, i=0)=
  entries[i] == undef ? hulls :
  _merge_hull_entries(_merge_hull_entry(hulls, entries[i]), entries, i + 1);

function make_humanoid_body_hulls(entries)=
  _merge_hull_entries(default_humanoid_body_hulls, entries);

