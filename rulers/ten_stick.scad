
// eight_stick.scad

$fn=12;

// unit is mm

itmm = 25.4; // inch to mm

l = 10;
length = l * itmm;
thickness = 5;
notch_thickness = 1;
nt2 = notch_thickness / 2;
text_thickness = 0.8;
font_size = 3.7;

module square_mark() {
  cube([ notch_thickness, notch_thickness, thickness ]);
  translate([ 0, thickness - nt2, 0 ])
    cube([ notch_thickness, notch_thickness, thickness ]);
  translate([ 0, 0, thickness - nt2 ])
    cube([ notch_thickness, thickness, notch_thickness ]);
  //translate([ 0, 0, - 0.75 * notch_thickness ])
  //  cube([ notch_thickness, thickness, notch_thickness ]);
}

difference() {

  cube([ length, 5, 5 ]);

  for (i = [ 0 : l ]) {

    translate([ - nt2 + i * itmm, 0, 0 ]) square_mark();

    translate([ (i + 1) * itmm - 0.7, 0.44, thickness - text_thickness * 0.9 ])
      linear_extrude(text_thickness)
        text(str((i + 1) * 5, "ft"), size=font_size, halign="right");
    rotate([ 90, 0, 0 ])
      translate([ (i + 1) * itmm - 0.7, 0.2, -text_thickness * 0.9 ])
        linear_extrude(text_thickness)
          text(str((i + 1) * 1.5, "m"), size=font_size, halign="right");
    rotate([ 90, 0, 180 ])
      translate([ -(i + 1) * itmm + 0.7, 1.1, thickness - 0.9 * text_thickness ])
        linear_extrude(text_thickness)
          text(str((i + 1), "sq"), size=font_size, halign="left");
  }

  for (i = [ 1, 7 ]) {
    translate([ i * itmm + 0.2, 0.44, thickness - 0.9 * text_thickness ])
      linear_extrude(text_thickness)
        text(" >", size=font_size, halign="left");
    rotate([ 90, 0, 0 ])
      translate([ i * itmm + 0.2, 0.2, -0.9 * text_thickness ])
        linear_extrude(text_thickness)
          text(" >", size=font_size, halign="left");
    rotate([ 90, 0, 180 ])
      translate([ -i * itmm - 0.2, 0.2, thickness - 0.9 * text_thickness ])
        linear_extrude(text_thickness)
        text("< ", size=font_size, halign="right");
  }

  // t-2  t  F

  translate([ 4.04 * itmm, 0.44, thickness - text_thickness * 0.9 ])
    linear_extrude(text_thickness)
      text("t-2", size=font_size, halign="left");
  translate([ 6.04 * itmm, 0.44, thickness - text_thickness * 0.9 ])
    linear_extrude(text_thickness)
      text("t", size=font_size, halign="left");
  translate([ 8.04 * itmm, 0.44, thickness - text_thickness * 0.9 ])
    linear_extrude(text_thickness)
      text("F", size=font_size, halign="left");
}

