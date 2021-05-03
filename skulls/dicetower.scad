
// skull.scad

// unit is mm

difference() {

  union() {
    translate([ 0, 0, 20 ])
      scale([ 2, 2, 2 ]) import("skull0.stl");
        // https://www.thingiverse.com/thing:906562
    cylinder(d1=70, d2=65, h=30, $fn=6);
    translate([ 0, -31, 0 ])
      cylinder(d1=70, d2=60,  h=30, $fn=6);
  }

  translate([ 0, 5, 70 ]) rotate([ 0, 0, 0 ])
    cylinder(d1=0, d2=70, h=40);
  translate([ 0, 25, 70 ]) rotate([ 0, 0, 0 ])
    cylinder(d1=30, d2=70, h=40);

  translate([ 0, -20, 20 ]) rotate([ 90, 0, 0 ]) // mouth
    cylinder(d=50, h=45);

  translate([ 0, 40 + 2, 75 ]) rotate([ 120, 0, 0 ])
    cylinder(d=52, h=80);
}


