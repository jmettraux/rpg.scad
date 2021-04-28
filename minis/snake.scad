
//
// snake.scad
//

include <minilib.scad>;


$fn = 12;

hei = 33 * 0.63; // height
hsi = hei / 3.5; // head side

dia = 3.4; // diameter
dia2 = dia / 2;



rotate([ 0, 0, 180 ]) base(text="", $fn=12);

module head() {
  rotate([ 0, 0, 90 ]) hull() {
    cylinder(d=hsi, h=hsi / 3, center=true, $fn=3);
    translate([ hsi / 2, 0, 0 ]) cylinder(d=hsi, h=hsi / 4, center=true, $fn=3);
  }
}

module body() {

  translate([ 0, 0, dia * 0.5 ]) {

    l0 = 0;
    l1 = l0 + dia * 0.8;
    l2 = l1 + dia * 2;
    l3 = l2 + dia * 2.5;

    d0 = 9;
    d1 = d0 - dia;
    d2 = d1 - dia * 0.5;
    d3 = d2 - dia * 0.5;

    path = [
      [ [ -9, 0, l0 ], [ -9, 9, l0 ], [ 0, 9, l0 ] ],
      [ [ 0, 9, l0 ], [ 9, 9, l0 ], [ 9, 0, l0 ] ],
      [ [ 9, 0, l0 ], [ 9, -9, l0 ], [ 0, -9, l0 ] ],
      [ [ 0, -9, l0 ], [ -d1, -d0, l0 ], [ -d1, 0, l0 ] ],
      [ [ -d1, 0, l0 ], [ -d1, d1, l0 ], [ 0, d1, l0 ] ],
      [ [ 0, d1, l0 ], [ d1, d1, l0 ], [ d1, 0, l0 ] ],
      [ [ d1, 0, l0 ], [ d1, -d1, l0 ], [ 0, -d1, l0 ] ],
      [ [ 0, -d1, l0 ], [ -d2, -d1, l0 ], [ -d2, 0, l1 ] ],
      //[ [ -d2, 0, l1 ], [ -d2, d2, l1 ], [ 0, d2, l1 ] ],
      [ [ -d2, 0, l1 ], [ -d2, d3, l1 + (l2 - l1) / 2 ], [ 0, d3, l2 ] ],
      [ [ 0, d3, l2 ], [ d3, d3, l2 + (l3 - l2) / 2 ], [ d3, 0, l3 ] ],
    ];

    for (ps = path) {
      ps1 = _bezier_points(ps, 6);
      polyhulls(ps1) {
        sphere(d=dia);
      }
    }
  }
}


body();
translate([ dia * 0.6, 1, hei * 1.0 ]) rotate([ -20, 0, 180 ]) head();

