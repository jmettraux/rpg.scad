
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
  rotate([ angle, 0, 0 ])
    hull() {
      translate([ 0, 0, 0 ])
        sphere(d=diameter);
      translate([ 0, length, 0 ])
        if (d2 == 0) sphere(d=diameter);
        else sphere(d=d2);
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

  //module segment(diameter, length, angle) {
  // arm
  segment(sd, al, 90);
  // forearm
  segment(sd, d2=wd, fal, 90 - angle);
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

// shields

module tear_shield(height, width) {

  d = 1; // depth

  rotate([ 270, 0, 0 ])
    hull() {
      translate([ 0, 0, 0 ])
        cylinder(d=width, h=d, center=true);
      translate([ 0, height, 0 ])
        cylinder(d=d, h=d, center=true);
    }
};

module round_shield(diameter) {

  dm = diameter;
  dp = 1; // depth

  rotate([ 270, 0, 0 ])
    union() {
      cylinder(d=dm, h=dp, center=true);
      translate([ 0, 0, -0.5 ])
      difference() {
        sphere(dm / 10);
        translate([ 0, 0, -dm / 8 ]) cube(dm / 3, center=true);
      }
    }
};

// swords

module long_sword(length) {

  l = length;
  hl = head_height / 1.1; // handle length
  hd = hl / 2; // handle diameter
  gh = hl / 4; // guard height
  tl = length / 10; // tip length
  bl = l - tl - hl - gh; // blade length
  bw = hl * 0.7; // blade width
  bd = hd * 0.7; // blade depth, well

  union() {
    // handle
    translate([ 0, 0, -hl / 2 - gh / 2 ])
      cylinder(d1=hd, d2=hd, h=hl, center=true);
    // guard
    translate([ 0, 0, 0 ])
      cube([ hl, hd, gh ], center=true);
    // blade
    translate([ 0, 0, gh / 2 + bl / 2 ])
      linear_extrude(bl, center=true)
        polygon(
          [ [ -bw / 2, 0 ], [ 0, bd / 2 ], [ bw / 2, 0 ], [ 0, -bd / 2 ] ]);
    // tip
    translate([ 0, 0, gh / 2 + bl + tl / 2 ])
      linear_extrude(tl, scale=0, center=true)
        polygon(
          [ [ -bw / 2, 0 ], [ 0, bd / 2 ], [ bw / 2, 0 ], [ 0, -bd / 2 ] ]);
  }
};

// axes

module housekarl_axe(length) {

  l = length;
  d = head_height / 2.5;
  bd = l / 4; // blade diameter
  dp = 1;

  cylinder(d=d, h=l);

  translate([ -bd / 2, 0, l * 0.96 ])
    rotate([ 90, 0, 0 ])
      difference() {
        cylinder(d=bd, h=dp, center=true);
        union() {
          translate([ bd / 2.7,   bd / 1.9, dp * 0.05 ])
            cylinder(d=bd / 1.1, h=dp * 1.2, center=true);
          translate([ bd / 2.7, - bd / 1.9, dp * 0.05 ])
            cylinder(d=bd / 1.1, h=dp * 1.2, center=true);
        }
      }
};

// spears

module spear(length) {

  l = length;
  hl = l * 0.1;
  rl = l - hl;
  d = head_height / 2.6;

  cylinder(d=d, h=l);
}

// ...

