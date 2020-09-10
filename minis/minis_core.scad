
//
// minis_core.scad
//

//$fn=12;

// unit is mm

base_diameter = 25;
base_thickness = 3;
base_arrow_base = 7;

//height = 33; // now set in the including file
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

// helpers

module segment(diameter, length, angle, d2=0) {

  d2 = d2 == 0 ? diameter : d2;

  rotate([ angle, 0, 0 ])
    hull() {
      translate([ 0, 0, 0 ]) sphere(d=diameter);
      translate([ 0, length, 0 ]) sphere(d=d2);
    }
}

  // segment balanced
  //
module segbal(diameter, length, d2=0, balratio=0.5, yangle=0, zangle=0) {

  ll = length * balratio;
  rl = length - ll;
  d2 = d2 == 0 ? diameter : d2;

  translate([ - length / 2 + ll, 0, 0 ])
    rotate([ 0, yangle, zangle ])
      hull() {
        translate([ -ll, 0, 0 ]) sphere(d=diameter);
        translate([ rl, 0, 0 ]) sphere(d=d2);
      }
}

module trapeze(
  bottom_d, bottom_l, top_d, top_l,
  h,
  bd2=0, td2=0,
  balratio=0.5, yangle=0, zangle=0
) {

  bd2 = bd2 == 0 ? bottom_d : bd2;
  td2 = td2 == 0 ? top_d : td2;

  hull() {
    translate([ 0, 0, 0 ])
      segbal(
        bottom_d, bottom_l, d2=bd2);
    translate([ 0, 0, h ])
      segbal(
        top_d, top_l, d2=td2, balratio=balratio, yangle=yangle, zangle=zangle);
  };
}

module pyramid(width1, height, w2=0, inverted=false) {

  w1 = width1 / 2;
  w2 = w2 == 0 ? w1 / 2 : w2 / 2;

  translate([ 0, 0, inverted ? height : 0 ])
    rotate([ inverted ? 180 : 0, 0, 0 ])
      linear_extrude(height, scale=0)
        polygon([ [ -w1, 0 ], [ 0, w2 ], [ w1, 0 ], [ 0, -w2 ] ]);
};

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

module leg_norman(leg_diameter, waist_diameter) {

  ld = leg_diameter;
  wd = waist_diameter;

  fh = head_height * 0.7;
  sh = leg_height - fh; // skirt height
  fl = head_height * 0.8; // foot length

  difference() {
    hull() {
      translate([ -ld / 3, 0, sh / 2 + fh ])
        cylinder(d1=ld, d2=wd, h=sh, center=true);
      translate([ ld / 3, 0, sh / 2 + fh ])
        cylinder(d1=ld, d2=wd, h=sh, center=true);
    };
    translate([ 0, 0, head_height * 0.7 ])
      rotate([ 0, 45, 0 ])
        cube([ head_height, base_diameter, head_height ], center=true);
  }

  translate([ fh * 1.1, -fh * 0.4, fh * 0.2 ])
    rotate([ 0, 0, 70 ])
      hull() {
        translate([ 0, 0, 0 ]) sphere(d=fh * 2);
        translate([ fl, 0, 0 ]) sphere(d=fh * 2);
      }
  translate([ -fh * 1.1, -fh * 0.4, fh * 0.2 ])
    rotate([ 0, 0, 30 - 270 ])
      hull() {
        translate([ 0, 0, 0 ]) sphere(d=fh * 2);
        translate([ fl, 0, 0 ]) sphere(d=fh * 2);
      }
}

module round_foot(length, height) {

  hull() {
    translate([ 0, 0, 0 ]) sphere(d=height * 2);
    translate([ length, 0, 0 ]) sphere(d=height * 2);
  }
};

module leg_norman_short(leg_diameter, waist_diameter) {

  ld = leg_diameter;
  wd = waist_diameter;

  fh = head_height * 0.62;
  sh = leg_height - fh - head_height; // skirt height
  fl = head_height * 0.8; // foot length

  difference() {
    hull() {
      translate([ -ld / 3, 0, leg_height - sh / 2 ])
        cylinder(d1=ld, d2=wd, h=sh, center=true);
      translate([ ld / 3, 0, leg_height - sh / 2 ])
        cylinder(d1=ld, d2=wd, h=sh, center=true);
    };
    translate([ 0, 0, head_height * 1.3 ])
      rotate([ 0, 45, 0 ])
        cube([ head_height, base_diameter, head_height ], center=true);
  }

