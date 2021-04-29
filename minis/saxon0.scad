

//
// humans.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;


$fn = 24;

height = 33;


//
// axeman

bps = body_points(
  height,
  to_hip=90,
  to_left_knee=[ -80, 30 ],
  to_right_knee=-90,
  to_right_ankle=-90,
  to_left_toe=[ 0, 10 ],
  to_right_toe=[ 0, -10 ],
  to_left_elbow=[ -120, -70 ],
  to_left_wrist=[ -45, -70 ],
  to_left_finger=[ -20, -80 ],
  to_right_elbow=[ -127, 60 ],
  to_right_wrist=[ -40, 10 ],
  to_right_finger=[ -30, 8 ]
);
//echo(bps);
hh = bpoint(bps, "head height");

base(text="", $fn=12);

rotate([ 0, 0, -10 ]) {

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
      phrygian_cap(bps);
    }

    sling_bag(bps);
  }

  //translate([ 7, 0.8, height * 0.00 ])
  //  rotate([ 0, -10, 45 ])
  //    norse_axe(height * 0.52, hh * 1.11, hh * 0.31);
  translate([ 6.3, 4.9, height / 2 ])
    rotate([ 0, 0, 0 ])
      quarterstaff(height * 1.03, hh * 0.38);

  translate([ hh * 0.7, -hh * 0.38, height * 0.51 ])
    rotate([ 0, 77, -7 ])
      seax(hh * 1.1);
}

