

//
// gnome_1.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;
//include <mini_shields.scad>;


$fn = 24;

height = 33 / 5.4 * 4;


bps = body_points(

  height,

  to_hip=90,
  to_navel=80,
  to_neck=80,
  to_head=80,

  to_left_knee=[ -70, 20 ],
  to_left_ankle=-90,
  to_left_toe=[ 0, 10 ],

  to_right_knee=[ -70, -20 ],
  to_right_ankle=-90,
  to_right_toe=[ 0, -17 ],

  to_left_elbow=[ -140, -40 ],
  to_left_wrist=[ -50, -20 ],
  to_left_finger=[ -20, -70 ],

  to_right_elbow=[ -140, 40 ],
  to_right_wrist=[ -50, 20 ],
  to_right_finger=[ -20, 70 ]
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
    skirt(bps, 0.77, 0.77, topd=hh * 0.42, bottomd=hh * 0.80);

    //veil(bps);
    //skull(bps);
    rotate([ 0, 0, -5 ]) union() {
      head(bps);
      cap(bps);
      //translate(hp + [ hh * 0.5, 0, hh * 0.2 ]) rotate([ 60, 10, 0 ])
      //  ear(hh * 1.0, hh * 0.6);
      //translate(hp + [ -hh * 0.5, 0, hh * 0.2 ]) rotate([ -60, 10, 180 ])
      //  ear(hh * 1.0, hh * 0.6);
    }

    sling_bag(bps);
  }

  translate([ 3.1, 2.1, height * 0.56 ])
    rotate([ 0, -45, -70 ])
      long_sword(height * 0.3, hh * 0.6);
  //translate([ -6.9, 1.1, height * 0.24 ])
  //  rotate([ -7, 0, 0 ])
  //    roman_shield(height * 0.67, height * 0.4, 3);
}

