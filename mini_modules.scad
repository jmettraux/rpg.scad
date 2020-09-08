
$fn=12;

// unit is mm

base_diameter = 25;
base_thickness = 3;
base_arrow_base = 7;

//head_height = 7;
height = 33;
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

// tube

tube_diameter = 11;
tube_fn = 24;

module leg_tube() {

  translate([ 0, 0, leg_height / 2 ])
    cylinder(d=tube_diameter, h=leg_height, center=true, $fn=tube_fn);
}

module torso_tube() {

  translate([ 0, 0, leg_height + torso_height / 2 ])
    cylinder(d=tube_diameter, h=torso_height, center=true, $fn=tube_fn);
}

module neck_tube() {

  translate([ 0, 0, leg_height + torso_height + neck_height / 2 ])
    cylinder(d=tube_diameter, h=neck_height, center=true, $fn=tube_fn);
}

module head_tube() {

  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 2 ])
    cylinder(d=tube_diameter, h=head_height, center=true, $fn=tube_fn);
}

// robe

robe_leg_diameter = 10;
robe_waist_diameter = 7;
robe_torso_diameter = 10;
robe_neck_diameter = 5;
robe_fn = 24;
robe_head_diameter = head_height * 1.3;

module leg_robe() {

  rld = robe_leg_diameter;
  rwd = robe_waist_diameter;

  hull() {
    translate([ -rld / 3, 0, leg_height / 2 ])
      cylinder(d1=rld, d2=rwd, h=leg_height, center=true, $fn=robe_fn);
    translate([ rld / 3, 0, leg_height / 2 ])
      cylinder(d1=rld, d2=rwd, h=leg_height, center=true, $fn=robe_fn);
  };
}

module torso_robe() {

  rwd = robe_waist_diameter;
  rld = robe_leg_diameter;
  rtd = robe_torso_diameter;

  hull() {
    translate([ -rld / 3, 0, leg_height + torso_height / 2 ])
      cylinder(d1=rwd, d2=rtd, h=torso_height, center=true, $fn=robe_fn);
    translate([ rld / 3, 0, leg_height + torso_height / 2 ])
      cylinder(d1=rwd, d2=rtd, h=torso_height, center=true, $fn=robe_fn);
  }
}

module neck_robe() {

  rnd = robe_neck_diameter;

  translate([ 0, 0, leg_height + torso_height + neck_height / 2 ])
    cylinder(d1=rnd, d2=rnd, h=neck_height, center=true, $fn=robe_fn);
}

module head_robe() {

  hh = head_height;
  rhd = robe_head_diameter;

  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 4 ])
    cylinder(d1=rhd, d2=rhd, h=hh/2, center=true, $fn=robe_fn);
  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 2 ])
    sphere(d=robe_head_diameter);
}

// ...

base();
#leg_robe();
torso_robe();
#neck_robe();
head_robe();

