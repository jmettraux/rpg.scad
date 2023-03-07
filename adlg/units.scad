
// units.scad

include <../minis2/doll2.scad>;


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

module unit_base(front, depth) {

  difference() {
    cube([ front, depth, base_height ], true);
    %cylinder(
  }
}
//unit_base(40, 40, 3);

module li_mini(i) {
  bps = make_humanoid_body_points([
    [ "height", 17 ]
  ]);
  move_z(bps)
    draw_points(bps);
}

module li() {
  unit_base(40, 20);
  for (i = [ 0 : 1 ]) {
    translate([ -10 + i * 20, 0, base_height ])
      li_mini(i);
  }
}
li();

