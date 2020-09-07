
use <../cadence/src/cadence.scad>;

$fn=18;

// unit is mm

diameter = 90;
height = 28;
border_height = 14;
border_width = 2;
r = diameter/2;


translate([ 0, 0, 0 ])
  cylinder(h=border_width, r=r + border_width, center=true);

translate([ 0, 0, border_height / 2 ])
  difference() {
    cylinder(h=border_height, r=r + border_width, center=true);
    cylinder(h=border_height + 1, r=r, center=true);
  }

module beam(side, height, rot) {
  rotate([ 0, 0, rot ])
    linear_extrude(height=height, center=true)
      polygon([
        [ 0, 0 ], [ side, side ], [ side * 1.2, 0 ],
        [ side, -side ] ]);
}

s = 9;
h = 70;
d = 100 * 0.99 / 2;
dz = h / 2 - border_width / 2;
  //
translate([ -d, 0, dz ]) beam(s, h, 0);
translate([ 0, -d, dz ]) beam(s, h, 90);
translate([ d, 0, dz ]) beam(s, h, 180);
translate([ 0, d, dz ]) beam(s, h, 270);


module arc(x, y, rot) {
  translate([ x, y, h * 0.7 ])
    rotate([ 0, 0, rot ]) rotate([ 0, -90, 0 ])
      paslice(35, border_width, radius1=24, slice=180);
}

//translate([ 24, 24, h * 0.7 ])
//  rotate([ 0, 0, 0 ]) rotate([ 0, -90, 0 ])
//    paslice(35, border_width, radius1=30, slice=180);
arc(24.7, 24.7, 45);
arc(-23.3, -23.3, 45);
arc(23.3, -23.3, 135);
arc(-24.7, 24.7, 135);

