
// dice.scad

// unit is mm

tdepth = 2; // text depth
tsize = 13; // text size

module dice(sides, radius=14, height=45, num=false) {

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

    a = 360 / sides;
    hr = tsize / 2;

    if (num) {
      #for(i = [ 0 : sides - 1 ]) {
        rotate([ 0, 0, i * a + a/2 ])
        translate([ 0, -radius * 0.8, 0 ])
        rotate([ 90, 0, 0 ])
        translate([ -5, 0, -tdepth * 1.5 ])
        linear_extrude(tdepth * 3) text(str(i + 1), size=tsize * 0.9);
      }
    }
    else {
      for(i = [ 0 : sides - 1 ]) {
        rotate([ 0, 0, i * a + a/2 ])
          translate([ radius * 0.7, 0, i * hr * 0.5 ])
          rotate([ 0, 90, 0 ])
            for(j = [ 0 : i ]) {
              translate([ j * hr * 1.1, 0, 0 ])
                cylinder(d=hr, h=tdepth * 4, $fn=sides, center=true);
            }
      }
    }
  }
}

dice(5);

//translate([   0, 40, 0 ]) dice(3);
//translate([  40, 40, 0 ]) dice(4);
//translate([  80, 40, 0 ]) dice(5);
//translate([ 120, 40, 0 ]) dice(6);
//translate([ 160, 40, 0 ]) dice(7);
//translate([ 200, 40, 0 ]) dice(8);
//translate([ 240, 40, 0 ]) dice(9);

translate([   0, -40, 0 ]) dice(3, num=true);
translate([  40, -40, 0 ]) dice(4, num=true);
translate([  80, -40, 0 ]) dice(5, num=true);
translate([ 120, -40, 0 ]) dice(6, num=true);
translate([ 160, -40, 0 ]) dice(7, num=true);
//translate([ 200, -40, 0 ]) dice(8, num=true);
//translate([ 240, -40, 0 ]) dice(9, num=true);

