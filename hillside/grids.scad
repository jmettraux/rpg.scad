
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
tr2 = t + r / 2;

//echo("bh", br + 2 * o2);
//echo("br + 2 * o2", 5 + 2 * o2);

module balcyl(deeper=false) {

  h = deeper ? br * 2.8 + o2 : br * 2 + o2;
  dz = deeper ? -3 * o2 : 0;

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
            translate([ 0, t - rr, hei - rr ]) sphere(r=rr, $fn=12);
            translate([ 0, t - rr, rr ]) sphere(r=rr, $fn=12);
          }
        }

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    #translate([ 0, 0, h0 ]) balcyl(deeper = height > 1);
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
          translate([ rm, rm, hh ]) sphere(r=rr, $fn=12);
          translate([ -rm, rm, hh ]) sphere(r=rr, $fn=12);
          translate([ -rm, -rm, hh ]) sphere(r=rr, $fn=12);
          translate([ rm, -rm, hh ]) sphere(r=rr, $fn=12);
        }

    h0 = hei / 2 - h / 2;
    h1 = -hei / 2 + h / 2;

    #translate([ 0, 0, h0 ]) balcyl();
    for (a = [ 0 : 90 : 270 ]) {
      #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h0 ]) balcyl();
    }

    if (height > 1) {
      #translate([ 0, 0, h1 ]) balcyl(); // center ball
      for (a = [ 0 : 90 : 270 ]) {
        #rotate([ 0, 0, a ]) translate([ 0, r - br - 5 * o2, h1 ]) balcyl();
      }
    }
  }
}

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

//sqgroup(3, 4, height=1, fillers=false);

module hgroup(x, y, height=1, sx=0, sy=0) {

  for (xx = [ sx : x - 1 ]) {
    for (yy = [ sy : y - 1 ]) {
      if (yy % 2 == 0) translate([ xx * inch, yy * tr2, 0 ]) hex(height);
      else translate([ r + xx * inch, yy * tr2, 0 ]) hex(height);
    }
  }
}

module hflower(height=1) {

  r2 = r / 2;

  translate([ -r, tr2, 0 ]) hgroup(2, 1, height);
  translate([ -2 * r, 0, 0 ]) hgroup(3, 1, height);
  translate([ -r, -tr2, 0 ]) hgroup(2, 1, height);
}

module tri(height=1) {

  hei = h * height;

  translate([ 0, -t / 2, hei * -0.5 ])
    hull()
      for (a = [ -60, 0, 60 ]) {
        rotate([ 0, 0, a ]) {
          translate([ 0, t - rr, hei - rr ]) sphere(r=rr, $fn=12);
          translate([ 0, t - rr, rr ]) sphere(r=rr, $fn=12);
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

//hexvar(5);


module hexbox() {

  translate([ 0, 0, h / 2 ]) hgroup(8, 8, sx=1, sy=1);
    //
  translate([ 0, 0, 9 * h / 2 ]) hgroup(9, 1, 9);
  translate([ 0, 8 * tr2, 9 * h / 2 ]) hgroup(9, 1, 9);
    //
  translate([ 0, 0, 9 * h / 2 ]) hgroup(1, 8, 9);
  translate([ 8 * inch, 0, 9 * h / 2 ]) hgroup(1, 8, 9);
}
//hexbox();

hgroup(8, 5);

