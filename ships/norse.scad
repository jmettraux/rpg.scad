
//
// norse.scad
//

use <skeleton.scad>;

// unit is mm

inch = 25.4;
//ch = 12; // center height
//ph = 60; // prow height


default_clinker_points = [

  [ "length", 12 * inch / 2 ],
  [ "length ratio", 1 / 8 ],
  [ "slice ratio", 1 ],

  [ "keel a", 0, 0, "slice ratio", "origin" ],
  [ "keel b", 0, 0, "slice ratio", "keel a" ],
  [ "keel c", 0, 0, "slice ratio", "keel b" ],
  [ "keel d", 0, 0, "slice ratio", "keel c" ],
  [ "keel e", 0, 0, "slice ratio", "keel d" ],
  [ "keel f", 0, 0, "slice ratio", "keel e" ],
  [ "keel g", 0, 0, "slice ratio", "keel f" ],
  [ "prow mid", 45, 0, 2.1, "keel g" ],
  [ "prow top", 110, 0, 1.8, "prow mid" ]

    ];

module snekja(length, width, prow_height, board_height) {
  ps = default_clinker_points;
  draw_points(ps);
  enumerate_points(ps);
}

snekja(12 * inch, 2 * inch, 2.1 * inch, 0.5 * inch);

