
//
// chexes.scad
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

//echo(inch, r, t);
//echo("bh", br + 2 * o2);
//echo("br + 2 * o2", 5 + 2 * o2);

module sphe() { sphere(r=rr, $fn=12); }

module balcyl() {

  hf = 2;
  h = br * hf + o2;

  dz = hf > 2 ? -3 * o2 : 0;

  translate([ 0, 0, dz ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module hex(center_ball) {

  difference() {

    //%translate([ 0, 0, h * -0.5 ])
    translate([ 0, 0, h * -0.5 ])
      hull()
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) {
            translate([ 0, t - rr, h - rr ]) sphe();
            translate([ 0, t - rr, rr ]) sphe();
          }
        }

    union() {

      if (center_ball) {
        balcyl();
      }

      for (a = [ 30 : 60 : 330 ]) {
        //echo(a);
        rotate([ 0, 0, a ]) translate([ 0, r - br - 4 * o2, 0 ]) balcyl();
      }
    }
  }
}


module charhex() {

  //a=0;x=-3;y=-7;z=1.9;c=true;symbol="\u2665",size=16;//heart
  //a=0;x=-7;y=-7;z=1.9;c=true;symbol="\u25BC";size=16;//headdowntriangle
  //a=0;x=-7;y=-7;z=1.9;c=true;symbol="\u2192";size=16;//arrowright
  //a=0;x=-7;y=-7;z=1.9;c=true;symbol="\u2660";size=16;//spade
  //a=0;x=-7;y=-7;z=1.9;c=true;symbol="\u2663";size=16;//club
  //a=0;x=-7;y=-7;z=1.9;c=true;symbol="\u2666";size=16;//diamond
  //a=0;x=-8.5;y=-9;z=-4;c=false;symbol="\u2191";size=24;//arrow
  a=0;x=-11.4;y=-6.0;z=-4;c=false;symbol="\u263c";size=18;//sun

  difference() {
    rotate([ 0, 0, a ]) hex(c);
    translate([ x, y, z ]) linear_extrude(7) text(symbol, size=size);
    translate([ 0, 0, 0 ]) cylinder(r=4.4, h=20, center=true, $fn=60); // for sun
  }
}
//charhex();


module lens() {
  module halflens() {
    difference() {
      circle(r=5.2, $fn=36);
      translate([ 6, 0, 0 ]) square(20, center=true);
    }
  }
  translate([ 4, 0, 0 ]) halflens();
  rotate([ 0, 0, 180 ]) translate([ 4, 0, 0 ]) halflens();
}

module lenspair() {
  union() {
    translate([ -1.4, 0, 0 ]) rotate([ 0, 0, 30 ]) linear_extrude(10) lens();
    translate([  1.4, 0, 0 ]) rotate([ 0, 0, -30 ]) linear_extrude(10) lens();
  }
}

module wheathex() {

  difference() {

    hex();

    translate([ 0, inch *  0.3, -5 ]) linear_extrude(10) lens();
    translate([ 0, inch *  0.1, -5 ]) lenspair();
    translate([ 0, inch * -0.1, -5 ]) lenspair();
    translate([ 0, inch * -0.3, -5 ]) lenspair();
  }
}
//wheathex();


module arrow() {
  diameter = 20;
  slit_width = 0.8;
  arrow_base = 7;
  ab_2 = arrow_base / 2;
  diameter_2 = diameter / 2;
  fs = 0.5 * arrow_base; // feather side
  fs2 = 2 * fs;
  h = 10;
  union() {

    translate([ 0, 0, 0 ])
      cube([ slit_width, 0.7 * diameter, h ], center=true);

    translate([ 0, diameter_2 - 1.2 * ab_2, -0.5 * h ])
      linear_extrude(h)
        polygon([
          [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);

    translate([ 0, -0.84 * diameter_2, -0.5 * h ])
      linear_extrude(h)
        polygon([ [ 0, fs ], [ 0, fs2 ], [ fs, fs ], [ fs, 0 ] ]);
    //translate([ 0, -0.5 * diameter_2, -0.5 * h ])
    //  linear_extrude(h)
    //    polygon([ [ 0, fs ], [ 0, fs2 ], [ fs, fs ], [ fs, 0 ] ]);

    translate([ 0, -0.84 * diameter_2, -0.5 * h ])
      linear_extrude(h)
        polygon([ [ 0, fs ], [ 0, fs2 ], [ -fs, fs ], [ -fs, 0 ] ]);
    //translate([ 0, -0.5 * diameter_2, -0.5 * h ])
    //  linear_extrude(h)
    //    polygon([ [ 0, fs ], [ 0, fs2 ], [ -fs, fs ], [ -fs, 0 ] ]);
  }
}
module pointerhex() {
  difference() {
    hex();
    rotate([ 0, 0, 30 ]) translate([ 0, -1, 0 ]) arrow();
  }
}
pointerhex();

