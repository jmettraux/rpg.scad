
// hundred.scad

inch = 25.4;
h = 5; // height unit, 5mm
o2 = 0.2;
br = 1.7; // ball radius

module balcyl(deeper=false) {

  hf = 2;
  h = br * hf + o2;

  cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

difference() {
  cylinder(h=h, d=2 * inch, center=true, $fn=10);
  union() {
    balcyl();
    for(a = [ 360/20 : 360/10 : 360 ]) {
      echo(a);
      rotate([ 0, 0, a ]) translate([ inch - br * 2 - 2 * o2, 0, 0 ]) balcyl();
    }
  }
}

