

//
// gob_scimitar1.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;
include <mini_shields.scad>;


$fn = 24;

height = 33 / 6 * 4;


//
// posture

bps = body_points(
  height,
  to_hip=90,
  to_navel=80,
  to_neck=80,
  to_head=80,
  to_left_knee=[ -70, 20 ],
  to_right_knee= [ -80, -30 ],
  to_right_ankle=-90,
  to_left_toe=[ 0, 10 ],
  to_right_toe=[ 0, -17 ],

  to_left_elbow=[ -105, -20 ],
  to_left_wrist=[ -18, -40 ],
  to_left_finger=[ 13, 0 ],

  to_right_elbow=[ -110, 68 ],
  to_right_wrist=[ -40, 25 ],
  to_right_finger=[ -30, 45 ]
);
//echo(bps);
hh = bpoint(bps, "head height");
hp = bpoint(bps, "head");

base(text="", $fn=12);

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
      //cap(bps);
      translate(hp + [ hh * 0.5, 0, hh * 0.2 ]) rotate([ 60, 10, 0 ])
        ear(hh * 1.0, hh * 0.6);
      translate(hp + [ -hh * 0.5, 0, hh * 0.2 ]) rotate([ -60, 10, 180 ])
        ear(hh * 1.0, hh * 0.6);
    }

    sling_bag(bps);
  }

  translate([ 1.50, 4.7, height * 0.53 ])
    rotate([ -16, -13, 0 ])
      scimitar(height * 0.5, hh * 0.3);

  translate([ -6.9, 1.31, height * 0.32 ])
    rotate([ -7, 12, 0 ])
      roman_shield(height * 0.67, height * 0.4, 3);
}

