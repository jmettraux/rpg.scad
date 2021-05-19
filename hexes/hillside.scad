
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


module hex() {
  //module cub() { cube(size=[ br2, br + o2, br + o2 ], center=true); }
  module balcyl() {
    cylinder(r=br + 2 * o2, h=br + 2 * o2, center=true, $fn=36);
  }
  difference() {
    translate([ 0, 0, h * -0.5 ])
      //hull()
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) {
            //translate([ 0, t - rr, 0 ]) cylinder(r=rr, h=h, $fn=12);
            translate([ 0, t - rr, h - rr ]) sphere(r=rr, $fn=12);
            translate([ 0, t - rr, rr ]) sphere(r=rr, $fn=12);
          }
        }
    //#translate([ 0, br * 1.7, 0 ]) cub();
    //#translate([ 0, -br * 1.7, 0 ]) cub();
    #balcyl();
    for (a = [ 30 : 120 : 270 ]) {
      #rotate([ 0, 0, a ]) translate([ 0, r - br - 4 * o2, 0 ]) balcyl();
    }
  }
}
hex();
//cube(size=[ inch, rr, rr ], center=false);
//cube(size=[ inch, rr, rr ], center=true);
//translate([ inch, 0, 0, ]) hex();

