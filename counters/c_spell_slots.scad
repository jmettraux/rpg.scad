
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

levels = [
  [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" ],
  [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII" ],
  [ "I", "II", "III", "IV", "V", "VI",  ],
  [ "I", "II", "III"  ] ];

for (j = [ 0 : len(levels) - 1 ]) {
  level = levels[j];
  for (i = [ 0 : len(level) - 1 ]) {
    x = i * 1.05 * diameter;
    y = j * 1.05 * diameter;
    translate([ x, y, 0 ]) slot(level[i]);
  }
}

