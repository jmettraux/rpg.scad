
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
font_size = 4.2;

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
  }
}

