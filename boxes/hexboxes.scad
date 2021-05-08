
// hexboxes.scad

// unit is mm

lew = 0.2 * 2; // leeway
dia = 100; // hex diameter
thi = 1.8; // thickness

hei = 56; // heights, for minis
lih = 12; //

//hei = 28; // heights, for dice
//lih = 12; //

bigr = (dia + thi) / 2;
smar = bigr * cos(30);

//label = "fortis fortuna adiuvat";
//font = "Fira Mono";
//font_size = 6.3;
//font_spacing = 0.8;
//label_dx = 45.7;
//label_dy = 2.1;


module hex(height, diameter, hole=false) {

  difference() {

    //cylinder(d=dia + lew + thi, h=height, $fn=6);
    cylinder(d=diameter, h=height, $fn=6);

    translate([ 0, 0, thi ])
      cylinder(d=diameter - thi, h=height, $fn=6);

    if (hole)
      translate([ 0, 0, -0.5 ])
        cylinder(d=2, h=3, $fn=6);
  }
}

// box

translate([ 0, 0, 0 ]) hex(hei, dia);

// lid

difference() {

  translate([ 0, dia * 0.93, 0 ]) hex(lih, dia + thi + lew, hole=true);

  //#translate([ label_dx, (dia * 0.93) + label_dy, - thi / 2 ])
  //  linear_extrude(thi / 2)
  //    mirror([ 1, 0, 0 ])
  //      text(label, size=font_size, font=font, spacing=font_spacing);
}

