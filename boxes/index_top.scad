
//
// index_top.scad
//

// unit is mm

len = 187; // length
dep = 77; // depth
hei = 42; // height

sle = 30; // slit length
swi = 7; // slit width

thi = 2; // thickness


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

