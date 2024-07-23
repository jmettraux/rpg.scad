
//
// bush.scad

// unit is mm

inch = 25.4;
o2 = 0.2;
rr = inch / 20;


module bush(height=0) {
  h = 5;
  bd = 3;
  br = bd / 2;
  module bal() { sphere(r=rr, $fn=12); }
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

    if (height >= inch) {
      #translate([ 0, -inch / 2, 0 ]) balcyl();
      #translate([ inch / 2 - bd, -inch / 2, 0 ]) balcyl();
      #translate([ -inch / 2 + bd, -inch / 2, 0 ]) balcyl();
    }
  }
}

//translate([ -2 * inch, 0, 0 ]) bush(0.9);
//translate([ -inch, 0, 0 ]) bush(1.1);
bush();
//translate([ inch * 1.2, 0, 0 ]) bush(inch / 3);
//translate([ inch * 2.2, 0, 0 ]) bush(inch / 2);
//translate([ inch * 2.2, 0, 0 ]) bush(inch / 1); // door ;-)

