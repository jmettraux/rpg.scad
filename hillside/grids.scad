
//
// hillside.scad
//

// unit is mm

inch = 25.4;
h = 5; // height unit, 5mm
o2 = 0.2;
//br = 3 / 2; // ball radius
br = 1.7;

r = inch / 2;
t = r / cos(30);
rr = r / 10;
br2 = br * 2;

echo(inch, r, t);
//echo("bh", br + 2 * o2);
//echo("br + 2 * o2", 5 + 2 * o2);

module sphe() { sphere(r=rr, $fn=12); }

module balcyl(deeper=false) {

  hf =
    is_num(deeper) ? deeper :
    deeper == true ? 2.8 :
    2;
  h = br * hf + o2;

  dz = hf > 2 ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module hex(height=1) {

  hei = h * height;

  difference() {
    translate([ 0, 0, hei * -0.5 ])
      hull()
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) {
            //translate([ 0, t - rr, 0 ]) cylinder(r=rr, h=h, $fn=12);
            translate([ 0, t - rr, hei - rr ]) sphe();
            translate([ 0, t - rr, rr ]) sphe();
          }
        }

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    #translate([ 0, 0, h0 ]) balcyl(deeper = height > 1);
      // comment out for hexvar
    for (a = [ 30 : 60 : 330 ]) {
      #rotate([ 0, 0, a ])
        translate([ 0, r - br - 4 * o2, h0 ])
          balcyl(deeper = height > 1);
    }

    if (height > 1) {
      #translate([ 0, 0, h1 ]) balcyl(); // center ball
      for (a = [ 30 : 60 : 330 ]) {
        #rotate([ 0, 0, a ])
          translate([ 0, r - br - 4 * o2, h1 ])
            balcyl();
      }
    }

    if (height > 5) {
      h2 = (h0 + h1) / 2;
      //#translate([ 0, 0, h2 ]) balcyl(deeper=true); // center ball // no need
      for (a = [ 30 : 60 : 330 ]) {
        #rotate([ 0, 0, a ])
          translate([ 0, r - br - 4 * o2, h2 ])
            balcyl(deeper=true);
      }
    }
  }
}

//hex();
//translate([ inch * 1.1, 0, 0 ]) hex(3);
//translate([ inch * 2.2, 0, 0 ]) hex(5);

module square(height=1) {

  hei = h * height;
  rm = r - rr;

  difference() {
    translate([ 0, 0, hei * -0.5 ])
      hull()
        for (hh = [ hei - rr, rr ]) {
          translate([  rm,  rm, hh ]) sphe();
          translate([ -rm,  rm, hh ]) sphe();
          translate([ -rm, -rm, hh ]) sphe();
          translate([  rm, -rm, hh ]) sphe();
        }

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    dpr = height > 1;

    #translate([ 0, 0, h0 - 1.8 ]) balcyl(deeper=4.9);
    for (a = [ 0 : 90 : 270 ]) {
      #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h0 ])
        balcyl(deeper=dpr);
    }

    if (hei >= inch) {

      dd = inch / 2 - br - 5 * o2;
      #translate([ -dd,  dd, 0 ]) balcyl(deeper=dpr);
      #translate([  dd, -dd, 0 ]) balcyl(deeper=dpr);
      #translate([ -dd, -dd, 0 ]) balcyl(deeper=dpr);
      #translate([  dd,  dd, 0 ]) balcyl(deeper=dpr);

      for (a = [ 0 : 90 : 270 ]) {
        #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, 0 ])
          balcyl(deeper=dpr);
      }
    }

    if (dpr) {
      #translate([ 0, 0, h1 ]) balcyl(); // center ball
      for (a = [ 0 : 90 : 270 ]) {
        #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h1 ])
          balcyl();
      }
    }
  }
}

//square(inch / h); // hillside_cube.stl

//difference() { // hillside_angle.stl
//  square(inch / h);
//  d = h + 0.3;
//  translate([ d, d, 0 ]) cube(size=[ inch, inch, inch * 2 ], center=true);
//}

