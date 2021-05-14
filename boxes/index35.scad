
// index35.scad

// unit is mm

//lew = 0.2 * 2; // leeway
thi = 2.0; // thickness

hei = 76;
len = 128;
dep = 50;


difference() {

  cube(size=[ len + 2 * thi, dep + 2 * thi, hei + 1 * thi ], center=true);

  translate([ 0, 0, thi ]) cube(size=[ len, dep, hei + thi ], center=true);

  translate([ 0, -dep / 2 - thi / 2, hei / 1.9 ])
    rotate([ 90, 0, 0 ])
      cylinder(d=len / 1.9, h = thi * 2, center=true, $fn=12);
}

