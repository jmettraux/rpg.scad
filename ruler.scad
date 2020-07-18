
$fn=12;

// unit is mm

itmm = 25.4;
thickness = 2.8;
width = 24;
//lsq = 16; // squares
lsq = 11; // squares
length = lsq * itmm;
tthick = 0.8;

//  - 10 sq
//  / 12 sq


translate([ -length / 2, 0, 0 ]) difference() {

  union() {

    cube([ length, width, thickness ]);

    fs = 6;
    //fs1 = 7;

    d = 1.16 * fs;

    for (j = [ 1 : lsq ]) {

      x = (lsq - j) * itmm + 3;
      y = 2.0;

      translate([ x, y, thickness ])
        linear_extrude(tthick) union() {
          if (j == 5) text(str(j, "   dh"), size=fs);
          if (j == 6) text(str(j, "   he"), size=fs);
          if (j == 10) text(str(j, "  w"), size=fs);
          if (j == 12) text(str(j, "  h"), size=fs);
          else text(str(j), size=fs);
        }

      translate([ x, y + 1 * d, thickness ])
        linear_extrude(tthick)
          text(str(j * 1.5, "m"), size=fs);
      translate([ x, y + 2 * d, thickness ])
        linear_extrude(tthick)
          text(str(j * 5, "ft"), size=fs);

      //if (j == 4) {
      //  y1 = y + 0.8 * width;
      //  translate([ x, y1, thickness ]) linear_extrude(tthick)
      //    text("dg dt lhmr hndx spr trd", size=fs1);
      //    //text("< dagger, dart, light hammer, handaxe, spear, trident", size=fs1);
      //}
      //else if (j == 5) {
      //  y1 = y + 0.65 * width;
      //  translate([ x, y1, thickness ]) linear_extrude(tthick)
      //    text("dwarf halfling | blowgun", size=fs1);
      //    //text("< dwarf, halfling, blowgun", size=fs1);
      //}
      //else if (j == 6) {
      //  y1 = y + 0.50 * width;
      //  translate([ x, y1, thickness ]) linear_extrude(tthick)
      //    text("elf hum | jav slng hxbow mg_hnd_0", size=fs1);
      //    //text("< elf, human, javelin, sling, hand crossbow, mage hand 0", size=fs1);
      //}
      //else if (j == 10) {
      //  y1 = y + 0.8 * width;
      //  translate([ x, y1, thickness ]) linear_extrude(tthick)
      //    text("wolf", size=fs1);
      //    //text("< wolf", size=fs1);
      //}
      //else if (j == 12) {
      //  y1 = y + 0.65 * width;
      //  translate([ x, y1, thickness ]) linear_extrude(tthick)
      //    text("< horse, ray of frost 0", size=fs1);
      //  translate([ x, y1 - d, thickness ]) linear_extrude(tthick)
      //    text("<< dagger, dart, light hammer, handaxe, spear, trident", size=fs1);
      //}
      //else if (j == 16) {
      //  y1 = y + 0.8 * width;
      //  translate([ x, y1, thickness ]) linear_extrude(tthick)
      //    text("< light crossbow, short bow", size=fs1);
      //}
    }
  }

  union() {

    for (j = [ 1 : lsq ]) {

      x = (lsq - j) * itmm;

      translate([ x, -0.1, -0.1 * thickness ])
        cube([ 2, width / 3.5, 1.2 * thickness ]);

      translate([ x, 0.95 * width, -0.1 * thickness ])
        cube([ 2, width / 2, 1.2 * thickness ]);

      if (j == lsq) {

        translate([ x - 0.1, -0.1, -0.1 * thickness ])
          cube([ 2, width / 3.5, 1.2 * thickness ]);

        translate([ x - 0.1, 0.95 * width, -0.1 * thickness ])
          cube([ 2, width / 2, 1.2 * thickness ]);
      }

      //if (j == 4 || j == 10 || j == 16) {
      //  translate([ x, 0.85 * width, -0.1 * thickness ])
      //    cube([ 2, width / 2, 1.2 * thickness ]);
      //}
      //else if (j == 5) {
      //  translate([ x, 0.68 * width, -0.1 * thickness ])
      //    cube([ 2, width / 2, 1.2 * thickness ]);
      //}
      //else if (j == 6 || j == 12) {
      //  translate([ x, 0.54 * width, -0.1 * thickness ])
      //    cube([ 2, width / 2, 1.2 * thickness ]);
      //}
    }
  }
}