module sqgroup(x, y, height=1, fillers=false) {
  d = inch - 0.1;
  module filler(height) {
    s = 5 * (br + 2 * o2);
    h = br * 2 + o2 + 0.1;
    #cube(size=[ s, s, h ], center=true);
  }
  for (xx = [ 0 : x - 1 ])
    for (yy = [ 0 : y - 1 ])
      translate([ xx * d, yy * d, 0 ]) square(height);
  // TODO lo and hi fillers
  if (fillers) {
    for (xx = [ 0 : x - 2 ])
      for (yy = [ 0 : y - 1 ])
        translate([ d / 2 + xx * d, yy * d, 0 ]) filler(height);
    for (xx = [ 0 : x - 1 ])
      for (yy = [ 0 : y - 2 ])
        translate([ xx * d, d / 2 + yy * d, 0 ]) filler(height);
  }
}

//sqgroup(2, 2, height=1, fillers=false);
//sqgroup(3, 4, height=1, fillers=false);
//sqgroup(1, 4, height=1, fillers=false);
//sqgroup(1, 2, height=1, fillers=false);
//square(1);

module squareonetwo() {
  sqgroup(1, 2, height=1, fillers=false);
  translate([ inch - 0.1, 0, 0 ]) square(height=1);
}

//squareonetwo();

module halfsquare(height=1) {

  hei = h * height;
  rm = r - rr;
  d = 1.4 * rr;
//echo("o2", o2, "rr", rr, "d", d);

  difference() {
    translate([ 0, 0, hei * -0.5 ])
      hull()
        for (hh = [ hei - rr, rr ]) {
          translate([ rm, rm, hh ]) sphe();
          translate([ -rm + d, rm, hh ]) sphe();
          //translate([ -rm, -rm, hh ]) sphe();
          translate([ rm, -rm + d, hh ]) sphe();
        }

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    d2 = d + 2 * o2;

    #translate([ d2, d2, h0 ]) balcyl(); // center ball
    for (a = [ 0, 270 ]) {
      #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h0 ]) balcyl();
    }

    //if (height > 1) {
    //  #translate([ 0, 0, h1 ]) balcyl(); // center ball
    //  for (a = [ 0 : 90 : 270 ]) {
    //    #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h1 ]) balcyl();
    //  }
    //}
  }
}

//halfsquare();

union() {
  halfsquare();
  translate([ inch, 0, 0 ]) square();
}
  //rotate([ 0, 0, 180 ]) halfsquare();
  //translate([ inch, inch + o2, 0 ]) square();
  //translate([ 0, inch + o2, 0 ]) square();

module halfsquare2(height=1) {

  b = sqrt(pow(inch, 2) / 2) / 2;

  hei = h * height;
  rm = r - rr;
  rm2 = b - rr;

  translate([ rm - rm2, rm - rm2, 0 ]) difference() {

    translate([ 0, 0, hei * -0.5 ])
      hull()
        for (hh = [ hei - rr, rr ]) {
          translate([ rm2, rm2, hh ]) sphe();
          translate([ -rm2, rm2, hh ]) sphe();
          //translate([ -rm2, -rm2, hh ]) sphe();
          translate([ rm2, -rm2, hh ]) sphe();
        }

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    #translate([ rr, rr, h0 ]) balcyl(); // center ball
    //for (a = [ 0, 270 ]) {
    //  #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h0 ]) balcyl();
    //}

    //rm3 = rm2 - 5 * o2;

    translate([ rm2 - rr - o2, rm2 - rr - o2, h0 ]) {
      #translate([ -rm + rr, 0, 0 ]) balcyl();
      #translate([ 0, -rm + rr, 0 ]) balcyl();
    }
  }
}

//halfsquare2();

module hsq2_shoulder() {
  halfsquare2();
  translate([ inch - o2, 0, 0 ]) square();
}

module hsq2_hat() {
  halfsquare2();
  f = 0.235;
  translate([ - inch * f, - inch * f, 0 ]) rotate([ 0, 0, 45 ]) square();
}

//hsq2_hat();
//translate([ inch, 0, 0 ]) hsq2_shoulder();


module hgroup(x, y, height=1, sx=0, sy=0) {

  dx = inch + 1 * o2;
  dy = 1.5 * t + 1 * o2;

  for (xx = [ sx : x - 1 ]) {
    for (yy = [ sy : y - 1 ]) {
      if (yy % 2 == 0) translate([ xx * dx, yy * dy, 0 ]) hex(height);
      else translate([ r + xx * dx, yy * dy, 0 ]) hex(height);
    }
  }
}

  // TODO replace with hgroup combos
  //
