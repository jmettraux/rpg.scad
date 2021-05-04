
// dicetower.scad

// unit is mm

difference() {

  union() {
    translate([ 0, 0, 35 ])
      scale([ 3, 3, 3 ]) import("skull0.stl");
        // https://www.thingiverse.com/thing:906562

    translate([ 0, 10, 0 ])
      cylinder(d1=100, d2=100, h=45, $fn=6);

    //translate([ 0, -27, 0 ])
    //  cylinder(d1=75, d2=50,  h=45, $fn=6);
  }

  translate([ 0, 5, 85 ]) rotate([ 0, 11, 90 ]) // top hex
    cylinder(d1=55, d2=110, h=80, $fn=6);

  translate([ 0, -33.5, 35 ]) rotate([ 90, 0, 0 ]) // mouth
    cylinder(d=60, h=70, $fn=6);

  translate([ 0, 70, 130 ]) rotate([ 120, 0, 0 ]) // slide
    cylinder(d=60, h=155, $fn=8);
}