  translate([ fh * 1.4, 0, fh ])
    cylinder(d1=fh, d2=fh * 1.6, h=10, center=true);
  translate([ - fh * 1.4, 0, fh ])
    cylinder(d1=fh, d2=fh * 1.6, h=10, center=true);

  translate([ fh * 1.4, -fh * 0.1, -fh * 0.1 ])
    rotate([ 0, 0, 70 ])
      round_foot(fl, fh);
  translate([ -fh * 1.4, -fh * 0.1, -fh * 0.1 ])
    rotate([ 0, 0, 30 - 270 ])
      round_foot(fl, fh);
}

module leg_norman_guard_short(leg_diameter, waist_diameter) {

  ld = leg_diameter;
  wd = waist_diameter;

  // TODO
}

module arm(diameter, angle) {

  hh = 0.8 * head_height;
  sd = diameter; // shoulder diameter
  wd = 0.8 * diameter; // wrist diameter
  al = 1.5 * hh; // arm length
  fal = 2 * hh; // forearm (and hand) length

  // arm
  segment(sd, al, 90);
  // forearm
  segment(sd, d2=wd, fal, 90 - angle);
}

module leg(
  ankle_angle, knee_angle,
  ankle_diameter, knee_diameter=0, buttock_diameter=0, foot_diameter=0,
  leg_angle=0
) {
  echo(knee_angle);

  aa = ankle_angle;
  ka = knee_angle;
  la = leg_angle;

  ad = ankle_diameter;
  kd = knee_diameter == 0 ? ad : knee_diameter;
  bd = buttock_diameter == 0 ? kd : buttock_diameter;
  fd = foot_diameter == 0 ? ad * 1.4 : foot_diameter;

  fl = head_height * 0.9; // foot length
  ll = head_height * 2; // leg length
  tl = head_height * 2; // thigh length

  rotate([ 0, la, 0 ]) union() {
    translate([ 0, -fl * 0.11, 0 ])
      hull() { // foot
        sphere(fd);
        translate([ 0, fl, 0 ]) sphere(fd);
      }
    hull() { // leg
      sphere(ad);
      translate([ 0, sin(aa) * ll, cos(aa) * ll ]) sphere(kd);
    }
    hull() { // thigh
      translate([ 0, sin(aa) * ll, cos(aa) * ll ])
        sphere(kd);
      translate([ 0, sin(aa) * ll - sin(ka) * tl, cos(aa) * ll + cos(ka) * tl ])
        sphere(bd);
    }
  }
}

// helmets

module big_helm(head_diameter) {

  h = neck_height + head_height;
  hd = head_diameter;

  difference() {
    union() {
      translate([ 0, 0, leg_height + torso_height + h / 2 ])
        cylinder(d1=hd, d2=hd * 1.1, h=h, center=true);
    }
    union() {
      translate([ 0, hd * 0.5, leg_height + torso_height + h * 0.6 ])
        cube([ 3.5, 1, 1 ], center=true);
      translate([ 0, hd * 0.5, leg_height + torso_height + h * 0.3 ])
        cube([ 1, 1, 3 ], center=true);
    }
  }
}

module hastings_helmet(head_diameter) {

  d = head_diameter;
  nh = neck_height * 1.8;

  difference() {
    union() {
      translate([ 0, 0, leg_height + torso_height + nh / 2 ])
        cylinder(d=d, h=nh, center=true);
      translate([ 0, 0, leg_height + torso_height + neck_height + head_height / 2 ])
        sphere(d=d);
    }
    union() {
      translate([ -1.25, d * 0.45, leg_height + torso_height + 3 / 2 ])
        cube([ 1.5, 1, 3 ], center=true);
      translate([ 1.25, d * 0.45, leg_height + torso_height + 3 / 2 ])
        cube([ 1.5, 1, 3 ], center=true);
      translate([ 0, d * 0.45, leg_height + torso_height + 1 / 2 ])
        cube([ 3, 1, 1 ], center=true);
    }
  }
}

