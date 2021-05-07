
// dicetower_plug.scad

// unit is mm

difference() {

  cylinder(d=60 - 0.2 * 2, h=21, $fn=8);
  translate([ -35, 0, -3 ]) cube(size=[ 70, 35, 55 ]);
}

