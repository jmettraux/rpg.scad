
// minis_footman.scad

height = 33;

//use <minis_core.scad>;
include <minis_core.scad>;

$fn = 24;

base();
//leg_robe(10, 7);
//leg_norman(9, 7);
leg_norman_short(8, 7);
torso_robe(10, 7, 8);
//#neck_robe(5, 5);
//head_robe(head_height * 1.3);
//big_helm(6);
hastings_helmet(6);


sh = leg_height + torso_height - head_height;
//translate([ -5, 4.1, sh * 1.1 ])
//  rotate([ 0, 0, 30 ])
//    tear_shield(sh, sh / 2);
translate([ -5, 3.7, sh * 0.85 ])
  rotate([ -2, 0, 30 ])
    round_shield(base_diameter * 0.75);

//translate([ 4, 3.9, height * 0.5 ])
//  long_sword(head_height * 7);
translate([ 5, 3.9, 2.1 ])
  rotate([ 0, 0, 90 + 45 - 10 ])
    housekarl_axe(head_height * 6.7);

// arms
translate([ 8 * 0.7 , 0, height * 0.75 ])
  segment(head_height, 2.5 * head_height, -70);
translate([ -8 * 0.7 , 0, height * 0.75 ])
  segment(head_height, 1.5 * head_height, -85);

