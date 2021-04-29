

//
// monk_0.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;


$fn = 24;

//height = 33;
height = 33.4; // slightly taller


bps = body_points(

  height,
  to_hip=90,

  to_left_knee=[ -85, 40 ],
  to_left_toe=[ 0, 35 ],
  //
  to_right_knee=-90,
  to_right_ankle=-90,
  to_right_toe=[ 0, -15 ],

  to_left_elbow=[ -100, -70 ],
  to_left_wrist=[ -40, -60 ],
  to_left_finger=[ -40, -80 ],
  //
  to_right_elbow=[ -127, 60 ],
  to_right_wrist=[ -40, 10 ],
  to_right_finger=[ -30, 8 ]
);
//echo(bps);
hh = bpoint(bps, "head height");

//base(text=" M0", font_size=5, font_spacing=0.95, $fn=12);

body(bps, diameter=hh * 0.3, shoulder_diameter=hh * 0.35);
head(bps);
phrygian_cap(bps);

