
//
// coverage.scad
//

use <cadence.scad>;

// unit is mm

inch = 25.4;
o2 = 0.2;
//bd = 5; // ball diameter (ball magnet)
bd = 7; // ball diameter (Daiso 5mm pill magnet)

br = bd / 2;
//td = 2 * bd; // trunk diameter
td = 10; // trunk diameter
in2 = inch / 2;
k0 = bd + 2 * o2;
k1 = bd + td / 2 + 2 * o2;

rr = inch / 20;

//
// tree trunk

module bal() { sphere(r=rr, $fn=12); }
//module notch() { paslice(k1, k0, slice=60); }

module balcyl(deeper=false) {

  h = deeper ? br * 2.8 + o2 : br * 2 + o2;
  dz = deeper ? -3 * o2 : 0;
  //echo("br", br, br + 2 * 0.2, h);

  translate([ 0, 0, dz + h / 2  ])
    cylinder(r=br + 2 * o2, h=h, center=true, $fn=36);
}

module trunk(height, hreach=inch / 2.1, vreach=inch / 2.1) {

  module root() {

    translate([ 0, 0, -0.4 ]) {

      ps = [
        [     hreach, 0,         0 ],
        [ hreach / 4, 0, vreach/ 4 ],
        [   td / 2.8, 0,    vreach ] ];
      ps1 = _bezier_points(ps, 8);
      polyhulls(ps1) { bal(); }

      for (i = [ 0 : len(ps1) - 2 ])
        hull() {
          translate(ps1[i]) bal();
          translate(ps1[i + 1]) bal();
          translate([ 0, -bd / 2, 0 ]) bal();
          translate([ 0, bd / 2, 0 ]) bal();
        }
    }
  }

  difference() {

    // ++

    union() {
      cylinder(d=td, h=height, $fn=8); // trunk
      for (a = [ 0 : 90 : 270 ]) rotate([ 0, 0, a ]) root();
    }

    // --

    translate([ 0, 0, -10 / 2 ])
      cube(size=[ 3 * hreach, 3 * hreach, 10 ], center=true);

    translate([ 0, 0, 2 * o2 ]) balcyl();
    //translate([ 0, 0, height - br * 2.8 - 2 * o2 ]) balcyl(true);
  }
}

//trunk((-0.49 + 1) * inch); // stump
//trunk(4 * inch, inch, inch / 2);


//
// tree shape / upper stage

module pyramidal(diameter, height) {

  r = diameter / 2;
  td1 = td + 3 * o2;

  difference() {
    hull()
      union() {
        translate([ 0, 0, height ]) bal();
        for (a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) translate([ 0, r - rr, rr ]) bal();
        }
      }
    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}

//pyramidal(1.4 * inch, 2.8 * inch);

module conical(diameter, height, hratio1=0.25, hratio2=0.25) {

  r = diameter / 2;
  td1 = td + 3 * o2;
  r0 = td1 / 2 + 2 * o2;
  h1 = height * hratio1;
  h2 = height * hratio2;

  difference() {
    hull()
      union() {
        for(a = [ 0 : 60 : 300 ]) {
          rotate([ 0, 0, a ]) translate([ r0, 0, rr ]) bal();
          rotate([ 0, 0, a ]) translate([ r, 0, h1 ]) bal();
          if (h2 != h1) rotate([ 0, 0, a ]) translate([ r, 0, h2 ]) bal();
        }
        translate([ 0, 0, height ]) bal();
      }
    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}

//conical(1.4 * inch, 3.5 * inch, 0.14, 0.42);
//conical(1.4 * inch, 3.5 * inch, 0.14, 0.14);

module ballesque(max_diameter, height_scale) {

  td1 = td + 3 * o2;

  difference() {
    scale([ 1, 1, height_scale ])
      translate([ 0, 0, max_diameter / 2 ])
        sphere(d=max_diameter);
    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}
//ballesque(3.5 * inch, 1.2);

module cuboidal(corner_radius, side_a, side_b, height) {

  a2 = side_a / 2;
  b2 = side_b / 2;
  td1 = td + 3 * o2;
  fn = 24;

  difference() {

    translate([ 0, 0, corner_radius ]) hull() {

      translate([ -a2, -b2, 0 ]) sphere(r=corner_radius, $fn=fn);
      translate([ -a2, b2, 0 ]) sphere(r=corner_radius, $fn=fn);
      translate([ a2, -b2, 0 ]) sphere(r=corner_radius, $fn=fn);
      translate([ a2, b2, 0 ]) sphere(r=corner_radius, $fn=fn);

      translate([ -a2, -b2, height ]) sphere(r=corner_radius, $fn=fn);
      translate([ -a2, b2, height ]) sphere(r=corner_radius, $fn=fn);
      translate([ a2, -b2, height ]) sphere(r=corner_radius, $fn=fn);
      translate([ a2, b2, height ]) sphere(r=corner_radius, $fn=fn);
    }

    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}
//cuboidal(8, 2.5 * inch, 2.5 * inch, 1.5 * inch);

module ovoidal(
  lo_radius, lo_z_scale, lo_to_hi,
  hi_radius, hi_z_scale
) {
  td1 = td + 3 * o2;
  difference() {
    // +++
    translate([ 0, 0, lo_radius * lo_z_scale ]) hull() {
      scale([ 1, 1, lo_z_scale ]) sphere(r=lo_radius);
      translate([ 0, 0, lo_to_hi ])
        scale([ 1, 1, hi_z_scale ]) sphere(r=hi_radius);
    }
    // ---
    #translate([ 0, 0, - o2 ]) cylinder(d=td1, h=inch + o2, $fn=36);
  }
}

translate([ 0, 0, 0 ])
  ovoidal(
    1.5 * inch, 0.56,
    0.77 * inch, // lo_to_hi
    0.9 * inch, 1);

translate([ 5 * inch, 0, 0 ])
  ovoidal(
    1.2 * inch, 0.56,
    1.4 * inch, // lo_to_hi
    0.9 * inch, 1);

translate([ 5 * inch, 5 * inch, 0 ])
  ovoidal(
    1.2 * inch, 0.56,
    1.4 * inch, // lo_to_hi
    1.1 * inch, 1);

translate([ 0, 5 * inch, 0 ])
  ovoidal(
    1.4 * inch, 0.56,
    1.4 * inch, // lo_to_hi
    1.6 * inch, 0.6);

