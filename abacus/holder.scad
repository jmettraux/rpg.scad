
//$fn=6;

// unit is mm

len = 140; // length
wid = 45; // width
hei = 8.4; // height

sla = -10; // slit angle
swi = 0.84; // slit width
ssd = swi * 3; // slit to slit distance
mnt = 2.5; // min thickness


difference() {

  hull() {
    cube(size=[ len, wid, hei ], center=false);
    translate([ len + wid / 3, wid / 2, 0 ])
      cylinder(d=wid / 3, h=hei, $fn=12);
  }
  //echo(len + wid / 3 + wid / 2);

  // slit

  for (i = [ 1 : 61 ]) {
    translate([ i * ssd, wid / 2, hei + mnt ])
      rotate([ 0, sla, 0 ])
        cube(size=[ swi, wid * 1.1, hei * 2 ], center=true);
  }
}

