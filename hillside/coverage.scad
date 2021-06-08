
//
// coverage.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
o2 = 0.2;
bd = 5; // ball diameter

br = bd / 2;
td = 2 * bd; // trunk diameter
in2 = inch / 2;
k0 = bd + 2 * o2;
k1 = bd + td / 2 + 2 * o2;

rr = inch / 20;

module bal() { sphere(r=rr, $fn=12); }
//module notch() { paslice(k1, k0, slice=60); }

module balcyl(deeper=false) {

  h = deeper ? br * 2.8 + o2 : br * 2 + o2;
  dz = deeper ? -3 * o2 : 0;

  translate([ 0, 0, dz + h / 2  ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module trunk(height, reach=inch / 2.1) {

  module root() {

    translate([ 0, 0, -0.4 ]) {

      ps = [
        [ reach, 0, 0 ], [ reach / 4, 0, reach/ 4 ], [ td / 2.8, 0, reach ] ];
      ps1 = _bezier_points(ps, 8);
      polyhulls(ps1) { bal(); }

      for (i = [ 0 : len(ps1) - 2 ])
        hull() {
          translate(ps1[i]) bal();
          translate(ps1[i + 1]) bal();
          translate([ 0, -bd / 2, 0 ]) bal();
          translate([ 0, bd / 2, 0 ]) bal();
        }
    }
  }

  difference() {

    union() {
      cylinder(d=td, h=height, $fn=8); // trunk
      for (a = [ 0 : 90 : 270 ]) rotate([ 0, 0, a ]) root();
    }

    translate([ 0, 0, -10 / 2 ])
      cube(size=[ 2 * inch, 2 * inch, 10 ], center=true);

    translate([ 0, 0, 2 * o2 ]) balcyl();
    //translate([ 0, 0, height - br * 2.8 - 2 * o2 ]) balcyl(true);
  }
}

module pyramidal(diameter, height) {

  r = diameter / 2;
  td1 = td + 3 * o2;

  difference() {
    hull()
      union() {
        translate([ 0, 0, height ]) bal();
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) translate([ 0, r - rr, rr ]) bal();
        }
      }
    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}

//pyramidal(1.4 * inch, 2.8 * inch);

module conical(diameter, height, hratio1=0.25, hratio2=0.25) {

  r = diameter / 2;
  td1 = td + 3 * o2;
  r0 = td1 / 2 + 2 * o2;
  h1 = height * hratio1;
  h2 = height * hratio2;

  difference() {
    hull()
      union() {
        for(a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) translate([ r0, 0, rr ]) bal();
          rotate([ 0, 0, a ]) translate([ r, 0, h1 ]) bal();
          if (h2 != h1) rotate([ 0, 0, a ]) translate([ r, 0, h2 ]) bal();
        }
        translate([ 0, 0, height ]) bal();
      }
    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}

//conical(1.4 * inch, 3.5 * inch, 0.14, 0.42);
//conical(1.4 * inch, 3.5 * inch, 0.14, 0.14);

//trunk((-0.49 + 1) * inch);

module bush(height=0) {
  h = 5;
  bd = 3;
  br = bd / 2;
  module balcyl() {
    cylinder(r=br + 2 * o2, h=br * 2 + o2, center=true, $fn=36);
  }
  difference() {
    hull() {
      for (a = [ 0 : 15 : 180 ])
        rotate([ 0, 0, a ]) {
          translate([ inch / 2 - rr, 0, -h/2 + rr ]) bal();
          translate([ inch / 2 - rr, 0, h/2 - rr ]) bal();
        }
      translate([ inch / 2 - rr, -inch, -h/2 + rr ]) bal();
      translate([ inch / 2 - rr, -inch, h/2 - rr ]) bal();
      translate([ -inch / 2 + rr, -inch, -h/2 + rr ]) bal();
      translate([ -inch / 2 + rr, -inch, h/2 - rr ]) bal();
    }
    translate([ 0, -inch - height, 0 ])
      cube(size=[ inch + o2, 2 * inch + o2, 5 + o2 ], center=true);
    #translate([ 0, br + 5 * o2 - height, 0 ]) balcyl();

    if (height > 0) #translate([ 0, inch / 2 - bd, 0 ]) balcyl();
  }
}

//translate([ -2 * inch, 0, 0 ]) bush(0.9);
//translate([ -inch, 0, 0 ]) bush(1.1);
//bush();
//translate([ inch * 1.2, 0, 0 ]) bush(inch / 3);
//translate([ inch * 2.2, 0, 0 ]) bush(inch / 2);
translate([ inch * 2.2, 0, 0 ]) bush(inch / 1);

