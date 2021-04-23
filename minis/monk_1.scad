

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

  to_left_knee=[ -90, 10 ],
  to_left_toe=[ 0, 0 ],
  //
  to_right_knee=-90,
  to_right_ankle=-90,
  to_right_toe=[ 0, -15 ],

  to_left_elbow=[ -110, -90 ],
  to_left_wrist=[ -40, -100 ],
  to_left_finger=[ -40, -80 ],
  //
  to_right_elbow=[ -127, 60 ],
  to_right_wrist=[ -40, 10 ],
  to_right_finger=[ -30, 8 ]
);
//echo(bps);
hh = bpoint(bps, "head height");

base(text=" M1", font_size=5, font_spacing=0.95, $fn=12);

rotate([ 0, 0, -10 ]) {

  translate([ 0, 0, bps[6] ]) {
    body(bps,
      diameter=hh * 0.3,
      shoulder_diameter=hh * 0.35);
    //robe(bps);
    skirt(bps, 1.97, 1.97, topd=hh * 0.32, bottomd=hh * 0.70);
    //veil(bps);
    //skull(bps);
    rotate([ 0, 0, 10 ]) union() {
      head(bps);
      cap(bps);
    }

    //sling_bag(bps);
  }

  //translate([ 7, 0.8, height * 0.00 ])
  //  rotate([ 0, -10, 45 ])
  //    norse_axe(height * 0.52, hh * 1.11, hh * 0.31);
  translate([ 6.3, 4.9, height / 4 ])
    rotate([ 0, 0, 0 ])
      quarterstaff(height * 0.53, hh * 0.38);
  //translate([ -hh * 0.2, -hh * 0.38, height * 0.51 ])
  //  rotate([ 190, 15, 0 ])
  //    long_sword(hh * 2.6, hh * 0.6); // scramax
}

