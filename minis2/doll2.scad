
//
// doll2.scad
//

include <minilib.scad>;
include <doll2_defaults.scad>;


module _bal(p, d) {
  translate(p) sphere(d);
};

function bpoints(points)=
  [ for (p = points) if (len(p) > 2) bpoint(points, p[0]) ];

function _bpoint_rz(points)=
  min([ for (p = bpoints(points)) p.z ]);
function _bpoint_z(points)=
  - min(concat([ 0 ], [ for (p = bpoints(points)) p.z ]));

function _bpoint_hh(points)=
    _get(points, "height") * _get(points, "head height ratio");

  // [ "r thigh", "r knee", 0.5 ],
  //   [ "r knee", -90, 0, "knee ratio", "r hip" ],
  //
function _bpoint_lin(points, p)=
  let(
    p1 = _assoc(points, p[1]),
    p0 = bpoint(points, p1[4]), // p1's parent
    l1 = _bpoint_hh(points) * _get(points, p1[3])
  )
  _to_point(l1 * p[2], [ p1[1], p1[2] ], p0);

  // [ "l chop", "l waist", "l shoulder", 3 ],
function _bpoint_mid(points, p)=
  let(
    p1 = bpoint(points, p[1]),
    p2 = bpoint(points, p[2]),
    sx = _to_spherical(p2 - p1)
  )
  _to_point(sx[0] * p[3], sx[1], p1);

function _bpoint_v1(points, pname)= // when receiving one point name
  let(
    p0name = _assoc(points, pname)[4],
    p0 = bpoint(points, p0name),
    p = bpoint(points, pname)
  )
  p - p0;
function _bpoint_v2(points, pnames)= // when receiving two point names
  let(
    pa = bpoint(points, pnames[0]),
    pb = bpoint(points, pnames[1])
  )
  pb - pa;

  // [ "sternum", "back", 0.4, "back", [ "l shoulder", "r shoulder" ] ],
  //
function _bpoint_cross(points, p)=
  let(
    p0 = bpoint(points, p[1]),
    l = p[2] * _bpoint_hh(points),
    v0 = is_string(p[3]) ? _bpoint_v1(points, p[3]) : _bpoint_v2(points, p[3]),
    v1 = is_string(p[4]) ? _bpoint_v1(points, p[4]) : _bpoint_v2(points, p[4]),
    cro = cross(v0, v1),
    ele_dir = _to_spherical(cro)[1]
  )
  _to_point(l, ele_dir, p0);

function _bpoint_point(points, p)=
  let(
    dr = 1.0, // default ratio
    r = is_string(p[3]) ? _get(points, p[3], dr) : p[3],
    l = _bpoint_hh(points) * r
  )
  _to_point(l, [ p[1], p[2] ], bpoint(points, p[4]));

function bpoint(points, name, default=undef)=
  let(
    p = _assoc(points, name, default),
    s1 = is_string(p[1]),
    s2 = is_string(p[2])
  )
  name == undef ? undef :
  name == "origin" ? [ 0, 0, 0 ] :
  s1 && len(p) > 4 ? _bpoint_cross(points, p) :
  s1 && s2 ? _bpoint_mid(points, p) :
  s1 ? _bpoint_lin(points, p) :
  name == "rz" ? _bpoint_rz(points) :
  name == "z" ? _bpoint_z(points) :
  _bpoint_point(points, p);

function _rework_point_entry(points, entry)=
  let(
    k = entry[0],
    v0 = _assoc(points, k),
    el = entry[len(entry) - 1]
  )
  el == "!" ? _slist(entry, 0, len(entry)-2) :
  [ for (i = [ 0 : len(v0) - 1 ]) entry[i] == undef ? v0[i] : entry[i] ];

function _merge_point_entry(points, entry)=
  let(
    k = entry[0]
  )
  k == "-" ? _del(points, entry[1]) :
  _assoc(points, k) == undef ? _app(points, entry) :
  _app(points, _rework_point_entry(points, entry));

function _merge_point_entries(points, entries, i=0)=
  entries[i] == undef ? points :
  _merge_point_entries(_merge_point_entry(points, entries[i]), entries, i + 1);


function make_humanoid_body_points(entries)=
  _merge_point_entries(default_humanoid_body_points, entries);


module draw_points(points) {

  d = 0.7;

  _bal(bpoint(points, "origin"), d);

  for (p = points) {
    p0 = p[0];
    if (_sindex(p0, "ratio") == undef && _sindex(p0, "height") == undef) {
      xyz = bpoint(points, p0);
      echo("draw_points", p, "-->", xyz);
      if (xyz) {
        c =
          _sstr(p0, 0, 2) == "l " ? "#0000FF" :
          _sstr(p0, 0, 2) == "r " ? "#FF0000" :
          "yellow";
        color(c) _bal(xyz, d);
      }
    }
  }
}

