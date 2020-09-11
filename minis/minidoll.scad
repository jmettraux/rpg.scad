
//
// doll.scad
//

include <minilib.scad>;


  // Accept a single angle instead of [ angle0, angle1 ]
  //
function to_xyz(length, angles, sp=[ 0, 0, 0 ]) =
  let(
    as = is_num(angles) ? [ angles, 0 ] : angles,
    elevation = as[0],
    direction = as[1] + 90
  )
    sp + [
      length * cos(elevation) * cos(direction),
      length * cos(elevation) * sin(direction),
      length * sin(elevation) ];

function vlen(vector) =
  sqrt(pow(vector.x, 2) + pow(vector.y, 2) + pow(vector.z, 2));

function vor(vector, index, default) =
  vector[index] ? vector[index] : default;

function body_points(
  height,
  spine_vectors=[],
  left_leg_vectors=[],
  right_leg_vectors=[],
  left_arm_vectors=[],
  right_arm_vectors=[],
  basin_ratio=0,
  waist_ratio=0,
  shoulder_ratio=0
) =
  let(

    br =
      basin_ratio == 0 ? 1.2 :
      basin_ratio == "male" ? 1.2 :
      basin_ratio == "female" ? 1.7 :
      basin_ratio,
    wr =
      waist_ratio == 0 ?  1.1 :
      waist_ratio,
    sr =
      shoulder_ratio == 0 ?  2.1 :
      shoulder_ratio == "male" ? 2.3 :
      shoulder_ratio == "female" ? 2.1 :
      shoulder_ratio,

    hh = height / 8, // head height
    hh2 = hh / 2,
    bw2 = hh * br / 2, // basin width / 2
    sw2 = hh * sr / 2, // shoulder width / 2
    ww2 = hh * wr / 2, // wast width / 2
    fl = hh * 0.7, // foot length
    hl = hh * 0.6, // hand length

    svs = spine_vectors,
    sp0 = [ 0, 0, 0 ],
    sp1 = to_xyz(hh, vor(svs, 0, [ 90, 0 ]), sp0),
    sp2 = to_xyz(hh, vor(svs, 1, [ 90, 0 ]), sp1),
    sp3 = to_xyz(hh2, vor(svs, 2, [ 90, 0 ]), sp2),
    sp4 = to_xyz(hh2, vor(svs, 3, [ 90, 0 ]), sp3),
    sp5 = to_xyz(hh2, vor(svs, 4, [ 90, 0 ]), sp4),
      //
    sp1h = to_xyz(0.7 * hh, vor(svs, 0, [ 90, 0 ]), sp0),
    wal = to_xyz(ww2, vor(left_leg_vectors, 0, [ 0, 90 ]), sp1h),
    war = to_xyz(ww2, vor(left_leg_vectors, 0, [ 0, -90 ]), sp1h),

    llvs = left_leg_vectors,
    llp0 = to_xyz(bw2, vor(llvs, 0, [ 0, 90 ]), sp0),
    llp1h = to_xyz(hh, vor(llvs, 1, [ -90, 0 ]), llp0),
    llp1 = to_xyz(2 * hh, vor(llvs, 1, [ -90, 0 ]), llp0),
    llp2h = to_xyz(hh, vor(llvs, 2, [ -90, 0 ]), llp1),
    llp2 = to_xyz(2 * hh, vor(llvs, 2, [ -90, 0 ]), llp1),
    llp3 = to_xyz(fl, vor(llvs, 3, [ 0, 0 ]), llp2),

    rlvs = right_leg_vectors,
    rlp0 = to_xyz(bw2, vor(rlvs, 0, [ 0, -90 ]), sp0),
    rlp1h = to_xyz(hh, vor(rlvs, 1, [ -90, 0 ]), rlp0),
    rlp1 = to_xyz(2 * hh, vor(rlvs, 1, [ -90, 0 ]), rlp0),
    rlp2h = to_xyz(hh, vor(rlvs, 2, [ -90, 0 ]), rlp1),
    rlp2 = to_xyz(2 * hh, vor(rlvs, 2, [ -90, 0 ]), rlp1),
    rlp3 = to_xyz(fl, vor(rlvs, 3, [ 0, 0 ]), rlp2),

    lavs = left_arm_vectors,
    lap0h = to_xyz(sw2 / 2, vor(lavs, 0, [ 0, 90 ]), sp3),
    lap0 = to_xyz(sw2, vor(lavs, 0, [ 0, 90 ]), sp3),
    lap1h = to_xyz(0.75 * hh, vor(lavs, 1, [ -90, 0 ]), lap0),
    lap1 = to_xyz(1.5 * hh, vor(lavs, 1, [ -90, 0 ]), lap0),
    lap2h = to_xyz(0.75 * hh, vor(lavs, 2, [ -90, 0 ]), lap1),
    lap2 = to_xyz(1.5 * hh, vor(lavs, 2, [ -90, 0 ]), lap1),
    lap3 = to_xyz(hl, vor(lavs, 3, [ 0, 90 ]), lap2),

    ravs = right_arm_vectors,
    rap0h = to_xyz(sw2 / 2, vor(ravs, 0, [ 0, -90 ]), sp3),
    rap0 = to_xyz(sw2, vor(ravs, 0, [ 0, -90 ]), sp3),
    rap1h = to_xyz(0.75 * hh, vor(ravs, 1, [ -90, 0 ]), rap0),
    rap1 = to_xyz(1.5 * hh, vor(ravs, 1, [ -90, 0 ]), rap0),
    rap2h = to_xyz(0.75 * hh, vor(ravs, 2, [ -90, 0 ]), rap1),
    rap2 = to_xyz(1.5 * hh, vor(ravs, 2, [ -90, 0 ]), rap1),
    rap3 = to_xyz(hl, vor(ravs, 3, [ 0, -90 ]), rap2),

    z0 = llp3.z,
    z1 = rlp3.z,
    z = - (z0 < z1 ? z0 : z1)

  ) [
    [ sp0, wal, war, sp1, sp2, sp3, sp4, sp5 ], // spine points
    [ llp0, llp1h, llp1, llp2h, llp2, llp3 ], // left leg points
    [ rlp0, rlp1h, rlp1, rlp2h, rlp2, rlp3 ], // right leg points
    [ lap0h, lap0, lap1h, lap1, lap2h, lap2, lap3 ], // left arm points
    [ rap0h, rap0, rap1h, rap1, rap2h, rap2, rap3 ], // right arm points
    z, // ground to start z
    [ "hh", hh ] // debug
  ];


echo("======================================================================");

#base();

$fn = 24;

bps = body_points(
  33,
  [ 80, 80, 80, 70 ], // spine vectors
  [ undef, -80, -150, -45 ], // left leg vectors
  [],
  [],
  [ undef, -80, -50, 45 ]);
echo(bps);

d = [ 0, 0, bps[5] ];

sps = bps[0];
echo(concat("spine points", sps));
for (sp = sps) translate(d + sp) sphere(0.7);

llps = bps[1];
echo(concat("left leg points", llps));
for (llp = llps) translate(d + llp) color("blue", 0.6) sphere(0.5);

rlps = bps[2];
echo(concat("right leg points", rlps));
for (rlp = rlps) translate(d + rlp) color("red", 0.6) sphere(0.5);

laps = bps[3];
for (lap = laps) translate(d + lap) color("red", 0.6) sphere(0.5);

raps = bps[4];
for (rap = raps) translate(d + rap) color("blue", 0.6) sphere(0.5);

