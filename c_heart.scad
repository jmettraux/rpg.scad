
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;

diameter_2 = diameter / 2;


difference() {

  union() {
    cylinder(d=diameter, h=thickness, center=true);
  }

  union() {

    #translate([ -0.65 * diameter_2, -0.65 * diameter_2, -thickness ])
      linear_extrude(2 * thickness)
      text("\u2665", size=14);
  }
}

