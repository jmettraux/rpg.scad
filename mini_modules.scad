
$fn=12;

// unit is mm

base_diameter = 25;
base_thickness = 3;
base_arrow_base = 7;

//head_height = 7;
height = 35;
head_height = height / 8;
neck_height = head_height / 2;
torso_height = head_height * 2;
leg_height = height - (head_height + neck_height + torso_height);


module base() {

  d_2 = base_diameter / 2;
  ab_2 = base_arrow_base / 2;
  t12 = 1.2 * base_thickness;

  translate([ 0, 0, - base_thickness / 2 ])
    difference() {

      // base
      cylinder(d=base_diameter, h=base_thickness, center=true);

      // arrow
      translate([ 0, d_2 - 1.2 * ab_2, -0.5 * t12 ])
        linear_extrude(t12)
          polygon([
            [ -ab_2, 0 ], [ 0, ab_2 ], [ ab_2, 0 ] ]);
    }
}

// robe

robe_diameter = 11;
robe_fn = 24;

module leg_robe() {

  translate([ 0, 0, leg_height / 2 ])
    cylinder(d=robe_diameter, h=leg_height, center=true, $fn=robe_fn);
}

module torso_robe() {

  translate([ 0, 0, leg_height + torso_height / 2 ])
    cylinder(d=robe_diameter, h=torso_height, center=true, $fn=robe_fn);
}

module neck_robe() {

  translate([ 0, 0, leg_height + torso_height + neck_height / 2 ])
    cylinder(d=robe_diameter, h=neck_height, center=true, $fn=robe_fn);
}

module head_robe() {

  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 2 ])
    cylinder(d=robe_diameter, h=head_height, center=true, $fn=robe_fn);
}

// ...

base();
#leg_robe();
torso_robe();
#neck_robe();
head_robe();

