
$fn=36;

// unit is mm

swi = 0.84; // slit width
swi2 = swi / 2;

tow = 5; // tooth width
tot = 11; // tooth thickness
toh = 21; // tooth height

//tec = 23; // teeth count
tec = 13; // teeth count

bah = 4; // base height


module tooth() {
  translate([ 0, 0, toh / 2 ])
    cube(size=[ tow, tot, toh ], center=true);
  translate([ 0, 0, toh ])
    rotate([ 90, 0, 0 ]) cylinder(d=tow, h=tot, center=true);
}

for (i = [0:tec]) {
  translate([ i * (tow + swi), 0, 0 ]) tooth();
}

l = tow + tec * (tow + swi);
echo(l);

translate([ l / 2 - tow / 2, 0, 0 ])
  cube(size=[ l, tot, bah ], center=true);

