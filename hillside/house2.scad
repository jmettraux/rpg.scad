
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

module line_balcyls(length, interval=inch) {
  //odd = (length / interval) % 2;
  i2 = interval / 2;
  #cube(br * 2, center=true);
  //translate([ -length / 2 + interval / 2, 0, 0 ])
    for (x = [ 0 : interval : length - i2 ])
      translate([ i2 + x, 0, 0 ]) balcyl();
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

  //d0 = br + 6 * o2;
  d1 = br + 6.5 * o2;

  h0 = -0.5 * h + sr;
  h1 = 0.5 * h - sr;
  //echo("h0", h0, "h1", h1);

  dx = sr / tan(abase / 2);
  dy = sr / sin(atop);

  union() {

    %hull() {
      for (h = [ h0, h1 ]) {
        translate([ b2 - dx, sr, h ]) sphe();
        translate([ -b2 + dx, sr, h ]) sphe();
        translate([ 0, height - dy, h ]) sphe();
      }
    }

    //translate([ 0, br + 6 * o2, 0]) line_balcyls(base);
translate([ -b2, d1, 0 ]) line_balcyls(base);

    translate([ 0, height - dy - d1 * 2, 0 ])
      rotate([ 0, 0, - 45 -atop ]) line_balcyls(side);
    translate([ 0, height - dy - d1 * 2, 0 ])
      rotate([ 0, 0, 180 + 45 + atop ]) line_balcyls(side);
  }
}

awall(3 * inch, 4 * inch);


module sq_balcyls() {
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
        translate([ x - w2 + inch / 2, y - l2 + inch / 2, 0 ]) sq_balcyls();
  }
}

//plank(2 * inch, 3 * inch);

