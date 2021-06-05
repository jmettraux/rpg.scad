
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
  [ "prow mid", 45, 0, 2.1, "keel g" ],
  [ "prow mid c", 0, 0, 1.7, "keel g" ],
  [ "prow top", 110, 0, 1.8, "prow mid" ],
  [ "prow top c", 90, 0, 0.9, "prow mid" ],

  //[ "origin 1", 90, 0, "keel ratio", "origin" ],
  //[ "keel a 1", 90, 0, "keel ratio", "keel a" ],
  //[ "keel b 1", 90, 0, "keel ratio", "keel b" ],
  //[ "keel c 1", 90, 0, "keel ratio", "keel c" ],
  //[ "keel d 1", 90, 0, "keel ratio", "keel d" ],
  //[ "keel e 1", 90, 0, "keel ratio", "keel e" ],
  //[ "keel f 1", 90, 0, "keel ratio", "keel f" ],
  //[ "keel g 1", 90, 0, "keel ratio", "keel g" ],
  //[ "prow mid 1", -180, 0, "keel ratio", "prow mid" ],
  //[ "prow top 1", -90, 0, "keel ratio", "prow top" ]

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
      [ "keel g", "prow mid c", "prow mid" ],
      "prow lo bz"));
dcps3 =
  concat(
    dcps2,
    [
      //[ "prow lo 1", "prow lo bz1", 0.4, "prow lo bz1", [ "prow lo bz1", "prow lo bz2" ] ]
    ]);
  // [ "sternum", "back", 0.4, "back", [ "l shoulder", "r shoulder" ] ],
default_clinker_points =
  dcps3;

default_clinker_hulls = [
  [ "keel a", [ "origin" ], [ "keel a" ], [ "origin 1" ], [ "keel a 1" ] ],
  [ "keel b", [ "keel a" ], [ "keel b" ], [ "keel a 1" ], [ "keel b 1" ] ],
  [ "keel c", [ "keel b" ], [ "keel c" ], [ "keel b 1" ], [ "keel c 1" ] ],
  [ "keel d", [ "keel c" ], [ "keel d" ], [ "keel c 1" ], [ "keel d 1" ] ],
  [ "keel e", [ "keel d" ], [ "keel e" ], [ "keel d 1" ], [ "keel e 1" ] ],
  [ "keel f", [ "keel e" ], [ "keel f" ], [ "keel e 1" ], [ "keel f 1" ] ],
  [ "keel g", [ "keel f" ], [ "keel g" ], [ "keel f 1" ], [ "keel g 1" ] ]
  //[ "prow lo", "bez", [ "keel g" ], [ "prow mid c" ], [ "prow mid" ] ],
  //[ "prow hi", "bez", [ "prow mid" ], [ "prow top c" ], [ "prow top" ] ],
    ];

module snekja(length, width, prow_height, board_height) {
  ps = default_clinker_points;
  hs = default_clinker_hulls;
  draw_points(ps);
  enumerate_points(ps);
  draw_hulls(ps, hs);
}

snekja(12 * inch, 2 * inch, 2.1 * inch, 0.5 * inch);

