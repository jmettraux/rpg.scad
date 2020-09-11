
//
// minis_weapons.scad
//

// swords

module long_sword(length, handle_length) {

  l = length;
  hl = handle_length;
  hd = hl / 2; // handle diameter
  gh = hl / 4; // guard height
  tl = length / 10; // tip length
  bl = l - tl - hl - gh; // blade length
  bw = hl * 0.7; // blade width
  bd = hd * 0.7; // blade depth, well

  union() {
    // handle
    translate([ 0, 0, -hl / 2 - gh / 2 ])
      cylinder(d1=hd, d2=hd, h=hl, center=true);
    // guard
    translate([ 0, 0, 0 ])
      cube([ hl, hd, gh ], center=true);
    // blade
    translate([ 0, 0, gh / 2 + bl / 2 ])
      linear_extrude(bl, center=true)
        polygon(
          [ [ -bw / 2, 0 ], [ 0, bd / 2 ], [ bw / 2, 0 ], [ 0, -bd / 2 ] ]);
    // tip
    translate([ 0, 0, gh / 2 + bl + tl / 2 ])
      linear_extrude(tl, scale=0, center=true)
        polygon(
          [ [ -bw / 2, 0 ], [ 0, bd / 2 ], [ bw / 2, 0 ], [ 0, -bd / 2 ] ]);
  }
};

// axes

module housekarl_axe(length, diameter) {

  l = length;
  d = diameter;
  bd = l / 4; // blade diameter
  dp = 1;

  cylinder(d=d, h=l);

  translate([ -bd / 2, 0, l * 0.96 ])
    rotate([ 90, 0, 0 ])
      difference() {
        cylinder(d=bd, h=dp, center=true);
        union() {
          translate([ bd / 2.7,   bd / 1.9, dp * 0.05 ])
            cylinder(d=bd / 1.1, h=dp * 1.2, center=true);
          translate([ bd / 2.7, - bd / 1.9, dp * 0.05 ])
            cylinder(d=bd / 1.1, h=dp * 1.2, center=true);
        }
      }
};

// spears

module spear(length, rod_diameter, head_ratio=0.2, d1r=2.1, d2r=1.7) {

  rd = rod_diameter;

  l = length;
  hl = l * head_ratio; // head length
  rl = l - hl; // rod length
  hd1 = d1r * rd; // head width 1
  hd2 = d2r * rd; // head width 2

  // rod

  cylinder(d=rd, h=rl * 1.1);

  // spearhead

  hl0 = 0.4 * hl;
  hl1 = hl - hl0;
  translate([ 0, 0, rl ]) pyramid(hd1, w2=hd2, hl0, inverted=true);
  translate([ 0, 0, rl + hl0 ]) pyramid(hd1, w2=hd2, hl1);
}

