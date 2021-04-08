
$fn=12;

// unit is mm

holdia = 10; // hole diameter
holdis = holdia * 1.2; // distance between two adjacent center holes
holdis1 = holdia * 1.4;
cen2bor = holdia * 1.1; // center to border top

topbot_ratio = 1.2;

len0 = cen2bor + 2 * holdis + holdis1 + 5 * holdis + cen2bor;
wid0 = cen2bor * 2;

hei = 10; // height
thk = 2; // thickness

module base() {
linear_extrude(hei, scale=1/topbot_ratio, center=true)
  square([ len0, wid0 ], center=true);
}

difference() {
  base();
  translate([ 0, 0, -thk ]) base();
}

