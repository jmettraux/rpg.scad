
//
// wolf.scad
//

include <minidoll.scad>;


$fn = 24;

height = 33;


bps = body_points(

  height,
  thigh_length_ratio=1.5,

  to_low_hip=0,
  to_hip=0,
  to_navel=0,
  to_neck=0,
  to_head=0,

  to_left_knee=-40,
  to_left_ankle=-110,
  to_left_toe=[ -80, 0 ],
  //
  to_right_knee=-40,
  to_right_ankle=-110,
  to_right_toe=[ -80, 0 ],

  to_left_elbow=[ -80, 0 ],
  to_left_wrist=[ -70, 0 ],
  to_left_finger=[ -60, 0 ],
  //
  to_right_elbow=[ -80, 0 ],
  to_right_wrist=[ -70, 0 ],
  to_right_finger=[ -60, 0 ]
);
//echo(bps);
hh = bpoint(bps, "head height");

base(text=" W0", font_size=5, font_spacing=0.95, $fn=12);

rotate([ 0, 0, 0 ]) {

  translate([ 0, -7, bps[6] ]) {

    body(bps,
      diameter=hh * 0.3,
      shoulder_diameter=hh * 0.35);
    //skull(bps);

    //rotate([ 0, 0, 40 ]) union() {
    head(bps);
    //}
  }
}

