
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
}

module scimitar(length, width) {

  l = length;
  l1 = l * 0.7;
  w = width;
  w1 = w * 2.31;
  w2 = w * 2.6;
  t = 10;

  ps = concat(
    _bezier_points([ [ 0, 0 ], [ l, 0 ], [ l, w1 ] ], t),
    _bezier_points([ [ l, w1 ], [ l1, w1 ], [ l1, w2 ] ], t / 2),
    _bezier_points([ [ l1, w2 ], [ l1, w ], [ 0, w ] ], t),
    [ [ 0, w ], [ 0, 0 ] ]);

  gl = 2;
  gd = 0.7;
  gh = 0.7;

  rotate([ 0, -90, 180 ]) union() {
    translate([ 0, gl * 0.2, 0 ])
      cube([ gd, gl, gh ], center=true); // guard
    translate([ -gd * 1.2, gl * 0.2, 0 ])
      rotate([ 0, -90, 0 ])
        cylinder(r=0.4, h=2, center=true); // handle
    linear_extrude(height=0.51, center=true) polygon(ps); // blade
  }
}

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
}

module norse_axe(
  rod_length, depth, rod_diameter=0
) {

  rl = rod_length;
  rd = rod_diameter > 0 ? rod_diameter : rl / 10;
  bw = rd * 0.75; //blade width

  westd = depth * 2;
  northd = westd;
  southd = westd;

  north = [ -northd / 2, depth * 0.3, 0 ];
  south = [ southd / 2, -depth * 0.4, 0 ];

  cylinder(d=rd, h=rl);

  translate([ 0, 0, rl * 0.99 ])
    rotate([ 0, 90, 0 ])
      difference() {
        cylinder(d=westd, h=bw, center=true);
        translate(north) cylinder(d=northd, h=bw * 1.2, center=true);
        translate(south) cylinder(d=southd, h=bw * 1.2, center=true);
        translate([ 0, -rl / 4, 0 ]) cube([ rl, rl / 2, bw * 1.2 ], center=true);
      }
}

// spears

module spear(
  length, rod_diameter,
  head_ratio=0.2, d1r=2.1, d2r=1.7
) {

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

// staffs

module quarterstaff(length, diameter) {

  cylinder(d=diameter, h=length, center=true);
}

// bows

module bow(length, depth) {

  l = length;
  d = depth;
  l2 = length / 2;
  d1 = depth / 2;
  dh = 0.9;
  xh = 0.9;

  cpoints = [
    [ 0, 0 ], [ l2, d * -0.1 ], [ l2, d * 0.5 ], [ l2, d * 1.1 ], [ l, d ] ];
  bpoints = _bezier_points(
    cpoints, 10);
  //color("red", 0.5) polypoints(bpoints) { sphere($fn=60, r=0.3); };
  bpoints1 =
    [ for (p = bpoints) p + [ 0, dh ] ];
  ps = concat(bpoints, _reverse(bpoints1));

  rotate([ 0, 90, 180 ]) union() {
    linear_extrude(height=xh) polygon(ps);
    mirror([ 1, 0, 0 ]) linear_extrude(height=xh) polygon(ps);
  }
}

// hammers

module hammer(length, side, handle_diameter=-1) {

  hd = handle_diameter < 0 ? 1.4 : handle_diameter;

  cylinder(d=hd, h=length, center=true);
  translate([ 0, 0, length / 2 ])
    cube(size=[ side * 2, side, side ], center=true);
}

// seax

module seax(length, handle_length=-1, handle_radius=0.5) {

  l = length;
  hl = handle_length < 0 ? l / 3 : handle_length;
  hr = handle_radius;
  hd = hr * 2;

  st = 0.6; // scabbard thickness

    // handle
    //translate([ 0, 0, -hl / 2 - gh / 2 ])
  translate([ 0, 0, -hl / 3 ])
    cylinder(d1=hd, d2=hd, h=hl, center=true);

  translate([ -hr * 0.6, 0, 0 ]) difference() {
    translate([ 0, 0, -hl ]) hull() {
      cube([ hd * 2, st, hd ], center=true);
      translate([ 0, 0, -l ]) rotate([ 90, 0, 0 ]) cylinder(r=hd, h=st);
    }
    translate([ -hd * 0.7, -st * 0.1, -l ])
      cube([ hd * 1.1, st * 2, l * 2 ], center=true);
  }
}

