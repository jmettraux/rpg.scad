
//
// chexes.scad
//

// unit is mm

inch = 25.4;
h = 5; // height unit, 5mm
o2 = 0.2;
//br = 3 / 2; // ball radius
br = 1.7;

r = inch / 2;
t = r / cos(30);
rr = r / 10;

//echo(inch, r, t);
//echo("bh", br + 2 * o2);
//echo("br + 2 * o2", 5 + 2 * o2);

module sphe() { sphere(r=rr, $fn=12); }

module balcyl() {

  hf = 2;
  h = br * hf + o2;

  dz = hf > 2 ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module hex() {

  difference() {

    translate([ 0, 0, h * -0.5 ])
      hull()
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) {
            translate([ 0, t - rr, h - rr ]) sphe();
            translate([ 0, t - rr, rr ]) sphe();
          }
        }

    union() {

      balcyl();

      for (a = [ 30 : 60 : 330 ]) {
        //echo(a);
        rotate([ 0, 0, a ]) translate([ 0, r - br - 4 * o2, 0 ]) balcyl();
      }
    }
  }
}


//a = 0; x = -3; y = -7; symbol = "\u2665", size=16); // heart
//a = 0; x = -7; y = -7; symbol = "\u25BC"; size = 16; // head down triangle
a = 0; x = -7; y = -7; symbol = "\u2192"; size = 16; // arrow right
//a = 0; x = -7; y = -7; symbol = "\u2660"; size = 16; // spade
//a = 0; x = -7; y = -7; symbol = "\u2663"; size = 16; // club
//a = 0; x = -7; y = -7; symbol = "\u2666"; size = 16; // diamond


difference() {
  rotate([ 0, 0, a ]) hex();
  #translate([ x, y, 1.9 ]) linear_extrude(5) text(symbol, size=size);
}

