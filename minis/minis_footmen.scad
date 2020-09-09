
// minis_footman.scad

height = 33;

//use <minis_core.scad>;
include <minis_core.scad>;
  // so that vars in minis_core.scad are brought in

$fn = 24;

base();
//leg_robe(10, 7);
//leg_norman(9, 7);
leg_norman_short(8, 7);
//leg_norman_guard_short(8, 7);
torso_robe(10, 7, 8);
//#neck_robe(5, 5);
//head_robe(head_height * 1.3);
//big_helm(6);
hastings_helmet(6);


sh = leg_height + torso_height - head_height;
//translate([ -5, 4.1, sh * 1.1 ])
//  rotate([ 0, 0, 30 ])
//    tear_shield(sh, sh / 2);
translate([ -5, 3.3, sh * 0.85 ])
  rotate([ -2, 0, 30 ])
    round_shield(base_diameter * 0.75);

//translate([ 4, 3.9, height * 0.5 ])
//  long_sword(head_height * 7);
//translate([ 5, 3.9, 1.8 ])
//  rotate([ 0, 0, 90 + 45 + 2 ])
//    housekarl_axe(head_height * 6.0);
translate([ 7.5, 4, 0 ])
  spear(height / 6 * 7); // 7ft vs 6ft
  //spear(height / 6 * 8); // 8ft vs 6ft

// arms

//translate([ 8 * 0.7 , 0, height * 0.75 ])
//  segment(head_height, 2.5 * head_height, -70); // right
translate([ 6.5, 0, height * 0.613 ])
  rotate([ 0, -10, -26 ])
  arm(0.80 * head_height, 45);
    //segment(head_height, 2.5 * head_height, -70); // right
translate([ -8 * 0.7 , 0, height * 0.75 ])
  segment(head_height, 1.5 * head_height, -85);

