
// skull.scad

// unit is mm

difference() {
  scale([ 2, 2, 2 ]) import("lowpolyskulllisa.stl");
    // https://www.thingiverse.com/thing:906562
  #translate([ 0, -20, -10 ]) rotate([ -45, 0, 0 ]) cylinder(d=30, h=100);
}