module enumerate_points(points) {

  echo("--- (body) points: ---");
  for (p = points) { echo(p); }
}

function _ssindex(s, k, k1=undef)=
  is_string(s) && (_sindex(s, k) || (k1 && _sindex(s, k1)));

function __get(dict, ak, bk0, bk1, default)=
  _get(dict, str(ak, " ", bk0), _get(dict, str(ak, " ", bk1), default));

function _get_sca(body_hulls, hull_name, p)=
  let(
    p0 = p[0],
    dk = __get(body_hulls, "default", "scale", "sca", [ 1, 1, 1 ]),
    hk = __get(body_hulls, hull_name, "scale", "sca", dk),
    pk = __get(body_hulls, p0, "scale", "sca", hk),
    p2 = p[2],
    p2k = _ssindex(p2, " scale", " sca") ? _get(body_hulls, p2, pk) : pk
  )
  _is_point(p2) ? p2 :
  p2k;

function _get_dia(body_hulls, hull_name, p)=
  let(
    p0 = p[0],
    dd = __get(body_hulls, "default", "diameter", "dia", 0.7),
    hd = __get(body_hulls, hull_name, "diameter", "dia", dd),
    pd = __get(body_hulls, p0, "diameter", "dia", hd),
    p1 = p[1],
    p1d = _ssindex(p1, " diameter", " dia") ? _get(body_hulls, p1, pd) : pd
  )
  is_num(p1) ? p1 :
  p1d;


module _draw_hull(points, body_hulls, h) {

  #hull() {
    for (p = h) {
      if ( ! is_string(p)) {
        xyz = bpoint(points, p[0]);
        if (xyz) {
          translate(xyz)
            scale(_get_sca(body_hulls, h[0], p))
              sphere(_get_dia(body_hulls, h[0], p));
        }
      }
    }
  }
}

module _draw_bezier_hull(points, body_hulls, h) {

  dd = _get(body_hulls, "default diameter", 0.7);
  bsc = _get(body_hulls, "bezier sample count", 6);

  ps0 = [ for (p = h) if (is_list(p) && p[2] != "hub") p ];
  ps = [ for (p = ps0) bpoint(points, p[0]) ];
  ps1 = _bezier_points(ps, bsc);

  d0 = _get_dia(body_hulls, h[0], ps0[0]);
  d1 = _get_dia(body_hulls, h[0], _slist(ps0, -1)[0]);
  dl = (d1 - d0) / (bsc + 1);

  hp = [ for (p = h) if (is_list(p) && p[2] == "hub") p ][0];
  hd = hp ? _get_dia(body_hulls, h[0], hp) : -1;

  for (i = [ 0 : len(ps1) - 2 ]) {
    #hull() {
      _bal(ps1[i], d0 + i * dl);
      _bal(ps1[i + 1], d0 + (i + 1) * dl);
      if (hp) _bal(bpoint(points, hp[0]), hd);
    }
  }
}

module draw_hulls(points, body_hulls) {

  hs = [ for (h = body_hulls) if (is_list(h[2]) || is_list(h[1])) h ];

  for (h = hs) {
    if (_ends_with(h[0], " sca") || _ends_with(h[0], " scale")) {
    }
    else if (h[1] == "bez") {
      _draw_bezier_hull(points, body_hulls, h);
    }
    else {
      _draw_hull(points, body_hulls, h);
    }
  }
}

function _merge_hull_entry(hulls, entry)=
  (entry[0] == "?" || entry[0] == "-") ?
    _del(hulls, entry[1]) :
    _app(hulls, entry);

function _merge_hull_entries(hulls, entries, i=0)=
  entries[i] == undef ? hulls :
  _merge_hull_entries(_merge_hull_entry(hulls, entries[i]), entries, i + 1);

function make_humanoid_body_hulls(entries)=
  _merge_hull_entries(default_humanoid_body_hulls, entries);


module move_z(body_points) {

  translate([ 0, 0, bpoint(body_points, "z") ]) children();
}

//
// supports

module support_point(point, rotation=undef) {

  t = 0.6;
  l = 100;
  p = (rotation == undef) ? point : rotate_point(point, rotation);

  color("cyan")
    translate([ p.x, p.y, p.z - l + l / 2 ])
      cylinder(d=t, h=l, center=true, $fn=36);
}

module support(points, point_name, rotation=undef) {

  support_point(bpoint(points, point_name), rotation);
}

module supported(cube_side=100, base_thickness=3) {

  difference() {

    children();

    translate([ 0, 0, - cube_side/2 - base_thickness ])
      cube(size=cube_side, center=true);
  }
}

