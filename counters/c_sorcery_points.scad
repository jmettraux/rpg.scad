
$fn=12;

// unit is mm

diameter = 25;
thickness = 3;
slit_width = 0.8;
arrow_base = 7;

diameter_2 = diameter / 2;


module slot(level) {

  difference() {

    union() {
      cylinder(d=diameter, h=thickness, center=true);
    }

    union() {

      //#translate([ -0.3 * diameter_2, -0.3 * diameter_2, -thickness ])
      //  linear_extrude(2 * thickness)
      //  text("\u26E4", size=10);
      translate([ -0.75 * diameter_2, -0.5 * diameter_2, -thickness ])
        linear_extrude(2 * thickness)
        text(level, size=9);
    }
  }
}

slot("S");

