
//
// house2.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
br = 1.7; // ball radius
o2 = 0.2;
h = 5; // height unit


module balcyl(deeper=false) {

  hf =
    is_num(deeper) ? deeper :
    deeper == true ? 2.8 :
    2;
  h = br * hf + o2;

  dz = hf > 2 ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module awall(base, side) {

  b2 = base / 2;
  angle = asin(b2 / side);
  height = b2 / tan(angle);

  //echo("awall height ft", height / inch * 5);
  //echo("awall height", height);

  a14 = cos(angle) * 0.5 * (side - inch);
  a34 = cos(angle) * 0.5 * (side + inch);
  o14 = sin(angle) * 0.5 * (side - inch);
  o34 = sin(angle) * 0.5 * (side + inch);

  //echo("awall side a14 a34", side, a14, a34);
  //echo("awall side o14 o34", side, o14, o34);

  d0 = br + 6 * o2;
  d1 = br + 6.5 * o2;

  difference() {

    translate([ 0, 0, -0.5 * h ])
      linear_extrude(h)
        polygon([ [ -b2, 0 ], [ b2, 0 ], [ 0, height ] ]);

    translate([ 0.25 * base, d0, 0 ]) balcyl();
    translate([ -0.25 * base, d0, 0 ]) balcyl();

    translate([ o14 - d1, height - a14, 0 ]) balcyl();
    translate([ o34 - d1, height - a34, 0 ]) balcyl();

    translate([ -o14 + d1, height - a14, 0 ]) balcyl();
    translate([ -o34 + d1, height - a34, 0 ]) balcyl();
  }
}

awall(2 * inch, 2.0 * inch);

