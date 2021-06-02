
//
// norse.scad
//

// unit is mm

inch = 25.4;
ch = 12; // center height
ph = 60; // prow height

r = inch / 2;
//rr = r / 10;
rr = 2;

module bal() { sphere(r=rr, $fn=12); }

module panel(points) {
  hull() for (p = points) translate(p) bal();
}

panel([ [ 0, 0, 0 ], [ 0, 10, 0 ], [ 10, 10, 0 ], [ 10, 0, 0 ] ]);

