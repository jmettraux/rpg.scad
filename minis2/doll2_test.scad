
//
// doll2_test.scad
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
  //[ "sternum2", "back", 0.75, "back", [ "l shoulder", "r shoulder" ] ],

  //[ "l wingbase", "l shoulder", 2.4 ],
  //[ "r wingbase", "r shoulder", 2.4 ],
  //[ "l wing0", "l wingbase", 3, "back", "l shoulder" ],

  [ "tailbase", "origin", "waist", 0.3 ],
  [ "tail 1c1", -80, 0, 2, "tailbase" ],
  [ "tail 1c0", 180 - 15, 0, 3, "tailbase" ],
  [ "tail 1", 180 + 45, 0, 5.3, "tailbase" ],
  [ "tail in", 270 - 20, 0, 1.3, "tailbase" ],
    ]);

//translate([ 0, 0, bpoint(bps, "z") ])
move_z(bps)
  draw_points(bps);

//translate([ 0, 0, bpoint(bps, "z") ])
move_z(bps)
  color("cyan") _bal(bpoint(bps, "tail in"), 1.1, $fn=12);

hs = make_humanoid_body_hulls([
  //[ "torso", "?" ], // <-- which removes the "torso" hull...
  [ "tail 1", "bez",
    [ "tailbase", "tail diameter" ],
    [ "tail 1c0" ],
    [ "tail 1c1" ],
    [ "tail 1", "tail end diameter" ],
    [ "tail in", 0.5, "hub" ], // <----- hub ;-)
      ] ]);

//translate([ 0, 0, bpoint(bps, "z") ])
move_z(bps)
  draw_hulls(bps, hs);

