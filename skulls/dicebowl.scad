
// dicebowl.scad

// unit is mm

lew = 0.2 * 2; // leeway
dia = 100; // hex diameter
thi = 2; // thickness
//hei = 14 + 7 / 2; // dice height
hei = 14;

bigr = (dia + thi) / 2;
smar = bigr * cos(30);


module hex(hole=false) {

  difference() {

    cylinder(d=dia + lew + thi, h=hei, $fn=6);

    //cylinder(d1=140, d2=154, h=hei, $fn=6);
    translate([ 0, 0, thi ])
      cylinder(d=dia + lew, h=hei, $fn=6);

    if (hole)
      translate([ 0, 0, -0.5 ])
        cylinder(d=20, h=3, $fn=6);
  }
}

// four hexes
//translate([ 0, 0, 0 ]) hex(true);
//translate([ 0, -smar * 2, 0 ]) hex();
//translate([ smar * 1.72,  -smar, 0 ]) hex();
//translate([ smar * -1.72,  -smar, 0 ]) hex();

// two hexes and a slope
//translate([ -1 * dia, 0, 0 ]) union() {
  translate([ 0, 0, 0 ]) hex(true);
  translate([ 0, -smar * 2, 0 ]) hex();
//}

translate([ 0, -smar, 0 ]) intersection() {

  //h = hei * 2.8;
  h = 42;
  ht = 35 - 2.8;
  dt = 30 - 2.8;

  union() {

    cylinder(d1=dia * 1.1, d2=0, h=h, $fn=12);

    translate([ smar * 0.5, 0, 0 ])
      rotate([ 0, 0, 95 + 5 ])
        cylinder(d1=dia * 1.0, d2=0, h=h * 0.84, $fn=7);
    translate([ -smar * 0.5, 0, 0 ])
      rotate([ 0, 0, 180 ])
        cylinder(d1=dia * 1.0, d2=0, h=h * 0.84, $fn=7);

    translate([ dia / 2.1, -dia / 3.5, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.84, $fn=8);
    translate([ -dia / 2.1, -dia / 3.5, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.84, $fn=8);

    translate([ dia / 2, -dia / 2, 0 ])
      cylinder(d1=dt, d2=10, h=ht, $fn=8);
    translate([ -dia / 2, -dia / 2, 0 ])
      cylinder(d1=dt, d2=10, h=ht, $fn=8);

    translate([ bigr / 2, -dia + dt / 2, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.77, $fn=8);
    translate([ -bigr / 2, -dia + dt / 2, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.77, $fn=8);

    translate([ bigr / 2 + dt / 2, -dia + dt / 1, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.77, $fn=8);
    translate([ -bigr / 2 - dt / 2, -dia + dt / 1, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.77, $fn=8);

    translate([ 0, -dia + dt / 3, 0 ])
      cylinder(d1=dt, d2=10, h=ht * 0.77, $fn=8);
  }

  translate([ 0, -smar, 0 ]) cylinder(d=dia + lew + thi, h=h, $fn=6);
}

