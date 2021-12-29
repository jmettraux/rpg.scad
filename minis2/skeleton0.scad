
//
// skeleton0.scad
//

include <doll2.scad>;


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

  //[ "r chop", "r waist", "r shoulder", 0.5 ],
  //[ "l chop", "l waist", "l shoulder", 0.5 ],
    ]);
enumerate_points(bps);

move_z(bps) draw_points(bps);

hs = make_humanoid_body_hulls([
  //[ "torso", "?" ], // <-- which removes the "torso" hull...
  [ "neck diameter", 1.0 ],
  [ "thigh diameter", 1.0 ],
  [ "hip diameter", 1.0 ],
  [ "waist diameter", 1.0 ],
  [ "shoulder diameter", 1.0 ],

  [ "torso",
    [ "l waist", "waist diameter" ],
    [ "r waist", "waist diameter" ],
    [ "l shoulder", "shoulder diameter" ],
    [ "r shoulder", "shoulder diameter" ],
    //[ "sternum", "neck diameter" ],
    [ "shoulder", "neck diameter" ],
    [ "neck", "neck diameter" ]
      ],
      ]);

move_z(bps) draw_hulls(bps, hs);

