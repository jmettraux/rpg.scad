
//
// norse.scad
//

use <skeleton.scad>;

// unit is mm

inch = 25.4;
//ch = 12; // center height
//ph = 60; // prow height


dcps0 = [

  [ "length", 12 * inch / 2 ],
  [ "length ratio", 1 / 8 ],
  [ "slice ratio", 1 ],
  [ "keel ratio", 1 / 9 ],

  [ "keel a", 0, 0, "slice ratio", "origin" ],
  [ "keel b", 0, 0, "slice ratio", "keel a" ],
  [ "keel c", 0, 0, "slice ratio", "keel b" ],
  [ "keel d", 0, 0, "slice ratio", "keel c" ],
  [ "keel e", 0, 0, "slice ratio", "keel d" ],
  [ "keel f", 0, 0, "slice ratio", "keel e" ],
  [ "keel g", 0, 0, "slice ratio", "keel f" ],
  [ "prow con", 0, 0, 2.8, "keel g" ],
  [ "prow top", 69, 0, 3.5, "keel g" ],
  [ "prow con 1", 0, 0, 2.7, "keel g 1" ],
  [ "prow top 1", 69, 0, 3.35, "keel g 1" ],

    ];
dcps1 =
  concat(
    dcps0,
    translate_points(
      dcps0,
      [ "origin", "keel a", "keel b", "keel c", "keel d", "keel e", "keel f",
        "keel g" ],
      " 1",
      [ 90, 0, "keel ratio" ]));
dcps2 =
  concat(
    dcps1,
    bezier_points(
      dcps1,
      //[ "keel g", "prow mid c", "prow mid" ],
      [ "keel g", "prow con", "prow top" ],
      "prow bz"),
    bezier_points(
      dcps1,
      //[ "keel g", "prow mid c", "prow mid" ],
      [ "keel g 1", "prow con 1", "prow top 1" ],
      "prow 1 bz"));
default_clinker_points =
  dcps2;

default_clinker_hulls = [
  [ "keel a", [ "origin" ], [ "keel a" ], [ "origin 1" ], [ "keel a 1" ] ],
  [ "keel b", [ "keel a" ], [ "keel b" ], [ "keel a 1" ], [ "keel b 1" ] ],
  [ "keel c", [ "keel b" ], [ "keel c" ], [ "keel b 1" ], [ "keel c 1" ] ],
  [ "keel d", [ "keel c" ], [ "keel d" ], [ "keel c 1" ], [ "keel d 1" ] ],
  [ "keel e", [ "keel d" ], [ "keel e" ], [ "keel d 1" ], [ "keel e 1" ] ],
  [ "keel f", [ "keel e" ], [ "keel f" ], [ "keel e 1" ], [ "keel f 1" ] ],
  [ "keel g", [ "keel f" ], [ "keel g" ], [ "keel f 1" ], [ "keel g 1" ] ],
  //[ "prow lo", "bez", [ "keel g" ], [ "prow mid c" ], [ "prow mid" ] ],
  //[ "prow hi", "bez", [ "prow mid" ], [ "prow top c" ], [ "prow top" ] ],
  [ "prow a", [ "keel g" ], [ "keel g 1" ], [ "prow bz1" ], [ "prow 1 bz1" ] ],
  [ "prow b", [ "prow bz1" ], [ "prow 1 bz1" ], [ "prow bz2" ], [ "prow 1 bz2" ]],
  [ "prow c", [ "prow bz2" ], [ "prow 1 bz2" ], [ "prow bz3" ], [ "prow 1 bz3" ]],
  [ "prow d", [ "prow bz3" ], [ "prow 1 bz3" ], [ "prow bz4" ], [ "prow 1 bz4" ]],
  [ "prow e", [ "prow bz4" ], [ "prow 1 bz4" ], [ "prow bz5" ], [ "prow 1 bz5" ]],
  [ "prow f", [ "prow bz5" ], [ "prow 1 bz5" ], [ "prow top" ], [ "prow top 1" ]],
    ];

module snekja(length, width, prow_height, board_height) {
  ps = default_clinker_points;
  hs = default_clinker_hulls;
  draw_points(ps);
  enumerate_points(ps);
  draw_hulls(ps, hs);
}

snekja(12 * inch, 2 * inch, 2.1 * inch, 0.5 * inch);

