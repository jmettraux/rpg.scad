
// dice.scad

// unit is mm

tdepth = 2; // text depth
tsize = 13; // text size

module dice(sides, radius=14, height=45) {

  difference() {

    // +

    linear_extrude(height=height, center=true) {
      circle(r=radius, $fn=sides);
    }

    // -

    translate([ - radius / 2.8, - radius / 2.2, height / 2 - tdepth + 0.5 ])
      linear_extrude(tdepth) text(str(sides), size=tsize);
    translate([ - radius / 2.8, - radius / 2.2, - height / 2 - tdepth * 0.3  ])
      linear_extrude(tdepth) text(str(sides), size=tsize);

    for(i = [ 0 : sides - 1 ]) {
    }
  }
}

dice(5);
translate([   0, 30, 0 ]) dice(3);
translate([  30, 30, 0 ]) dice(4);
translate([  60, 30, 0 ]) dice(5);
translate([  90, 30, 0 ]) dice(6);
translate([ 120, 30, 0 ]) dice(7);
translate([ 150, 30, 0 ]) dice(8);
translate([ 180, 30, 0 ]) dice(9);

