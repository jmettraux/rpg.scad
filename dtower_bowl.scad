
$fn=18;

// unit is mm

diameter = 100;
height = 28;
border_height = 14;
border_width = 2;
r = diameter/2;


translate([ 0, 0, 0 ])
  cylinder(h=border_width, r=r + border_width, center=true);

x = r / 10;

translate([ 0, -x * 2, ]) {
  hull() {
    translate([ 0, -x * 2, height / 2 ])
      cylinder(h=height, r1=r / 3, r2=0, center=true);
    translate([ -x * 6, x, height / 2 * 0.8 ])
      cylinder(h=height * 0.8, r1=r / 3, r2=0, center=true);
  }
  hull() {
    translate([ 0, -x * 2, height / 2 ])
      cylinder(h=height, r1=r / 3, r2=0, center=true);
    translate([ x * 6, x, height / 2 * 0.8 ])
      cylinder(h=height * 0.8, r1=r / 3, r2=0, center=true);
  }
}

translate([ 0, 0, border_height / 2 ])
  difference() {
    cylinder(h=border_height, r=r + border_width, center=true);
    cylinder(h=border_height + 1, r=r, center=true);
  }

