
$fn=6;

// unit is mm


baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center
//holdis1 = baldia * 1.3;
//trkdis = baldia * 1.11; // distance between the two tracks
//cen2bor = holdia * 0.6; // center to border top

hourrad = 2.7 * baldia;
minuterad = 3.5 * baldia;

twi = 2.8; // track width

hei = 4.2; // height


module base() {
  cylinder(d = minuterad * 2.1 + baldia, h=hei, $fn=12);
}
module cyl(a) {
  translate([ 0, 0, - hei * 0.5 ])
    rotate([ 0, 0, -a ])
      cylinder(d=holdia, h=hei * 2);
}
module canal() {
  translate([ 0, 0, hei * 0.9 ])
    cube(size=[ twi, baldia, hei * 0.5 ], center=true);
}

difference() {

  base();

  // center triangle

  translate([ 0, 0, - hei * 0.5 ])
    cylinder(d=hourrad * 1.70, h=hei * 2, $fn=6);

  // minute holes

  mins = 30;
  md = 360 / mins;

  for (i = [0:mins - 1]) {
    a = i * md;
    rotate([ 0, 0, a ]) translate([ minuterad, 0, 0 ]) cyl(a);
    rotate([ 0, 0, a + md ]) translate([ minuterad * 0.99, 0, 0 ]) canal();
  }

  // hour holes

  hd = 360 / 12;

  for (i = [0:11]) {

    a = i * hd;

    rotate([ 0, 0, a ]) translate([ hourrad, 0, 0 ]) cyl(a);
    rotate([ 0, 0, a + 0.5 * hd ]) translate([ hourrad * 0.99, 0, 0 ]) canal();

    //a1 = -i * hd + hd - 90;
    //#rotate([ 0, 0, a1 + 0.5 * hd ])
    //  translate([ hourrad * 0.8, 0 + 4, hei ])
    //    rotate([ 0, 0, -(a1 + 0.5 * hd) - 90 ])
    //      text(str(i + 1), size=3);
  }

  // 12 o'clock canal

  translate([ hourrad, 0, 0 ]) rotate([ 0, 0, 90 ]) canal();
  translate([ minuterad * 1.03, 0, 0 ]) rotate([ 0, 0, 90 ]) canal();

  // 12

  translate([ hourrad * 0.8, -3.3, hei * 0.6 ]) rotate([ 0, 0, -90 ])
    linear_extrude(hei * 0.6) text("12", size=6.1);
}
