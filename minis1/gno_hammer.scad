
//
// gno_hammer.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;
//include <mini_shields.scad>;


$fn = 24;

height = 33 / 5.4 * 4;


bps = body_points(

  height,

  to_hip=90,
  to_navel=90,
  to_neck=90,
  to_head=90,

  to_left_knee=[ -80, 20 ],
  to_left_ankle=-90,
  to_left_toe=[ 0, 10 ],

  to_right_knee=[ -80, -20 ],
  to_right_ankle=-90,
  to_right_toe=[ 0, -17 ],

  to_left_elbow=[ -60, 90 ],
  to_left_wrist=[ -40, -90 ],
  to_left_finger=[ -90, 0 ],

  to_right_elbow=[ -70, -50 ],
  to_right_wrist=[ -40, -35 ],
  to_right_finger=[ 0, -35 ]
);
//echo(bps);
hh = bpoint(bps, "head height");
hp = bpoint(bps, "head");

base(text="", font_size=4, font_spacing=0.8, $fn=12);

translate([ 0, -2, 0 ]) rotate([ 0, 0, 5 ]) {

  translate([ 0 , 0, bps[6] ]) {
    body(bps,
      diameter=hh * 0.4,
      shoulder_diameter=hh * 0.42);
    //robe(bps);
    skirt(bps, 1.50, 1.50, topd=hh * 0.4, bottomd=hh * 0.90);

    rotate([ 0, 0, -5 ]) union() {
      head(bps);
      cap(bps);
    }

    //sling_bag(bps);
  }

  translate([ 6.4, 4.7, height * 0.31 ])
    rotate([ 0, 180, 90 ])
      hammer(hh * 4.2, hh * 0.8);
}

