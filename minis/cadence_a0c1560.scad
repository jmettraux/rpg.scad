
// cadence_a0c1560.scad
// https://github.com/jmettraux/cadence.scad


// as of 2019.05, OpenSCAD understands
// is_num, is_list, is_string, and, is_bool
//
// is_function is coming, but looks tricky



function _normalize_angle(a) =
  ((a >= 0 && a <= 360) ? a : _normalize_angle(a + (a < 0 ? 360 : -360)));


//
// dictionary functions

function _get(dict, key, default=undef) =
  let (r = search(key, dict)[0]) r == undef ? default : r;
function _del(dict, key) =
  [ for (kv = dict) if (kv[0] != key) kv ];
function _put(dict, key, value) =
  concat(_del(dict, key), [ [ key, value ] ]);


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

//
// point functions

  // Accept a single angle instead of [ angle0, angle1 ]
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
    //l = sqrt(pow(point.x, 2) + pow(point.y, 2) + pow(point.z, 2)),
    l = norm(point),
    ele = asin(point.z / l),
    dir = acos(point.x / (sqrt(pow(point.x, 2) + pow(point.y, 2))))
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


//
// modules

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

