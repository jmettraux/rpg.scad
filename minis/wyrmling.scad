
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

      [ "l toe l", -20, -30, 0.7, "l ball" ],
      [ "l toe r", -20, 50, 0.7, "l ball" ],
      [ "r toe l", -20, -50, 0.7, "r ball" ],
      [ "r toe r", -20, 30, 0.7, "r ball" ],

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

      [ "tail 0",    -47,   0 ],
      [ "tail 0 c", -130, -10,  2.5, "origin" ],
      [ "tail 1",      -2,  100 ],
      [ "tail 1 c",    0,   0,  2, "tail 0" ],

      [ "l wing 1", 120, 10, 1, "l back" ],
      [ "l wing 10", 210, 10, 2.1, "l back" ],
      [ "l wing 2", 90, 0, 3.5, "l wing 1" ],
      [ "l wing 2c", 170, 0, 3.5, "l back" ],
      [ "l wing 20", -50, 0, 0.9, "l wing 2" ],
      [ "l wing 3", -110, 10, 7, "l wing 2" ],
      [ "l wing 4", -82, 0, 4.0, "l wing 3" ],

      [ "r wing 1", 120, -10, 1, "r back" ],
      [ "r wing 10", 210, -10, 2.1, "r back" ],
      [ "r wing 2", 90, 0, 3.5, "r wing 1" ],
      [ "r wing 2c", 170, 0, 3.5, "r back" ],
      [ "r wing 20", -50, 0, 0.9, "r wing 2" ],
      [ "r wing 2", 90, 0, 3.5, "r wing 1" ],
      [ "r wing 3", -110, -10, 7, "r wing 2" ],
      [ "r wing 4", -82, 0, 4.0, "r wing 3" ],
        ]);

bhs =
  _merge_hull_entries(
    concat(default_spine_hulls, default_leg_hulls, default_arm_hulls),
    [
      [ "l wing 10 dia", 1.4 ],
      [ "r wing 10 dia", 1.4 ],

      [ "tail 0", "bez",
        [ "origin", 1.8 ],
        [ "tail 0 c" ],
        [ "tail 0", 1 ] ],
      [ "tail 1", "bez",
        [ "tail 0", 1 ],
        [ "tail 1 c" ],
        [ "tail 1", 0.1 ] ],

      [ "l wing 1", [ "l back", 2.1 ], [ "l wing 1" ], [ "l wing 10" ] ],
      [ "l wing 2", [ "l wing 1" ], [ "l wing 2" ], [ "l wing 10" ] ],
      [ "l wing 4", [ "l wing 10" ], [ "l wing 4" ], [ "l wing 3" ] ],
      [ "l wing 2c", "bez",
        [ "l wing 2" ], [ "l wing 2c" ], [ "l wing 3" ],
        [ "l wing 10", undef, "hub" ] ],

      [ "l wing 20", "bez",
        [ "l wing 1" ], [ "l wing 2" ], [ "l wing 20" ],
        [ "l wing 2", undef, "hub" ] ],

      [ "r wing 1", [ "r back", 2.1 ], [ "r wing 1" ], [ "r wing 10" ] ],
      [ "r wing 2", [ "r wing 1" ], [ "r wing 2" ], [ "r wing 10" ] ],
      [ "r wing 4", [ "r wing 10" ], [ "r wing 4" ], [ "r wing 3" ] ],
      [ "r wing 2c", "bez",
        [ "r wing 2" ], [ "r wing 2c" ], [ "r wing 3" ],
        [ "r wing 10", undef, "hub" ] ],

      [ "r wing 20", "bez",
        [ "r wing 1" ], [ "r wing 2" ], [ "r wing 20" ],
        [ "r wing 2", undef, "hub" ] ],

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

      [ "l toe l", [ "l ball" ], [ "l toe l" ] ],
      [ "l toe r", [ "l ball" ], [ "l toe r" ] ],
      [ "r toe l", [ "r ball" ], [ "r toe l" ] ],
      [ "r toe r", [ "r ball" ], [ "r toe r" ] ],

      [ "l hand sca", [ 2, 1, 1 ] ],
      [ "r hand sca", [ 2, 1, 1 ] ],
      [ "l ball sca", [ 2, 1, 1 ] ],
      [ "r ball sca", [ 2, 1, 1 ] ],
    ]);

//enumerate_points(bps);

translate([ 0, dy, bpoint(bps, "z") + dz ]) {
  //color("cyan") _bal(bpoint(bps, "l wing 20"), 0.8, $fn=36);
  //draw_points(bps);
  draw_hulls(bps, bhs);
    }

//translate([ 0, 0, bpoint(bps, "z") + dz ])
//  color("cyan") _bal(bpoint(bps, "hip"), 1.4);

ph = bpoint(bps, "head");
//echo(ph);
//echo(bpoint(bps, "neck"));

hps = _merge_point_entries(
  default_head_points,
  [
    [ "height", 49 ],
    [ "side nose ratio", 0.3 ],

    [ "tip 1", -80, 0, 0.3, "tip" ],

    [ "nose 1", "orbit", 3.2 ],

    [ "crest", 110, 0, 1.0, "origin" ],
  ]);

hhs = _merge_hull_entries(
  default_head_hulls,
  [

    [ "nose 1",
      [ "nose 1" ], [ "tip 1" ], [ "l tip" ], [ "r tip" ],
      [ "orbit" ], [ "l nose" ], [ "r nose" ] ],

    [ "crest",
      [ "front", 0.4 ], [ "crest", 0.4 ], [ "occipital", 0.4 ] ],
  ]);

//enumerate_points(hps);

translate([ 0, ph.y + dy - 7, bpoint(bps, "z") + ph.z + dz - 2 ])
  rotate([ -30, 0, 0 ]) {
    //color("cyan") _bal(bpoint(hps, "crest"), 0.8, $fn=36);
    //draw_points(hps);
    draw_hulls(hps, hhs);
  }

