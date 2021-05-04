
//
// wyrmling.scad
//

include <minidoll2.scad>;


bps =
  _merge_body_entries(
    quadruped_body_points,
    [
      ]);

//bps = make_humanoid_body_points([
//  [ "knee ratio", 2 ],
//  [ "hand ratio", 0.5 ],
//  [ "r knee", -60 ],
//  [ "l knee", -100, -20 ],
//  [ "l ankle", -110, -10 ],
//  [ "l shoulder", 0, 100 ],
//  [ "r shoulder", 0, -80 ],
//  //[ "sternum2", "back", 0.75, "back", [ "l shoulder", "r shoulder" ] ],
//
//  //[ "l wingbase", "l shoulder", 2.4 ],
//  //[ "r wingbase", "r shoulder", 2.4 ],
//  //[ "l wing0", "l wingbase", 3, "back", "l shoulder" ],
//
//  [ "tailbase", "origin", "waist", 0.3 ],
//  [ "tail 1c1", -80, 0, 2, "tailbase" ],
//  [ "tail 1c0", 180 - 15, 0, 3, "tailbase" ],
//  [ "tail 1", 180 + 45, 0, 5.3, "tailbase" ],
//    ]);

//echo("z:", bpoint(bps, "z"));

translate([ 0, 0, bpoint(bps, "z") ]) {
  color("red") _bal(bpoint(bps, "origin"));
  draw_body_balls(bps);
}

//hs = default_humanoid_body_hulls;
hs = concat(default_spine_hulls, default_leg_hulls, default_arm_hulls);

translate([ 0, 0, bpoint(bps, "z") ])
  draw_body_hulls(bps, hs);


//translate([ 0, 0, bpoint(bps, "z") ])
//  color("cyan") _bal(bpoint(bps, "hip"), 1.4);

