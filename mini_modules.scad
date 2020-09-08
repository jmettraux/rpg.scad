
//$fn=12;

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
      cylinder(d=base_diameter, h=base_thickness, center=true, $fn=12);

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

module leg_tube(diameter) {

  translate([ 0, 0, leg_height / 2 ])
    cylinder(d=diameter, h=leg_height, center=true);
}

module torso_tube(diameter) {

  translate([ 0, 0, leg_height + torso_height / 2 ])
    cylinder(d=diameter, h=torso_height, center=true);
}

module neck_tube(diameter) {

  translate([ 0, 0, leg_height + torso_height + neck_height / 2 ])
    cylinder(d=diameter, h=neck_height, center=true);
}

module head_tube(diameter) {

  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 2 ])
    cylinder(d=diameter, h=head_height, center=true);
}

// robe

module leg_robe(leg_diameter, waist_diameter) {

  ld = leg_diameter;
  wd = waist_diameter;
  lh = leg_height;

  hull() {
    translate([ -ld / 3, 0, lh / 2 ])
      cylinder(d1=ld, d2=wd, h=lh, center=true);
    translate([ ld / 3, 0, lh / 2 ])
      cylinder(d1=ld, d2=wd, h=lh, center=true);
  };
}

module torso_robe(leg_diameter, waist_diameter, torso_diameter) {

  wd = waist_diameter;
  td = torso_diameter;
  ld = leg_diameter;

  hull() {
    translate([ -ld / 3, 0, leg_height + torso_height / 2 ])
      cylinder(d1=wd, d2=td, h=torso_height, center=true);
    translate([ ld / 3, 0, leg_height + torso_height / 2 ])
      cylinder(d1=wd, d2=td, h=torso_height, center=true);
  }
}

module neck_robe(neck_diameter, head_diameter) {

  nd = neck_diameter;
  hd = head_diameter;

  translate([ 0, 0, leg_height + torso_height + neck_height / 2 ])
    cylinder(d1=nd, d2=hd, h=neck_height, center=true);
}

module head_robe(head_diameter) {

  hh = head_height;
  hd = head_diameter;

  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 4 ])
    cylinder(d1=hd, d2=hd, h=hh/2, center=true);
  translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 2 ])
    sphere(d=hd);
}

// helms

module big_helm(head_diameter) {

  h = neck_height + head_height;
  hd = head_diameter;

  difference() {
    translate([ 0, 0, leg_height + torso_height + h / 2 ])
      cylinder(d1=hd, d2=hd * 1.1, h=h, center=true);
  }
}

// shields

// swords

// spears

// ...

$fn = 24;

base();
#leg_robe(10, 7);
torso_robe(10, 7, 9);
//#neck_robe(5, 5);
//head_robe(head_height * 1.3);
big_helm(6);

