
//
// initiative.scad
//

$fn=6;

//use <cadence.scad>;


// unit is mm


baldia = 17; // ball diameter
holdia = 12; // hole diameter
holrad = holdia / 2;
holdis = baldia; // hole distance, center to center
holdisc = baldia * 0.77;
//holdis1 = baldia * 1.3;
//trkdis = baldia * 1.11; // distance between the two tracks

//rad = 3.5 * baldia;
twi = 2.8; // track width
//out = rad * 0.65; // outcentering...

holcnt = 11; // hole count

hei = 4.2; // height
h4 = hei / 4;

boalen = (holcnt + 2) * baldia; // board length
boawid = baldia * 3.5;

bw2 = boawid / 4;


module base() {

  hull() {
    translate([ bw2, 0, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
    translate([ boalen + bw2, 0, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
    translate([ 0, bw2, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
    translate([ boalen, bw2, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
  }
  hull() {
    translate([ bw2, 0, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
    translate([ boalen + bw2, 0, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
    translate([ 0, -bw2, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
    translate([ boalen, -bw2, 0 ]) cylinder(d=holdia, h=hei, $fn=12);
  }
}

module cyl() {
  translate([ 0, 0, -h4 ]) cylinder(d=holdia, h=hei * 2);
}
module fur(dis=holdis) { // furrow
  translate([ 0, 0, h4 ]) cube(size=[ dis, twi, hei * 2 ], center=true);
}

module track(cnt, dis=holdis, furrows=true, startFurrow=false, endFurrow=false) {
  for(i = [0:cnt - 1]) {
    if (i == 0 && startFurrow) translate([ -dis / 3, 0, 0 ]) fur(dis);
    translate([ i * dis, 0, 0 ]) cyl();
    if (i < cnt - 1 || endFurrow) translate([ i * dis + dis / 2, 0, 0 ]) fur(dis);
  }
}

difference() {

  base();

  d = holdis * 0.5;

  translate([ holdis * 1.1, d, 0 ])
    track(13, startFurrow=true);
  translate([ holdis * 1.1, d - holdis, 0 ])
    track(13, startFurrow=true);
}

