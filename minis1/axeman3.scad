

//
// gerald.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;
include <mini_shields.scad>;


$fn = 24;

height = 33;


//
// axeman

bps = body_points(

  height,
  to_hip=90,

  to_left_knee=-80,
  to_left_ankle=-90,
  to_left_toe=[ 0, 10 ],

  to_right_knee=-95,
  to_right_ankle=-95,
  to_right_toe=[ 0, -10 ],

  to_left_elbow=[ -120, -20 ],
  to_left_wrist=[ -41, -20 ],
  to_left_finger=[ 13, 0 ],

  to_right_elbow=[ -110, 68 ],
  to_right_wrist=[ -40, -15 ],
  to_right_finger=[ -30, 45 ]
);
//echo(bps);
hh = bpoint(bps, "head height");

base(text=" No", font_size=5, font_spacing=0.75, $fn=12);

rotate([ 0, 0, -20 ]) {

  translate([ 0, 0, bps[6] ]) {
    body(bps,
      diameter=hh * 0.3,
      shoulder_diameter=hh * 0.35);
    //robe(bps);
    skirt(bps, 0.77, 0.77, topd=hh * 0.32, bottomd=hh * 0.70);
    //veil(bps);
    //skull(bps);
    rotate([ 0, 0, 10 ]) union() {
      head(bps);
      cap(bps);
    }

    sling_bag(bps);
  }

  translate([ 5.9, 5, 16.5 ])
    rotate([ -140, 0, 75 ])
      norse_axe(height * 0.52, hh * 1.11, hh * 0.31);

  translate([ -hh * 0.2, -hh * 0.38, height * 0.51 ])
    rotate([ 189, 10, 0 ])
      long_sword(hh * 2.6, hh * 0.6); // scramax

  //translate([ -1, -3, height * 0.63 ])
  //  rotate([ -10, -10, 161 ])
  //    round_shield(hh * 4.5, thickness=0.7);
  translate([ -hh, 2.7, height * 0.56 ])
    rotate([ 0, 0, 8 ])
      round_shield(hh * 4.9, thickness=0.9);
}

