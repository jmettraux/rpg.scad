
// units.scad

include <../minis2/doll2.scad>;
include <../minis2/weapons.scad>;


// 15mm
//
// | name          | figs     | size    |
// |---------------|----------|---------|
// | LI            | 2        | 40x20mm |
// | MI            | 6 or 8   | 40x40mm |
// | HI            | 8        | 40x30mm |
// | PK            | 12 or 16 | 40x40mm |
// | LH            | 2        | 40x30mm |
// | CV            | 3        | 40x30mm |
// | CT cataphract | 3 or 4   | 40x30mm |
// | LV levy       | 5 to 8   | 40x30mm |
// | LCh or HCh    | 1        | 40x40mm |
// | ELE or ART    | 1        | 40x40mm |
// | WG war wagon  | 1        | 40x80mm |
// | CP camp       | variable | 40x80mm |

base_height = 2;
mini_height = 15;

hull_diameters = [
  [ "knee diameter",      0.7 ],
  [ "leg diameter",       0.9 ],
  [ "thigh diameter",     0.9 ],
  [ "hip diameter",       0.9 ],
  [ "waist diameter",     0.7 ],
  [ "shoulder diameter",  0.9 ],
  [ "neck diameter",      0.6 ],
];

module unit_base(front, depth, label=undef) {

  cube([ front, depth, base_height ], true);
  if ( ! is_undef(label)) {
    translate([ -front * 0.47, -depth * 0.40, base_height * 0.3 ])
      linear_extrude(0.8) text(label, size=5, font="Courier");
  }
}

module li_mini(i) {

  bps = make_humanoid_body_points([
    [ "height", mini_height ],
    [ "r elbow", -70,  0, "elbow ratio", "r shoulder" ],
    [ "r wrist", -60,  0, "wrist ratio", "r elbow" ],
    [ "r hand",  -40,  0, "hand ratio", "r wrist" ],
    [ "l hand",  -60, 10, "hand ratio", "l wrist" ]
  ]);
  hs = make_humanoid_body_hulls(hull_diameters);

  supported(base_thickness=base_height) {

    move_z(bps) draw_hulls(bps, hs);

    translate([ 0, 0, mini_height * 0.99 ])
      scale([ 0.8, 1, 1 ])
        sphere(d=2.6, $fn=24);

    translate([ -3, 0.4, mini_height * 0.5 ])
      rotate([ 0, 0, 45 ])
        color("lightblue") round_shield(7, 0.6);

    support_at(-3, 0.4, mini_height * 0.5);

    translate([ 2.1, 2.7, base_height * 0 ])
      spear(length=15, diameter=0.6);
  }
}

module li() {

  unit_base(40, 20, "LI");

  for (i = [ 0 : 1 ]) {
    translate([ -10 + i * 20, 0, base_height * 0.5 ])
      li_mini(i);
  }
}
li();

