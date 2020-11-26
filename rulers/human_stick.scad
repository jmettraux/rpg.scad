
// human_stick.scad

$fn=12;

// unit is mm

itmm = 25.4; // inch to mm

l = 6;
length = l * itmm;
thickness = 5;
notch_thickness = 1;
nt2 = notch_thickness / 2;
text_thickness = 0.8;
font_size = 4.5;

difference() {

  cube([ length, 5, 5 ]);

  for (i = [ 0 : l ]) {
    translate([ - nt2 + i * itmm, 0, 0 ])
      union() {
        cube([ notch_thickness, notch_thickness, thickness ]);
        translate([ 0, thickness - nt2, 0 ])
          cube([ notch_thickness, notch_thickness, thickness ]);
        translate([ 0, 0, thickness - nt2 ])
          cube([ notch_thickness, thickness, notch_thickness ]);
      }
    translate([ (i + 1) * itmm - 0.7, 0.2, thickness - text_thickness * 0.9 ])
      linear_extrude(text_thickness)
        text(str((i + 1) * 5, "ft"), size=font_size, halign="right");
    rotate([ 90, 0, 0 ])
      translate([ (i + 1) * itmm - 0.7, 0.2, -text_thickness *.9 ])
        linear_extrude(text_thickness)
          text(str((i + 1) * 1.5, "m"), size=font_size, halign="right");
  }

  rotate([ 90, 0, 180 ])
    translate([ -6 * itmm + 0.7, 0.2, thickness - 0.9 * text_thickness ])
      linear_extrude(text_thickness)
      text("human", size=font_size, halign="left");
  rotate([ 90, 0, 180 ])
    translate([ -4 * itmm + 0.7, 0.2, thickness - 0.9 * text_thickness ])
      linear_extrude(text_thickness)
      text("hnd axe", size=font_size, halign="left");
}

