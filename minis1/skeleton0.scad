
//
// skeleton0.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;


$fn = 24;

height = 33;


bps = body_points(

  height,

  to_hip=90,

  to_left_knee=-85,
  to_left_toe=[ 0, 15 ],

  to_right_knee=-85,
  to_right_ankle=-90,
  to_right_toe=[ 0, -10 ],

  to_left_elbow=[ -130, -70 ],
  to_left_wrist=[ -45, -60 ],
  to_left_finger=[ -20, -70 ],

  to_right_elbow=[ -130, 60 ],
  to_right_wrist=[ -45, 50 ],
  to_right_finger=[ -30, 78 ]
);
//echo(bps);
hh = bpoint(bps, "head height");

base(text="", $fn=12);

rotate([ 0, 0, 0 ]) {

  translate([ 0, 0, bps[6] ]) {
    body(bps,
      diameter=hh * 0.2,
      shoulder_diameter=hh * 0.2);
    //skirt(bps, 0.77, 0.77, topd=hh * 0.32, bottomd=hh * 0.70);
    rotate([ 0, 0, 0 ]) union() {
      skull(bps);
    }
  }

  translate([ 2.7, 1, 19 ])
    rotate([ 0, 0, 0 ])
      long_sword(height * 0.5, hh * 0.6);

}

