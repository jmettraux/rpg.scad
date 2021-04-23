
//$fn=6;

// unit is mm

swi = 0.84; // slit width
swi2 = swi / 2;

tow = 7; // tooth width
tot = 10; // tooth thickness
toh = 14; // tooth height

bah = 4; // base height
bad = tow * 5; // base diameter

module tooth() {
  translate([ 0, 0, toh / 2 ])
    cube(size=[ tow, tot, toh ], center=true);
  translate([ 0, 0, toh ])
    rotate([ 90, 0, 0 ]) cylinder(d=tow, h=tot, center=true);
}

module holder() {

  translate([ -tow / 2 - swi2, 0, 0 ]) tooth();
  translate([ tow / 2 + swi2, 0, 0 ]) tooth();

  translate([ 0, 0, bah / 2 ])
    rotate([ 0, 0, 0 ])
      cylinder(d=bad, h=bah, center=true, $fn=6);
}

holder();

