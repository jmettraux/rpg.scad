
//
// snake.scad
//

include <minilib.scad>;


$fn = 12;

hei = 33 * 0.63; // height
dia = 3.5; // diameter
con = 10; // convexity
twi = 400; // twist

hsi = hei / 3.5; // head side


base(text="", $fn=12);

module head() {
  rotate([ 0, 0, 90 ]) hull() {
    cylinder(d=hsi, h=hsi / 3, center=true, $fn=3);
    translate([ hsi / 2, 0, 0 ]) cylinder(d=hsi, h=hsi / 4, center=true, $fn=3);
  }
}

module body() {
  translate([ 0, 0, hei / 2 ])
    linear_extrude(height=hei, center=true, convexity=con, twist=twi)
      translate([ 2, 0, 0 ])
        circle(d=dia);
}


body();
translate([ hsi * 0.3, -hsi * 0.2, hei ]) rotate([ -20, 0, 0 ]) head();

