
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

