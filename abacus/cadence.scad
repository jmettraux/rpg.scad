
// cadence 82e04cf.scad
// https://github.com/jmettraux/cadence.scad


// as of 2019.05, OpenSCAD understands
// is_num, is_list, is_string, and, is_bool
//
// is_function is coming, but looks tricky



function _normalize_angle(a) =
  ((a >= 0 && a <= 360) ? a : _normalize_angle(a + (a < 0 ? 360 : -360)));


//
// dictionary functions

function _aaget(dict, key, default, off) =
  let (kv = dict[off])
    kv == undef ? default :
    kv[0] == key ? kv[1] :
      _aaget(dict, key, default, off + 1);

function _asget(dict, key, default, off) =
  dict[off] == undef ? default :
  dict[off] == key ? dict[off + 1] :
    _asget(dict, key, default, off + 2);

function _get(dict, key, default=undef) =
  is_string(dict[0]) ?
    _asget(dict, key, default, 0) :
    _aaget(dict, key, default, 0);

function _del(dict, key) =
  [ for (kv = dict) if (kv[0] != key) kv ];

function _put(dict, key, value) =
  concat(_del(dict, key), [ [ key, value ] ]);


function _assoc(arr, key, default, off=0) =
  let (a = arr[off])
    a == undef ? default :
    a[0] == key ? a :
      _assoc(arr, key, default, off + 1);

function _app(arr, entry) =
  concat(_del(arr, entry[0]), [ entry ]);


//
// list functions

function _idx(list, index, default=undef) =
  let (
    i = index < 0 ? len(list) + index : index,
    r = list[i]
  )
    r == undef ? default : r;

  // sublist
  //
function _slist(list, from=0, to) =
  let(
    li = len(list) - 1,
    end = (to == undef ? li : to),
    a0 = from < 0 ? li + 1 + from : from,
    a = a0 < 0 ? 0 : a0,
    z = end < 0 ? li + 1 + end : end
  )
    a > li ? [] :
    z < a ? [] :
      [ for (i = [a:z]) list[i] ];

function _reverse(list) =
  [ for (i = [ len(list) - 1 : -1 : 0 ]) list[i] ];


//
// string functions

function _sstr(s, from=0, length=undef, r="") =
  let(
    i = from < 0 ? len(s) + from : from,
    l = length == undef ? len(s) : length,
    s0 = s[i]
  )
  (s0 == undef || l < 1) ? r :
  str(r, s[i], _sstr(s, i + 1, l - 1));

function _sindex(s, s1, i=0) =
  let(
    l = len(s1),
    s0 = _sstr(s, i, l)
  )
  len(s0) < l ? undef :
  s0 == s1 ? i :
  _sindex(s, s1, i + 1);


//
// point functions

  // Accept a single angle instead of [ angle0, angle1 ]
  // 'sp' is the start point
  //
function _to_point(length, angles, sp=[ 0, 0, 0 ]) =
  let(
    as = is_num(angles) ? [ angles, 0 ] : angles,
    inclination = as[0],
    azimuth = as[1] + 90
  )
    sp + [
      length * cos(inclination) * cos(azimuth),
      length * cos(inclination) * sin(azimuth),
      length * sin(inclination) ];

function _to_spherical(point) =
  let(
    l = norm(point),
    ele = asin(point.z / l),
    dir = atan2(point.y, point.x)
  )
    [ l, [ ele, dir - 90 ] ];


function _midpoint(p0, p1, ratio=0.5) =
  let(
    s = _to_spherical(p1 - p0)
  )
    _to_point(ratio * s[0], s[1], p0);

//function _vlen(vector) =
//  sqrt(pow(vector.x, 2) + pow(vector.y, 2) + pow(vector.z, 2));
  //
  // no, use norm(vector)


// inspiration:
// https://climberg.de/post/openscad_bezier_curves_of_any_degrees

function _bezier_choose(n, k) =
  k == 0 ?  1 : (n * _bezier_choose(n - 1, k - 1)) / k;

function _bezier_point(points, t, i, c) =
  len(points) == i ?
    c :
    _bezier_point(
      points,
      t,
      i + 1,
      c +
        _bezier_choose(len(points) - 1, i) *
        pow(t, i) *
        pow(1 - t, len(points) - i - 1) * points[i]);

function _bezier_points(control_points, sample_count) =
  [ for (t = [ 0 : 1.0 / sample_count : 1 ])
    _bezier_point(control_points, t, 0, [ 0, 0, 0 ]) ];


//
// modules

module polypoints(points) {

  for (i = [ 0 : len(points) - 1 ]) {
    translate(points[i]) children(i % $children);
  }
}

module polyhulls(points) {

  for (i = [ 0 : len(points) - 2 ]) {

    hull() {
      translate(points[i]) children(i % $children);
      translate(points[i + 1]) children((i + 1) % $children);
    }
  }
}


// pineapple slice
//
module paslice(radius, depth, slice=45, radius1=0) {

  s = _normalize_angle(slice);
  r = radius;

  if (s > 0) difference() {

    cylinder(depth, r=r);

    translate([ 0, 0, -0.1 ]) cylinder(depth * 1.1, r=radius1);

    if (s != 360) {

      pas = [
        [ 0, r ], [ 0, 0 ] ];
      pbs = [
        [ r, r ], [ r, 0 ], [ r, -r ], [ 0, -r ], [ -r, -r ], [ -r, 0 ],
        [ -r, r ] ];

      t = tan(s);
      tx = t * r;
      ty = r / t;

      translate([ 0, 0, -0.1 ]) linear_extrude(depth + 0.2)
        if (s <= 45)
          polygon(concat(pas, [ [ tx, r ] ], pbs));
        else if (s <= 135)
          polygon(concat(pas, [ [ r, ty ] ], _slist(pbs, 2)));
        else if (s <= 225)
          polygon(concat(pas, [ [ -tx, -r ] ], _slist(pbs, 4)));
        else if (s <= 315)
          polygon(concat(pas, [ [ -r, -ty ] ], _slist(pbs, 6)));
        else if (s < 360)
          polygon(concat(pas, [ [ tx, r ] ]));
    }
  }
}


// dome with optional trunk_height
//
module dome(radius=-1, diameter=-1, trunk_height=0) {

  r = radius < 0 ? diameter / 2 : radius;
  th = trunk_height;

  translate([ 0, 0, th ])
    difference() {
      sphere(r=r);
      translate([ 0, 0, -r ]) cube(2 * r, center=true);
    }
  translate([ 0, 0, th / 2 ])
    cylinder(r=r, h=th, center=true);
}

