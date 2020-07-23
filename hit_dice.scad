
$fn=12;

// unit is mm

side = 14;
depth = 3;

s = side / 2.4;


difference() {

  cube([ side, side, side ], center=true);

  translate([ -s, -s, side / 2 - depth / 4 ])
    linear_extrude(1.1 * depth)
      text("\u2665", size=10);
}

