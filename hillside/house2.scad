
//
// house2.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
br = 1.7; // ball radius
o2 = 0.2;
h = 5; // height unit
sr = inch / 20; // sphe radius


module sphe() { sphere(r=sr, $fn=12); }

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
  atop = asin(b2 / side);
  abase = (180 - atop * 2) / 2;
  height = b2 / tan(atop);

  echo("atop", atop, "abase", abase, "total", 2 * atop + 2 * abase);

  echo("awall", "base", base / inch, "side", side / inch);
  echo("awall height", height);
  echo("awall height in", height / inch);
  echo("awall height ft", height / inch * 5);

  a14 = cos(atop) * 0.5 * (side - inch);
  a34 = cos(atop) * 0.5 * (side + inch);
  o14 = sin(atop) * 0.5 * (side - inch);
  o34 = sin(atop) * 0.5 * (side + inch);

  //echo("awall side a14 a34", side, a14, a34);
  //echo("awall side o14 o34", side, o14, o34);

  d0 = br + 6 * o2;
  d1 = br + 6.5 * o2;

  h0 = -0.5 * h + sr / 2;
  h1 = 0.5 * h - sr / 2;
  //echo("h0", h0, "h1", h1);

  difference() {

    //%translate([ 0, 0, -0.5 * h ])
    //  linear_extrude(h)
    //    polygon([ [ -b2, 0 ], [ b2, 0 ], [ 0, height ] ]);
    hull() {
      dx = sr / tan(abase / 2);
      dy = sr / sin(atop);
      for (h = [ h0, h1 ]) {
        translate([ b2 - dx, sr, h ]) sphe();
        translate([ -b2 + dx, sr, h ]) sphe();
        translate([ 0, height - dy, h ]) sphe();
      }
    }

    translate([ 0.25 * base, d0, 0 ]) balcyl();
    translate([ -0.25 * base, d0, 0 ]) balcyl();

    translate([ o14 - d1, height - a14, 0 ]) balcyl();
    translate([ o34 - d1, height - a34, 0 ]) balcyl();

    translate([ -o14 + d1, height - a14, 0 ]) balcyl();
    translate([ -o34 + d1, height - a34, 0 ]) balcyl();
  }
}

//awall(2.5 * inch, 3 * inch);

module balcyls() {
  balcyl();
  for (a = [ 0 : 90 : 270 ]) {
    rotate([ 0, 0, a ]) translate([ 0, inch / 2 - br - 5 * o2, 0 ]) balcyl();
  }
}

module plank(width, length) {

  w2 = width / 2;
  l2 = length / 2;

  hei = 1 * h;

  h0 = -0.5 * h + sr;
  h1 = 0.5 * h - sr;
  //echo("h0", h0, "h1", h1);

  d0 = br + o2;

  difference() {

    hull() {
      for (h = [ h0, h1 ]) {
        translate([ w2, -l2, h ]) sphe();
        translate([ -w2, -l2, h ]) sphe();
        translate([ w2, l2, h ]) sphe();
        translate([ -w2, l2, h ]) sphe();
      }
    }

    for (x = [ 0 : inch : width - inch ])
      for (y = [ 0 : inch : length - inch ])
        translate([ x - w2 + inch / 2, y - l2 + inch / 2, 0 ]) balcyls();
  }
}

plank(2 * inch, 3 * inch);

