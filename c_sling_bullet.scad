
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;

ab_2 = arrow_base / 2;
ab_7 = arrow_base / 7;
thickness12 = 1.2 * thickness;
diameter_2 = diameter / 2;
fs = 0.4 * arrow_base; // feather side
fs2 = 2 * fs;


module half_lens(diameter, shift) {
  difference() {
    circle(d=diameter, $fn=60);
    translate([ 0, -shift, 0 ]) square(diameter, center=true);
  }
}
module lens(diameter, factor) {
  union() {
    half_lens(diameter, factor * diameter);
    translate([ 0, diameter - 2 * factor * diameter, 0 ])
      rotate([ 0, 0, 180 ])
        half_lens(diameter, factor * diameter);
  }
}

//translate([ diameter, diameter, diameter ])
//  half_lens(diameter, 0.2 * diameter);
//translate([ diameter, diameter, 0 ])
//  lens(diameter, 0.2);


difference() {

  union() {

    cylinder(d=diameter, h=thickness, center=true);
  }

  union() {

    translate([ diameter / 9, diameter / 7, - 0.5 * thickness12 ])
      linear_extrude(thickness12)
        lens(diameter / 3, 0.2); // bullet
    translate([ -0.6 * diameter_2, -1.0 * diameter_2, -0.5 * thickness12 ])
      linear_extrude(thickness12)
        text("~", size=14); // sling
  }
}

