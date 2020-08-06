
$fn=18;

// unit is mm

diameter = 100;
height = 25;
border_height = 10;
border_width = 2;
r = diameter/2;


translate([ 0, 0, height / 2 ])
  cylinder(h=height, r1=r + border_width, r2=0, center=true);
translate([ 0, 0, border_height / 2 ])
  difference() {
    cylinder(h=border_height, r=r + border_width, center=true);
    cylinder(h=border_height + 1, r=r, center=true);
  }

