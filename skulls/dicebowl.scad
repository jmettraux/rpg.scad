
// dicebowl.scad

// unit is mm

difference() {

  cylinder(d1=140, d2=154, h=28, $fn=6);

  #translate([ 0, 0, 2 ])
    cylinder(d1=140 - 4, d2=154 - 4, h=28, $fn=6);
}

