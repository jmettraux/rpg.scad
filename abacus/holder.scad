
//$fn=6;

// unit is mm

swi = 0.84; // slit width
sdp = 20; // slit depth

tsi = 30; // triangle side
twi = 14; // triangle width

ttd = 40; // tri to tri distance

module tri() {
  difference() {
    rotate([ 90, 45, 0 ])
      cube(size=[ tsi, tsi, twi ], center=true);
    translate([ 0, 0, -tsi ])
      cube(size=[ tsi * 2, tsi * 2, tsi * 2 ], center=true);
  }
}

difference() {

  union() {
    translate([ 0, -0.5 * ttd, 0 ])
      tri();
    translate([ 0, 0, tsi / 30 ])
      cube(size=[ tsi, ttd, tsi / 15 ], center=true);
    translate([ 0, 0.5 * ttd, 0 ])
      tri();
  }

  translate([ 0, 0, sdp / 2 + tsi / 15 ])
    cube(size=[ swi, ttd * 2, sdp ], center=true);
}

