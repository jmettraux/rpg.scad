
//
// minis_footmen.scad
//

height = 33;

//use <minis_core.scad>;
include <minis_core.scad>;
  // so that vars in minis_core.scad are brought in
include <minis_shields.scad>;
include <minis_weapons.scad>;

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

translate([ -6, -2.7, height * 0.55 ])
  rotate([ 180 + 3, 0, -47 ])
    long_sword(head_height * 3.7); // scramax
//translate([ 5, 3.9, 1.8 ])
//  rotate([ 0, 0, 90 + 45 + 2 ])
//    housekarl_axe(head_height * 6.0);
translate([ 7.7, 4.3, 0 ])
  spear(height / 6 * 7); // 7ft vs 6ft
  //spear(height / 6 * 8); // 8ft vs 6ft

sh = leg_height + torso_height - head_height;
//translate([ -5, 4.1, sh * 1.1 ])
//  rotate([ 0, 0, 30 ])
//    tear_shield(sh, sh / 2);
translate([ -5, 3.3, sh * 0.85 ])
  rotate([ -2, 0, 30 ])
    round_shield(base_diameter * 0.75);

// arms

arm_diameter = 0.8 * head_height;

translate([ 6.5, 0, height * 0.613 ])
  rotate([ 0, -10, -26 ])
    arm(arm_diameter, 45);
translate([ -6.5, 0, height * 0.613 ])
  rotate([ 0, 0, -48.4 ])
    arm(arm_diameter, 90);

