
//
// hillside.scad
//

// unit is mm

inch = 25.4;
h = 5; // height unit, 5mm
o2 = 0.2;
br = 3; // ball radius

r = inch / 2;
t = r / cos(30);
rr = r / 10;
br2 = br * 2;

//echo("bh", br + 2 * o2);


module hex(height=1) {

  bh = br + 2 * o2;

  module balcyl() { cylinder(r=br + 2 * o2, h=bh, center=true, $fn=36); }

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

    #translate([ 0, 0, h0 ]) balcyl(); // center ball
    for (a = [ 30 : 60 : 330 ]) {
      #rotate([ 0, 0, a ]) translate([ 0, r - br - 4 * o2, h0 ]) balcyl();
    }
    if (height > 1) {
      #translate([ 0, 0, h1 ]) balcyl(); // center ball
      for (a = [ 30 : 60 : 330 ]) {
        #rotate([ 0, 0, a ]) translate([ 0, r - br - 4 * o2, h1 ]) balcyl();
      }
    }
  }
}

hex();
translate([ inch * 1.1, 0, 0 ]) hex(3);
translate([ inch * 2.2, 0, 0 ]) hex(5);

