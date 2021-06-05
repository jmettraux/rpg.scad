
//
// norse.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
ch = 12; // center height
ph = 60; // prow height

r = inch / 2;
rr = r / 10;

module bal() { sphere(r=rr, $fn=12); }

module panel(points) {
  hull() for (p = points) translate(p) bal();
}
//panel([ [ 0, 0, 0 ], [ 0, 10, 0 ], [ 10, 10, 0 ], [ 10, 0, 0 ] ]);

module quarter(length, width, prow_height, board_height) {
  l = length / 2;
  l1 = l / 6;
  l2 = l / 12;
  h1 = prow_height / 2;
  translate([ 0, 0, 0 ]) bal();
  translate([ -l + l1, 0, 0 ]) bal();
  translate([ -l, 0, h1 ]) bal();
  translate([ -l + l2, 0, prow_height ]) bal();
}

function keel(length, width, prow_height, board_height)=
  let(
    l = length / 2,
    l1 = l / 6,
    l2 = l / 12,
    h1 = prow_height / 2
  )
  [ [ 0, 0, 0 ],
    [ -l + l1, 0, 0 ],
    [ -l, 0, h1 ],
    [ -l + l2, 0, prow_height ]
      ];

module snekja(length, width, prow_height, board_height) {
  //quarter(length, width, prow_height, board_height);
  ps = keel(length, width, prow_height, board_height);
  for (p = ps) translate(p) bal();
}

snekja(12 * inch, 2 * inch, 2.1 * inch, 0.5 * inch);

