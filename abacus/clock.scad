
$fn=6;

// unit is mm


baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center

twi = 2.8; // track width

hei = 5.6; // height


function rada(angle, c=holdis) = c / (2 * sin(angle / 2));
function radc(hole_count, c=holdis) = rada(360 / hole_count, c);

module cyl(a) {
  translate([ 0, 0, - hei * 0.5 ])
    rotate([ 0, 0, -a ])
      cylinder(d=holdia, h=hei * 2);
}

module base(rad) {
  cylinder(r = rad, h=hei, $fn=32);
}

module canal() {
  //translate([ 0, 0, hei * 0.9 ])
  //  cube(size=[ twi, baldia, hei * 0.5 ], center=true);
}

module ring(hole_count, radius=-1, canal_length=-1) {

  a = 360 / hole_count;
  r = radius < 0 ? rada(a) : radius;
  echo(hole_count, r);
  l = canal_length < 0 ? baldia * 1.2 : canal_length;

  for (i = [ 0 : hole_count ]) {
    rotate([ 0, 0, i * a ]) translate([ 0, r, 0 ])
      cyl(0);
    rotate([ 0, 0, i * a ]) translate([ 0, r, hei * 0.9 ])
      rotate([ 0, 0, 90 ])
        cube(size=[ twi, l, hei * 0.5 ], center=true);
  }
}

difference() {

  base(radc(39.7));

  cyl(90);

  ring(6);
  ring(12, radc(6) + baldia);
  ring(24);
  ring(30, radc(24) + baldia);
  ring(30, radc(24) + baldia + baldia, baldia * 1.4);

  translate([ 0, baldia * 5, hei * 0.9 ])
    cube(size=[ twi, baldia * 10, hei * 0.5 ], center=true);
}

