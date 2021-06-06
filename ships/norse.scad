
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

    // co: control
    // gw: gunwale
    //
  [ "slice o co", 0, -90, 1.4, "origin" ],
  [ "slice o gw", 22, -90, 1.5, "origin" ],
    //
  //[ "slice a co", 0, -90, 1.4, "keel a" ],
  //[ "slice a gw", 22, -90, 1.5, "keel a" ],
  //  //
  //[ "slice b co", 0, -90, 1.4, "keel b" ],
  //[ "slice b gw", 22, -90, 1.5, "keel b" ],
  //  //
  //[ "slice c co", 0, -90, 1.4, "keel c" ],
  //[ "slice c gw", 22, -90, 1.5, "keel c" ],
  //  //
  //[ "slice d co", 0, -90, 1.4, "keel d" ],
  //[ "slice d gw", 22, -90, 1.5, "keel d" ],
  //  //
  //[ "slice e co", 0, -90, 1.4, "keel e" ],
  //[ "slice e gw", 22, -90, 1.5, "keel e" ],
  //  //
  //[ "slice f co", 0, -90, 1.4, "keel f" ],
  //[ "slice f gw", 22, -90, 1.5, "keel f" ],
  //  //
  //[ "slice g co", 0, -90, 1.4, "keel g" ],
  //[ "slice g gw", 22, -90, 1.5, "keel g" ],
    //
  [ "gunwale con", 22, -90, 1.3, "keel g" ],

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
dcps2 = concat(
  dcps1,
      //
  bezier_points(
    dcps1, [ "keel g", "prow con", "prow top" ], "prow bz"),
  bezier_points(
    dcps1, [ "keel g 1", "prow con 1", "prow top 1" ], "prow 1 bz"),
      //
  bezier_points(
    dcps1, [ "origin", "slice o co", "slice o gw" ], "slice o bz")
  //bezier_points(
  //  dcps1, [ "keel a", "slice a co", "slice a gw" ], "slice a bz")
  //bezier_points(
  //  dcps1, [ "keel b", "slice b co", "slice b gw" ], "slice b bz"),
  //bezier_points(
  //  dcps1, [ "keel c", "slice c co", "slice c gw" ], "slice c bz"),
  //bezier_points(
  //  dcps1, [ "keel d", "slice d co", "slice d gw" ], "slice d bz"),
  //bezier_points(
  //  dcps1, [ "keel e", "slice e co", "slice e gw" ], "slice e bz"),
  //bezier_points(
  //  dcps1, [ "keel f", "slice f co", "slice f gw" ], "slice f bz"),
  //bezier_points(
  //  dcps1, [ "keel g", "slice g co", "slice g gw" ], "slice g bz")
      );
dcps3 =
  concat(
  dcps2,
  bezier_points(
    dcps2, [ "slice o gw", "gunwale con", "prow 1 bz4" ], "gw bz", 7)
      );
default_clinker_points =
  dcps3;

dchs0 = [
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

  //[ "plank o1", [ "origin" ], [ "keel a" ], [ "slice o bz1" ], [ "slice a bz1" ] ],
  //[ "plank o2", [ "slice o bz1" ], [ "slice a bz1" ], [ "slice o bz2" ], [ "slice a bz2" ]  ],
  //[ "plank a1", [ "keel a" ], [ "slice a bz1" ], [ "keel b" ], [ "slice b bz1" ] ]
    ];
dchs1 = concat(
  dchs0,
  [
  ]);
default_clinker_hulls =
  dchs1;

module snekja(length, width, prow_height, board_height) {
  ps = default_clinker_points;
  hs = default_clinker_hulls;
  draw_points(ps);
  enumerate_points(ps);
  draw_hulls(ps, hs);
}

snekja(12 * inch, 2 * inch, 2.1 * inch, 0.5 * inch);

