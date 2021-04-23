
//$fn=6;

// unit is mm

swi = 0.84; // slit width
swi2 = swi / 2;

tow = 20; // tooth width
tot = 14; // tooth thickness
toh = 28; // tooth height

bah = 5; // base height

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
      cylinder(d=tow * 2.5, h=bah, center=true, $fn=6);
}

holder();

