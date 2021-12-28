
//
// commoners.scad
//

height = 33;

//use <minis_core.scad>;
include <mini_core.scad>;
  // so that vars in minis_core.scad are brought in
include <mini_shields.scad>;
include <mini_weapons.scad>;

$fn = 24;

//translate([ 0, 0, 0 ])
//  segbal(head_height / 2, head_height * 6);
//translate([ 0, 10, 0 ])
//  segbal(head_height / 2, head_height * 6, yangle=10);
//
//translate([ 0, 20, 0 ])
//  hull() {
//    translate([ 0, 0, 0 ])
//      segbal(head_height * 0.7, head_height * 1.4); // waist
//    translate([ 0, 0, torso_height ])
//      //segbal(head_height * 0.9, head_height * 2, zangle=18); // shoulder
//      segbal(
//        head_height * 0.9,
//        head_height * 2,
//        balratio=0.5, yangle=18); // shoulder
//  };

base($fn=12);

  //module trapeze(
  //  bottom_d, bottom_l, top_d, top_l,
  //  h,
  //  bd2=0, td2=0,
  //  balratio=0.5, yangle=0, zangle=0)
  //
translate([ 0, -1.1, head_height * 3.1 ])
  rotate([ 0, 0, 10 ])
    trapeze(
      head_height * 1.6, head_height * 1.3,
      head_height * 1.4, head_height * 1.1,
      head_height * 1.6,
      zangle=10);

translate([ 0, -0.4, 0 ])
  rotate([ 0, 0, 10 ])
    torso_robe(10, 6, 8);

translate([ -head_height * 1.1, -2, 0 ])
  leg(
    5, 1, head_height / 3,
    knee_diameter = head_height / 2.2, leg_angle = 4);
translate([ head_height * 1.1, 0, 0 ])
  leg(
    1, 0, head_height / 3,
    knee_diameter = head_height / 2.2, leg_angle = -4);

//a = [ [ 1, 2 ] ];
//b = [ [ 3, 4 ] ];
//c = concat(a);
//echo(c);
//d = concat(c, b);
//echo(d);

