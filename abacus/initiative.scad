
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
//holdis1 = baldia * 1.3;
//trkdis = baldia * 1.11; // distance between the two tracks

//rad = 3.5 * baldia;
//twi = 2.8; // track width
//out = rad * 0.65; // outcentering...

holcnt = 13; // hole count

hei = 4.2; // height

boalen = (holcnt + 2) * baldia; // board length
boawid = baldia * 3.5;


module base() {
  bw2 = boawid / 2;
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
base();

