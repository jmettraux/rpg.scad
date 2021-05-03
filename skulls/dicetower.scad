
// skull.scad

// unit is mm

difference() {

  union() {
    translate([ 0, 0, 20 ])
      scale([ 2, 2, 2 ]) import("skull0.stl");
        // https://www.thingiverse.com/thing:906562
    cylinder(d1=75, d2=65, h=45, $fn=6);
    translate([ 0, -27, 0 ])
      cylinder(d1=75, d2=50,  h=45, $fn=6);

    translate([ 0, -50, 1 ])
      cube(size=[ 35, 40, 2 ], center=true);
  }

  translate([ 0, 5, 65 ]) rotate([ 0, 11, 90 ])
    cylinder(d1=5, d2=89, h=45, $fn=6);

  translate([ 0, -18, 20 ]) rotate([ 90, 0, 0 ]) // mouth
    cylinder(d=50, h=46, $fn=6);

  translate([ 0, 40 - 1.0, 75 ]) rotate([ 120, 0, 0 ])
    cylinder(d=50, h=80, $fn=8);
}

