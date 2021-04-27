
//
// index_top.scad
//

// unit is mm

len = 189.2; // length
dep = 78.4; // depth
hei = 49; // height

sle = 30; // slit length
swi = 6.3; // slit width

thi = 1.6; // thickness


difference() {

  union() {

    // base

    cube(size=[ len, dep, thi ], center=true);

    // walls

    translate([ 0, dep / 2, hei / 2 - thi / 2 ])
      cube(size=[ len, thi, hei ], center=true);
    translate([ 0, -dep / 2, hei / 2 - thi / 2 ])
      cube(size=[ len, thi, hei ], center=true);

    translate([ -len / 2, 0, hei / 2 - thi / 2 ])
      cube(size=[ thi, dep + thi, hei ], center=true);
    translate([ len / 2, 0, hei / 2 - thi / 2 ])
      cube(size=[ thi, dep + thi, hei ], center=true);

    // reinforcements

    translate([ 0, dep / 2 - thi * 0.3, thi * 2 ])
      cube(size=[ len, thi * 1.4, thi * 2 ], center=true);
    translate([ 0, -dep / 2 + thi * 0.3, thi * 2 ])
      cube(size=[ len, thi * 1.4, thi * 2 ], center=true);

    translate([ -len / 2 + thi * 0.5, 0, thi * 2 ])
      cube(size=[ thi * 1.4, dep + thi, thi * 2 ], center=true);
    translate([ len / 2 - thi * 0.5, 0, thi * 2 ])
      cube(size=[ thi * 1.4, dep + thi, thi * 2 ], center=true);
  }

  // arches

  translate([ 0, dep, hei ])
    rotate([ 90, 0, 0 ]) cylinder(d=sle, h=dep * 2);

  // slits

  translate([ 0, -dep / 2 + swi / 2 + thi, 0 ])
    cube(size=[ sle, swi, sle ], center=true);
  translate([ 0, dep / 2 - swi / 2 - thi, 0 ])
    cube(size=[ sle, swi, sle ], center=true);
}

