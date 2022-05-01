
// decagon.scad

inch = 25.4;
h = 5; // height unit, 5mm
o2 = 0.2;
br = 1.7; // ball radius

r = inch * 0.7; // radius
echo("radius:", r);
echo("diameter:", 2 * r);
echo("side:", 2 * r * sin(360 / 10 / 2));

module balcyl(deeper=false) {

  hf = 2;
  h = br * hf + o2;

  cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

difference() {
  //%cylinder(h=h, r=r, center=true, $fn=10);
  cylinder(h=h, r=r, center=true, $fn=10);
  union() {
    balcyl();
    for(a = [ 360/20 : 360/10 : 360 ]) {
      //echo(a);
      rotate([ 0, 0, a ]) translate([ r - br * 2 - 0 * o2, 0, 0 ]) balcyl();
    }
  }
}

