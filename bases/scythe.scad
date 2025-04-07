
// unit is mm

$fn = 360;

// hole 6.62 x 6.62 x 2.49
// base dia 32mm with 5mm height

difference() {

  #cylinder(h=5, d=32);

  translate([ 0, 0, -0.1 ]) cylinder(h=2.49 + 0.1, d=6.62);
}

