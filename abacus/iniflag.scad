
$fn=6;

// unit is mm


baldia = 17; // ball diameter
//holdia = 12; // hole diameter

cyldia = baldia * 0.2; // cylinder diameter
cylhei = 56.0; // cylinder height

sliwid = 0.4; // slit width


#sphere(d=baldia, $fn=36);

difference() {
  cylinder(d=cyldia, h=cylhei);
  #translate([ 0, 0, cylhei * 0.7 ])
    cube(size=[ cyldia * 2, sliwid, cylhei * 0.5 ], center=true);
}

//culen = baldia * 1.3; // cube length
//cudep = baldia * 0.7; // cube depth
//cuhei = baldia * 1.2; // cube height
//
//beamwid = cudep / 2;
//
//lalen = 63.0; // label length
//lathi = 3.5; // label thickness
//lawid = cudep; // label width
//
//
//module beam() {
//
//  //translate([ 0, 0, 0 ])
//  cube(size=[ culen, beamwid, beamwid ], center=true);
//}
//
//module claw() {
//
//  difference() {
//
//    translate([ culen / 4, 0, 0 ])
//      cube(size=[ culen / 2, cudep, cuhei ], center=true);
//    translate([ 0, 0, -cuhei * 0.28 ])
//      sphere(d=baldia, $fn=36);
//    translate([ 0, beamwid / 2, cuhei / 2 - beamwid / 2 ])
//      beam();
//  }
//  translate([ 0, -beamwid / 2, cuhei / 2 - beamwid / 2 ])
//    beam();
//}
//
//claw();
//translate([ 0, cudep * 2, 0 ]) rotate([ 0, 0, 0 ]) claw();
//
//translate([ - lathi / 2 + culen / 2, 0, lalen / 2 + cuhei / 2 ])
//  cube(size=[ lathi, lawid, lalen ], center=true);
//
//lathi1 = lathi / 2;
//  //
//translate([ - lathi / 2 + culen / 2, cudep / 2 + lathi1 / 2, lalen / 2 ])
//  cube(size=[ lathi, lathi1, lalen + cuhei ], center=true);

