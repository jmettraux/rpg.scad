
//
// doll.scad
//

$fn = 24;

//include <minis_core.scad>; #base();

function to_xyz(length, angles, sp=[ 0, 0, 0 ]) = [
  sp.x + length * cos(angles[0]) * cos(angles[1] + 90),
  sp.y + length * cos(angles[0]) * sin(angles[1] + 90),
  sp.z + length * sin(angles[0]) ];

function vlen(vector) =
  sqrt(pow(vector.x, 2) + pow(vector.y, 2) + pow(vector.z, 2));

function vor(vector, index, default) =
  vector[index] ? vector[index] : default;

function body_points(
  height,
  basin_ratio,
  shoulder_ratio,
  spine_vectors=[],
  left_leg_vectors=[],
  right_leg_vectors=[],
  left_arm_vectors=[],
  right_arm_vectors=[]
) =
  let(

    hh = height / 8, // head height
    hh2 = hh / 2,
    bw2 = hh * basin_ratio / 2, // basin width / 2
    sw2 = hh * shoulder_ratio / 2, // shoulder width / 2
    fl = hh * 0.7, // foot length

    svs = spine_vectors,
    sp0 = [ 0, 0, 0 ],
    sp1 = to_xyz(hh, vor(svs, 0, [ 90, 0 ]), sp0),
    sp2 = to_xyz(hh, vor(svs, 1, [ 90, 0 ]), sp1),
    sp3 = to_xyz(hh2, vor(svs, 2, [ 90, 0 ]), sp2),
    sp4 = to_xyz(hh2, vor(svs, 3, [ 90, 0 ]), sp3),
    sp5 = to_xyz(hh2, vor(svs, 4, [ 90, 0 ]), sp4),

    llvs = left_leg_vectors,
    llp0 = to_xyz(bw2, vor(llvs, 0, [ 0, 90 ]), sp0),
    llp1 = to_xyz(2 * hh, vor(llvs, 1, [ -90, 0 ]), llp0),
    llp2 = to_xyz(2 * hh, vor(llvs, 2, [ -90, 0 ]), llp1),
    llp3 = to_xyz(fl, vor(llvs, 3, [ 0, 0 ]), llp2),

    rlvs = right_leg_vectors,
    rlp0 = to_xyz(bw2, vor(rlvs, 0, [ 0, -90 ]), sp0),
    rlp1 = to_xyz(2 * hh, vor(rlvs, 1, [ -90, 0 ]), rlp0),
    rlp2 = to_xyz(2 * hh, vor(rlvs, 2, [ -90, 0 ]), rlp1),
    rlp3 = to_xyz(fl, vor(rlvs, 3, [ 0, 0 ]), rlp2)
  ) [
    [ sp0, sp1, sp2, sp3, sp4, sp5 ], // spine points
    [ llp0, llp1, llp2, llp3 ], // left leg points
    [ rlp0, rlp1, rlp2, rlp3 ], // right leg points
    [], // left arm points
    [], // right arm points
    [ "hh", hh ] // debug
  ];

echo("=======================================================================");
bps = body_points(
  33, 1.6, 2.5,
  [ [ 90, 0 ] ]); // spine vectors
echo(bps);

sps = bps[0];
for (sp = sps) translate(sp) sphere(0.7);

llps = bps[1];
for (llp = llps) translate(llp) color("blue", 0.6) sphere(0.5);

rlps = bps[2];
for (rlp = rlps) translate(rlp) color("red", 0.6) sphere(0.5);

//echo("-----------------------------------------------------------------------");
//
//echo(to_xyz(4, [ 0, 0 ]));
//echo(vlen(to_xyz(4, [ 0, 0 ])));
//
//echo(to_xyz(4, [ 45, 0 ]));
//echo(vlen(to_xyz(4, [ 45, 0 ])));
//
//echo(to_xyz(4, [ 45, 45 ]));
//echo(vlen(to_xyz(4, [ 45, 45 ])));

