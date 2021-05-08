
//
// wyrmling.scad
//

include <minidoll2.scad>;


dy = -7;
dz = -1.7;


#base(text=" W", font_size=5, font_spacing=0.95, $fn=12);

bps =
  _merge_point_entries(
    concat(quadruped_body_points, tail_2_points),
    [
      [ "side hip ratio", 0.5 ],

      [ "l knee",    43,  40 ],
      [ "l ankle", -100,   0 ],
      [ "l ball",   -70, -40 ],
      [ "l toe",    -20,  10 ],

      [ "l ball 1", -130, -10,  0.6, "l ball" ],
      [ "r ball 1", -130,  10,  0.6, "r ball" ],

      [ "r knee",    43, -40 ],
      [ "r ankle", -100,   0 ],
      [ "r ball",   -70,  40 ],
      [ "r toe",    -20, -10 ],

      [ "l wrist",  -80,   0 ],
      [ "r wrist",  -80,   0 ],

      [ "l hand",   -60,  40 ],
      [ "r hand",   -60, -40 ],

      [ "waist",     70,   0 ],
      [ "back",      60,   0 ],
      [ "shoulder",  50,   0 ],
      [ "neck",      40,   0 ],
      [ "head",      30,   0 ],

      [ "crest origin",
        "origin", -1, "waist", [ "l hip", "r hip" ] ],
      [ "crest origin 0",
        "waist", -0.7 ],
      [ "crest waist",
        "waist", -1, "waist", [ "l hip", "r hip" ] ],
      [ "crest back",
        "back", -1, "back", [ "l back", "r back" ] ],
      [ "crest shoulder",
        "shoulder", -1, "shoulder", [ "l shoulder", "r shoulder" ] ],
      [ "crest neck",
        "neck", -1, "neck", [ "l shoulder", "r shoulder" ] ],

  //[ "sternum2", "back", 0.75, "back", [ "l shoulder", "r shoulder" ] ],

      [ "tail 0",    -47,   0 ],
      [ "tail 0 c", -130, -10,  2.5, "origin" ],
      [ "tail 1",      -2,  100 ],
      [ "tail 1 c",    0,   0,  2, "tail 0" ],

      [ "l wing 1", 120, 10, "wing 1 ratio", "l back" ],
      [ "l wing 2", 90, 0, 3.5, "l wing 1" ],
      [ "l wing 3", -110, 10, 7, "l wing 2" ],
      [ "l wing 4", -70, 0, 4.2, "l wing 3" ],

      [ "r wing 1", 120, -10, "wing 1 ratio", "r back" ],
      [ "r wing 2", 90, 0, 3.5, "r wing 1" ],
      [ "r wing 3", -110, -10, 7, "r wing 2" ],
      [ "r wing 4", -70, 0, 4.2, "r wing 3" ],
        ]);

hs =
  _merge_hull_entries(
    concat(default_spine_hulls, default_leg_hulls, default_arm_hulls),
    [
      [ "tail 0", "bez",
        [ "origin", 1.8 ],
        [ "tail 0 c" ],
        [ "tail 0", 1 ] ],
      [ "tail 1", "bez",
        [ "tail 0", 1 ],
        [ "tail 1 c" ],
        [ "tail 1", 0.1 ] ],

      [ "l wing 1", [ "l back" ], [ "l wing 1" ] ],
      [ "l wing 3", "bez",
        [ "l wing 1", undef, "hub" ],
        [ "l wing 2" ], [ "l wing 3" ], [ "l wing 4" ] ],
      [ "l wing 4", "bez",
        [ "l wing 1", undef, "hub" ],
        [ "l wing 4" ], [ "l wing 1" ], [ "l back" ] ],

      [ "r wing 1", [ "r back" ], [ "r wing 1" ] ],
      [ "r wing 3", "bez",
        [ "r wing 1", undef, "hub" ],
        [ "r wing 2" ], [ "r wing 3" ], [ "r wing 4" ] ],
      [ "r wing 4", "bez",
        [ "r wing 1", undef, "hub" ],
        [ "r wing 4" ], [ "r wing 1" ], [ "r back" ] ],

      [ "abdomen",
        [ "origin", 1.1 ],
        [ "waist", 1.5 ],
        [ "l waist", 1.2 ], [ "r waist", 1.2 ] ],
      [ "back",
        [ "l waist", 1.2 ], [ "r waist", 1.2 ],
        [ "back", 1.6 ],
        [ "l back", 1.2 ], [ "r back", 1.2 ] ],
      [ "shoulders",
        [ "l back", 1.2 ], [ "r back", 1.2 ],
        [ "shoulder", 1.7 ],
        [ "l shoulder", 1.2 ], [ "r shoulder", 1.2 ] ],

      [ "l basin diameter", 1.2 ],
      [ "r basin diameter", 1.2 ],

      [ "leg diameter", 3 ],
      [ "knee diameter", 2 ],
      [ "knee diameter", 2 ],
      [ "ankle diameter", 1.4 ],
      [ "ball diameter", 1.2 ],

      [ "shoulder diameter", 1.7 ],
      [ "elbow diameter", 1.4 ],
      [ "wrist diameter", 1.3 ],

      [ "pelvis", [ "origin", 2.8 ] ],

      [ "crest o diameter", 0.4 ],
      [ "crest w diameter", 0.6 ],
      [ "crest b diameter", 0.4 ],
      [ "crest s diameter", 0.4 ],

      [ "crest o 0",
        [ "crest origin 0" ], [ "crest origin" ], [ "origin" ] ],
      [ "crest o",
        [ "origin" ],
        [ "crest origin" ], [ "waist" ], [ "crest waist" ] ],
      [ "crest w",
        [ "crest waist" ], [ "crest back" ], [ "waist" ], [ "back" ] ],
      [ "crest b",
        [ "crest back" ], [ "back" ], [ "crest shoulder" ], [ "shoulder" ] ],
      [ "crest s",
        [ "crest shoulder" ], [ "shoulder" ], [ "crest neck" ], [ "neck" ],
        [ "head" ] ],

      [ "l ball 1", [ "l ball" ], [ "l ball 1" ] ],
      [ "r ball 1", [ "r ball" ], [ "r ball 1" ] ],

      [ "l hand sca", [ 2, 1, 1 ] ],
      [ "r hand sca", [ 2, 1, 1 ] ],
      [ "l ball sca", [ 2, 1, 1 ] ],
      [ "r ball sca", [ 2, 1, 1 ] ],
    ]);

translate([ 0, dy, bpoint(bps, "z") + dz ]) {
  color("red") _bal(bpoint(bps, "origin"));
  draw_points(bps); }

//enumerate_points(bps);

translate([ 0, dy, bpoint(bps, "z") + dz ])
  draw_hulls(bps, hs);

//translate([ 0, 0, bpoint(bps, "z") + dz ])
//  color("cyan") _bal(bpoint(bps, "hip"), 1.4);

//hps = // head points