//module hflower(height=1) {
//  r2 = r / 2;
//  translate([ -r, 1.5 * t, 0 ]) hgroup(2, 1, height);
//  translate([ -2 * r, 0, 0 ]) hgroup(3, 1, height);
//  translate([ -r, -1.5 * t, 0 ]) hgroup(2, 1, height);
//}

module tri(height=1) {

  hei = h * height;

  translate([ 0, -t / 2, hei * -0.5 ])
    hull()
      for (a = [ -60, 0, 60 ]) {
        rotate([ 0, 0, a ]) {
          translate([ 0, t - rr, hei - rr ]) sphe();
          translate([ 0, t - rr, rr ]) sphe();
        }
      }
}

////th = 1 + 15 + 1; // 105 hexes (15 x 7)
//th = 1 + 3;
//hflower();
////for (a = [ 0 : 60 : 300 ])
//for (a = [ 0 : 120 : 300 ]) // 3 prongs FTW
//  rotate([ 0, 0, a ])
//    translate([ 0, -tr2 - t - 2 * o2, ((th - 1) * h) / 2 ])
//      tri(th);

//square();
//translate([ inch, 0, 0 ]) square(3);


module hexvar(height) {
  hei = (height - 1) * h;
  r2 = r / 2;
  r4 = r / 4;
  module tooth(thinner=false) {
    //t = thinner ? 0 : o2;
    t = 0;
    translate([ 0, 0, h / 2 ])
      cube(size=[ r2 - t, r2 - t, hei ], center=true);
  }
  difference() {
    union() {
      hex(height);
    }
    translate([ inch / 2, 0, h / 2 ])
      cube(size=[ inch, inch * 2, hei ], center=true);
    translate([ -r4, r4, 0 ]) tooth(false);
  }
  translate([ r4, -r4, 0 ]) tooth(false);
}

//hexvar(5); // <-- mirror it ;-)
//hexvar(10);


//module hexbox() {
//
//  translate([ 0, 0, h / 2 ]) hgroup(8, 8, sx=1, sy=1);
//    //
//  translate([ 0, 0, 9 * h / 2 ]) hgroup(9, 1, 9);
//  translate([ 0, 8 * (1.5 * t), 9 * h / 2 ]) hgroup(9, 1, 9);
//    //
//  translate([ 0, 0, 9 * h / 2 ]) hgroup(1, 8, 9);
//  translate([ 8 * inch, 0, 9 * h / 2 ]) hgroup(1, 8, 9);
//}
//hexbox();

//hgroup(8, 5); // <-- ita :-)
//hgroup(4, 5); // <-- ita half :-)
//hgroup(2, 2); // <-- "unit"
//hgroup(2, 3); // <-- "arrow"

//hgroup(1, 1);
//hgroup(1, 2);

module hexcircumflex() {
  hgroup(1, 2);
  translate([ - inch, 0, 0 ]) hgroup(1, 1);
}
//hexcircumflex();

//union() { // <-- "small flower"
//  translate([ - inch - o2, 0, 0 ]) hgroup(1, 2);
//  hgroup(1, 1);
//}

//hex(3);


module column(height=1, diameter=inch, o2f=6, angles=[ 0 : 90 : 270 ]) {

  hei = h * height;
  balrad = diameter / 2 - br - o2f * o2;

  difference() {

    translate([ 0, 0, hei * -0.5 ])
      cylinder(hei, d=diameter, true, $fn=18);

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    dpr = height > 1;

    if (diameter > inch / 2)
      #translate([ 0, 0, h0 - 1.8 ]) balcyl(deeper=4.9); // center ball
    for (a = angles) {
      #rotate([ 0, 0, a ]) translate([ 0, balrad, h0 ])
        balcyl(deeper=dpr);
    }

    if (hei >= inch) {

      for (a = angles) {
        #rotate([ 0, 0, a ]) translate([ 0, balrad, 0 ])
          balcyl(deeper=dpr);
      }
    }

    if (dpr) {
      if (diameter > inch / 2)
        #translate([ 0, 0, h1 ]) balcyl(); // center ball
      for (a = angles) {
        #rotate([ 0, 0, a ]) translate([ 0, balrad, h1 ])
          balcyl();
      }
    }
  }
}

//column(height=inch/h);
//column(height=inch/h, diameter=inch * 0.7, o2f=5.1); // halfcolumn 1.0 :-|
//column(height=inch/h, diameter=inch * 0.5, o2f=4.9, angles=[0,180]);

