
$fn=6;

// unit is mm


baldia = 17; // ball diameter
//holdia = 12; // hole diameter

labthi = 3.0; // label thickness
lablen = 56.0; // label thickness
labwid = baldia * 0.77;; // label widths
sliwid = 0.8; // slit width

weihei = 4.2 * 0.84; // weight height

echo(labwid);


union() {
  #sphere(d=baldia, $fn=36);
  translate([ 0, 0, -baldia / 2 - weihei * 0.205 ])
    cylinder(d=baldia * 0.53, h=weihei, $fn=12, center=true);
}

translate([ 0, 0, lablen * 0.5 ])
  difference() {
    cube(size=[ labwid, labthi, lablen ], center=true);
    lw = labwid * 0.77;
    echo(lw);
    lt = labthi * 0.6;
    ll = lablen * 0.7;
    translate([ 0, -lt * 0.5, (lablen - ll) * 0.4 ])
      cube(size=[ lw, lt, ll ], center=true);
    sw = labwid * 0.9;
    st = lt * 0.5;
    translate([ 0, -st * 0.5, (lablen - ll) * 0.4 + 1 ])
      cube(size=[ sw, st, ll + 2 ], center=true);
  }

