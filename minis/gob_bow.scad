

//
// humans.scad
//

include <minidoll.scad>;
include <mini_weapons.scad>;
include <mini_shields.scad>;


$fn = 24;

height = 33 / 6 * 4;


//
// axeman

bps = body_points(
  height,
  to_hip=90,
  to_navel=80,
  to_neck=80,
  to_head=80,
  to_left_knee=[ -70, 20 ],
  to_right_knee= [ -100, -20 ],
  to_right_ankle=-100,
  to_left_toe=[ 0, 10 ],
  to_right_toe=[ 0, -10 ],
  to_left_elbow=[ -40, 30 ],
  to_left_wrist=[ -30, -20 ],
  to_left_finger=[ 0, 0 ],
  to_right_elbow=[ -130, 30 ],
  to_right_wrist=[ -40, 25 ],
  to_right_finger=[ 0, 40 ]
);
//echo(bps);
hh = bpoint(bps, "head height");
hp = bpoint(bps, "head");

base(text="", $fn=12);

translate([ 0, -2, 0 ]) rotate([ 0, 0, 10 ]) {

  translate([ 0 , 0, bps[6] ]) {
    body(bps,
      diameter=hh * 0.4,
      shoulder_diameter=hh * 0.42);
    //robe(bps);
    skirt(bps, 0.77, 0.77, topd=hh * 0.42, bottomd=hh * 0.80);

    //veil(bps);
    //skull(bps);
    rotate([ 0, 0, 0 ]) union() {
      head(bps);
      //cap(bps);
      translate(hp + [ hh * 0.5, 0, hh * 0.2 ]) rotate([ 60, 10, 0 ])
        ear(hh * 1.0, hh * 0.6);
      translate(hp + [ -hh * 0.5, 0, hh * 0.2 ]) rotate([ -60, 10, 180 ])
        ear(hh * 1.0, hh * 0.6);
    }

    sling_bag(bps);
  }

  //translate([ 7, 0.8, height * 0.00 ])
  //  rotate([ 0, -10, 45 ])
  //    norse_axe(height * 0.52, hh * 1.11, hh * 0.31);
  //translate([ 6.3, 4.9, height / 2 ])
  //  rotate([ 0, 0, 0 ])
  //    quarterstaff(height * 1.13, hh * 0.38);
  translate([ 2, -1, height * 0.86 ])
    rotate([ 20, -180, -90 ])
      scimitar(height * 0.5, hh * 0.3);

  //translate([ -hh * 0.2, -hh * 0.38, height * 0.51 ])
  //  rotate([ 190, 15, 0 ])
  //    long_sword(hh * 2.6, hh * 0.6); // scramax
  translate([ hh * -0.7, hh * -0.5, height * 0.64 ])
    rotate([ 0, 0, 170 ])
      round_shield(hh * 4.2, thickness=0.5);

  translate([ -3.5, 8.1, 13 ])
    rotate([ -21, 20, 40 ])
      bow(height * 0.4, hh * 0.7);

  #translate([ -2, 6.9, height * 0.61 ])
    rotate([ 100, 0, 42 ])
      cylinder(d=0.5, h=10.5, center=true); // arrow
}

