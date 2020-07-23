
$fn=12;

// unit is mm

side = 24;
depth = 3;

s = side / 2.8;


difference() {

  cube([ side, side, side ], center=true);

  translate([ -s, -s, side / 2 - depth / 3 ])
    linear_extrude(1.1 * depth)
      text("\u2665", size=13);
}

