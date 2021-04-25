
//
// snake.scad
//

include <minilib.scad>;


$fn = 12;

hei = 33 * 0.63; // height
hsi = hei / 3.5; // head side

dia = 3.5; // diameter
dia2 = dia / 2;



base(text="", $fn=12);

module head() {
  rotate([ 0, 0, 90 ]) hull() {
    cylinder(d=hsi, h=hsi / 3, center=true, $fn=3);
    translate([ hsi / 2, 0, 0 ]) cylinder(d=hsi, h=hsi / 4, center=true, $fn=3);
  }
}

module body() {

  translate([ -10, 0, dia * 0.5 ]) {

    l0 = 0;
    l1 = l0 + dia * 0.9;
    l2 = l1 + dia * 0.9;

    path = [
      [ [ 0, 0, l0 ], [ 0, 10, l0 ], [ 10, 10, l0 ] ],
      [ [ 10, 10, l0 ], [ 20, 10, l0 ], [ 20, 0, l0 ] ],
      [ [ 20, 0, l0 ], [ 20, -10, l0 ], [ 10, -10, l0 ] ],
      [ [ 10, -10, l0 ], [ 0, -10, l0 + dia * 0.2 ], [ 0, 0, l1 ] ],
      [ [ 0, 0, l1 ], [ 0, 9, l1 ], [ 10, 9, l1 ] ],
      [ [ 10, 9, l1 ], [ 19, 9, l1 ], [ 19, 0, l1 ] ],
      [ [ 19, 0, l1 ], [ 19, -9, l1 ], [ 9, -8, l1 ] ],
      [ [ 9, -8, l1 ], [ 1, -8, l1 + dia * 0.2 ], [ 1, 0, l2 ] ],
      [ [ 1, 0, l2 ], [ 0, 8, l2 ], [ 7, 8, l2 ] ],

      [ [ 7, 8, l2 ], [ 10, 8, l2 ], [ 10, 4, l2 + hei / 2 ] ],
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
translate([ hsi * 0.0, hsi * 0.6, hei * 0.95 ]) rotate([ -20, 0, 0 ]) head();

