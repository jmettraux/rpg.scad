
//
// weapons.scad
//


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
}


//
// spears

module pyramid(width1, height, w2=0, inverted=false) {

  w1 = width1 / 2;
  w2 = w2 == 0 ? w1 / 2 : w2 / 2;

  translate([ 0, 0, inverted ? height : 0 ])
    rotate([ inverted ? 180 : 0, 0, 0 ])
      linear_extrude(height, scale=0)
        polygon([ [ -w1, 0 ], [ 0, w2 ], [ w1, 0 ], [ 0, -w2 ] ]);
};

module spear(length, diameter, head_ratio=0.2, d1r=2.1, d2r=1.7) {

  // rod

  translate([ 0, 0, length * 0.5 ])
    cylinder(d=diameter, h=length, center=true, $fn=18);

  // spearhead

  hl = length * head_ratio;
  rl = length - hl;
  hl0 = 0.4 * hl;
  hl1 = hl - hl0;

  hd1 = d1r * diameter; // head width 1
  hd2 = d2r * diameter; // head width 2

  color("silver") {
    translate([ 0, 0, rl + hl * 0.72 ])
      pyramid(hd1, w2=hd2, hl0, inverted=true);
    translate([ 0, 0, rl + hl * 0.72 + hl0 ])
      pyramid(hd1, w2=hd2, hl1);
  }
}

//
// shields

module tear_shield(height, width, thickness=1) {

  t = thickness;
  d = t * 2;

  rotate([ 270, 0, 0 ])
    hull() {
      translate([ 0, 0, 0 ])
        cylinder(d=width, h=t, center=true);
      translate([ 0, height, 0 ])
        cylinder(d=d, h=t, center=true, $fn=12);
    }
};

module round_shield(diameter, thickness=1) {

  rotate([ 270, 0, 0 ])
    cylinder(d=diameter, h=thickness, center=true, $fn=12);
};

