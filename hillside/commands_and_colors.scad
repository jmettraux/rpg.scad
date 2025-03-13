
//
// commands_and_colors.scad
//

// a simple hex, with magnet ball cylinders...


//      |---|  32.33mm
//      _____
//     /     \    }       }
//    /       \   } 28mm  }
//    \       /           }
//     \     /            } 56mm
//      -----
//    |-------| 64.66mm


// unit is mm

inch = 25.4;
o2 = 0.2;
br = 1.7; // ball diameter

hr = 32.33;
hr1 = 28;
//hh = br * 2 + o2 + 3 * o2;
hh = 5;
//echo("hh", hh);


module hex() {

  module balcyl() {
    cylinder(r=br + 2 * o2, h=hh - 4 * o2, center=true, $fn=36);
  }

  difference() {
    cylinder(r=hr, h=hh, center=true, $fn=6);
    union() {
      balcyl();
      for (a = [ 30 : 60 : 330 ]) {
        rotate([ 0, 0, a ])
          translate([ hr1 - br - 4 * o2, 0, 0 ])
            balcyl();
      }
    }
  }
}

hex();

