
//
// commoners.scad
//

height = 33;

//use <minis_core.scad>;
include <minis_core.scad>;
  // so that vars in minis_core.scad are brought in
include <minis_shields.scad>;
include <minis_weapons.scad>;

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

translate([ 0, 30, 0 ])
  trapeze(
    head_height * 0.7, head_height * 1.4, // bottom
    head_height * 0.9, head_height * 2, // top
    torso_height); // bottom to top distance

leg(10, 15, head_height / 4, knee_diameter = head_height / 3);

