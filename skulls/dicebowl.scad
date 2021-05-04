
// dicebowl.scad

// unit is mm

difference() {

  cylinder(d=100 + 0.2 + 2, h=28, $fn=6);

  //cylinder(d1=140, d2=154, h=28, $fn=6);
  translate([ 0, 0, 2 ])
    cylinder(d=100 + 0.2, h=28, $fn=6);

  #translate([ 0, 0, -0.5 ])
    cylinder(d=20, h=3, $fn=6);
}

