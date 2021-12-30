
//
// skeleton0.scad
//

include <doll2.scad>;
include <weapons.scad>;


//$fn=12;

  //[ "r thigh", "r knee", 0.4 ], // 0.4 between "r knee" and its parent "r hip"
  //[ "l thigh", "l knee", 0.4 ], // ...
  //[ "sternum", "back", 0.25, "back", [ "l shoulder", "r shoulder" ] ],
bps = make_humanoid_body_points([
  [ "knee ratio", 2 ],
  [ "hand ratio", 0.5 ],
  [ "r knee", -60 ],
  [ "l knee", -100, -20 ],
  [ "l ankle", -110, -10 ],
  [ "l shoulder", 0, 100 ],
  [ "r shoulder", 0, -80 ],

  [ "l waist", 90, 90, 0.3, "l hip" ],
  [ "r waist", 90, 90, 0.3, "r hip" ],

  [ "l chop", 85, 90, 0.8, "l waist", "!" ], // <-- "!" enforces OVERWRITE...
  [ "r chop", 95, 90, 0.8, "r waist", "!" ],

  [ "l thorax", 85, 90, 1.4, "l chop" ],
  [ "r thorax", 95, 90, 1.4, "r chop" ],
    ]);
//enumerate_points(bps);

//move_z(bps) draw_points(bps);

hs = make_humanoid_body_hulls([
  [ "neck diameter", 0.6 ],
  [ "knee diameter", 0.9 ],
  [ "leg diameter", 0.9 ],
  [ "thigh diameter", 0.7 ],
  [ "hip diameter", 0.7 ],
  [ "waist diameter", 0.7 ],
  [ "shoulder diameter", 0.7 ],
  [ "column diameter", 0.6 ],

  [ "column 1",
    [ "origin", "column diameter" ],
    [ "waist", "column diameter" ] ],
  [ "column 2",
    [ "waist", "column diameter" ],
    [ "back", "column diameter" ] ],
  [ "column 3",
    [ "shoulder", "column diameter" ],
    [ "neck", "column diameter" ] ],

  [ "l link",
    [ "l thorax", "column diameter" ],
    [ "l shoulder", "column diameter" ] ],
  [ "r link",
    [ "r thorax", "column diameter" ],
    [ "r shoulder", "column diameter" ] ],

  [ "l forearm",
    [ "l elbow", "elbow diameter" ],
    [ "l wrist", "wrist diameter" ] ],

  [ "l knee", [ "l knee", 1.1 ] ],
  [ "r knee", [ "r knee", 1.1 ] ],
  [ "l elbow", [ "l elbow", 0.9 ] ],
  [ "r elbow", [ "r elbow", 0.9 ] ],

  [ "torso", "?" ], // <-- which removes the "torso" hull...
  [ "torso hi",
    [ "l chop", "waist diameter" ],
    [ "r chop", "waist diameter" ],
    [ "sternum", "waist diameter" ],
    [ "l thorax", "shoulder diameter" ],
    [ "r thorax", "shoulder diameter" ] ],

  //[ "basin",
  //  [ "l hip", "hip diameter" ],
  //  [ "r hip", "hip diameter" ],
  //  [ "l waist", "waist diameter" ],
  //  [ "r waist", "waist diameter" ] ],

  //[ "torso",
  //  [ "l waist", "waist diameter" ],
  //  [ "r waist", "waist diameter" ],
  //  [ "l chop", "waist diameter" ],
  //  [ "r chop", "waist diameter" ],
  //  [ "l shoulder", "shoulder diameter" ],
  //  [ "r shoulder", "shoulder diameter" ],
  //  //[ "sternum", "neck diameter" ],
  //  [ "shoulder", "neck diameter" ],
  //  [ "neck", "neck diameter" ]
  //    ],
      ]);

move_z(bps) draw_hulls(bps, hs);

hh = _bpoint_hh(bps);

move_z(bps)
  translate([ 4.5, 1.4, -3 ])
    rotate([ 0, 160, 90 ])
      long_sword(hh * 4.2, hh * 0.6); // scramax

