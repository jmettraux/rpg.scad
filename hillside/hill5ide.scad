
//
// hill5ide.scad
//

// unit is mm

inch = 25.4;
o2 = 0.2;
bd = 5; // ball diameter
br = bd / 2; // ball radius

h = bd + 6 * 0.2;
echo("h", h);

r = inch / 2;
t = r / cos(30);

l0 = inch;
l1 = 3 * t;

rr = r / 10;


module panel() {

  bar = br + 2 * o2;
  baro2 = bar + 4 * o2;

  module balcyl() {
    cylinder(r=bar, h=bd + 2 * o2, center=true, $fn=36);
  }
  module outcyl() {
    cylinder(r=baro2, h=h, center=true, $fn=36);
  }

  difference() {
  //union() {

    //cube(size=[ l0, l1, h ], center=true);
    hull() {
      translate([ -l0 / 2 + baro2, -l1 / 2 + baro2, 0 ]) outcyl();
      translate([ -l0 / 2 + baro2, l1 / 2 - baro2, 0 ]) outcyl();
      translate([ l0 / 2 - baro2, -l1 / 2 + baro2, 0 ]) outcyl();
      translate([ l0 / 2 - baro2, l1 / 2 - baro2, 0 ]) outcyl();
    }

    translate([ -l0 / 2 + baro2, -l1 / 2 + baro2, 0 ]) balcyl();
    translate([ -l0 / 2 + baro2, l1 / 2 - baro2, 0 ]) balcyl();
    translate([ l0 / 2 - baro2, -l1 / 2 + baro2, 0 ]) balcyl();
    translate([ l0 / 2 - baro2, l1 / 2 - baro2, 0 ]) balcyl();

    translate([ -l0 / 2 + baro2, 0, 0 ]) balcyl();
    translate([ l0 / 2 - baro2, 0, 0 ]) balcyl();
  }
}
//panel();

module hex() {

  module balcyl() {
    cylinder(r=br + 2 * o2, h=br * 2 + o2, center=true, $fn=36);
  }

  difference() {
    translate([ 0, 0, h * -0.5 ])
      hull()
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) {
            translate([ 0, t - rr, h - rr ]) sphere(r=rr, $fn=12);
            translate([ 0, t - rr, rr ]) sphere(r=rr, $fn=12);
          }
        }
    balcyl();
  }
}

module platter88() {

  tr2 = t + r / 2;

  for (x = [ 0 : 8 ]) {
    for (y = [ 0 : 8 ]) {
      if (y % 2 == 0) translate([ x * inch, y * tr2, 0 ]) hex();
      else translate([ r + x * inch, y * tr2, 0 ]) hex();
    }
  }
}
platter88();

