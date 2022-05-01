
// pentagon.scad

inch = 25.4;
h = 5; // height unit, 5mm
o2 = 0.2;
br = 1.7; // ball radius
n = 5; // 5 sides

r = 0.5 * inch; // radius
ro = r * cos(180 / n); // shortest distance from center to side
echo("radius:", r);
echo("diameter:", 2 * r);
echo("side:", 2 * r * sin(360 / (n * 2)));
echo("ro:", ro);

module balcyl(deeper=false) {

  hf = 2;
  h = br * hf + o2;

  cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

difference() {
  //%cylinder(h=h, r=r, center=true, $fn=n);
  cylinder(h=h, r=r, center=true, $fn=n);
  union() {
    balcyl();
    for(a = [ 360 / (n * 2) : 360 / n : 360 ]) {
      //echo(a);
      rotate([ 0, 0, a ]) translate([ ro - br - 2 * o2, 0, 0 ]) balcyl();
    }
  }
}

