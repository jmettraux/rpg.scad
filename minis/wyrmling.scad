
//
// wyrmling.scad
//

include <minidoll2.scad>;


dy = -7;


#base(text=" W", font_size=5, font_spacing=0.95, $fn=12);

bps =
  _merge_body_entries(
    concat(quadruped_body_points, tail_2_points),
    [
      [ "l knee",    45,  20 ],
      [ "l ankle", -100,   0 ],
      [ "l ball",   -80, -40 ],
      [ "l toe",    -30,  10 ],

      [ "r knee",    45, -20 ],
      [ "r ankle", -100,   0 ],
      [ "r ball",   -80,  40 ],
      [ "r toe",    -30, -10 ],

      [ "waist",     80,   0 ],
      [ "back",      80,   0 ],
      [ "shoulder",  80,   0 ],
      [ "neck",      80,   0 ],
      [ "head",      80,   0 ],

      [ "tail 0",    -47,   0 ],
      [ "tail 0 c", -130, -10,  2.5, "origin" ],
      [ "tail 1",      0,  75 ],
      [ "tail 1 c",    0,   0,  1, "tail 0" ],

      [ "l wing 1", 120, 10, "wing 1 ratio", "l back" ],
      [ "l wing 2", 90, 0, 3.5, "l wing 1" ],
      [ "l wing 3", -110, 10, 7, "l wing 2" ],
      [ "l wing 4", -60, 0, 4.6, "l wing 3" ],

      [ "r wing 1", 120, -10, "wing 1 ratio", "r back" ],
      [ "r wing 2", 90, 0, 3.5, "r wing 1" ],
      [ "r wing 3", -110, -10, 7, "r wing 2" ],
      [ "r wing 4", -60, 0, 4.6, "r wing 3" ],
        ]);

//echo("z:", bpoint(bps, "z"));

translate([ 0, dy, bpoint(bps, "z") ]) {
  color("red") _bal(bpoint(bps, "origin"));
  draw_body_balls(bps);
}

hs =
  _merge_hull_entries(
    concat(default_spine_hulls, default_leg_hulls, default_arm_hulls),
    [
      [ "tail 0", "bez",
        [ "origin", 1.4 ],
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
    ]);

translate([ 0, dy, bpoint(bps, "z") ])
  draw_body_hulls(bps, hs);


//translate([ 0, 0, bpoint(bps, "z") ])
//  color("cyan") _bal(bpoint(bps, "hip"), 1.4);

