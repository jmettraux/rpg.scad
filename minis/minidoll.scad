
//
// minidoll.scad
//

include <minilib.scad>;


function body_points(
  height,
  basin_ratio=0,
  waist_ratio=0,
  shoulder_ratio=0,
  head_height_ratio=0,
  thigh_length_ratio=0,
  shin_length_ratio=0,
  foot_length_ratio=0,
  arm_length_ratio=0,
  forearm_length_ratio=0,
  hand_length_ratio=0,
  low_hip_length_ratio=0,
  trunk_length_1_ratio=0,
  trunk_length_2_ratio=0,
  trunk_length_3_ratio=0,
  to_hip=[ 90, 0 ],
  to_navel=[ 90, 0 ],
  to_neck=[ 90, 0 ],
  to_head=[ 90, 0 ],
  to_low_hip=[ 90, 0 ],
  to_left_hip=[ 0, 90 ],
  to_left_knee=[ -90, 0 ],
  to_left_ankle=[ -90, 0 ],
  to_left_toe=[ 0, 0 ],
  to_right_hip=[ 0, -90 ],
  to_right_knee=[ -90, 0 ],
  to_right_ankle=[ -90, 0 ],
  to_right_toe=[ 0, 0 ],
  to_left_shoulder=[ 0, 90 ],
  to_left_elbow=[ -90, 0 ],
  to_left_wrist=[ -90, 0 ],
  to_left_finger=[ -90, 0 ],
  to_right_shoulder=[ 0, -90 ],
  to_right_elbow=[ -90, 0 ],
  to_right_wrist=[ -90, 0 ],
  to_right_finger=[ -90, 0 ]
) =
  let(

    br =
      basin_ratio == 0 ? 1.0 :
      basin_ratio == "male" ? 1.0 :
      basin_ratio == "female" ? 1.5 :
        basin_ratio,
    wr =
      waist_ratio == 0 ?  1.1 :
        waist_ratio,
    sr =
      shoulder_ratio == 0 ?  2.1 :
      shoulder_ratio == "male" ? 2.1 :
      shoulder_ratio == "female" ? 2.0 :
        shoulder_ratio,

    hhr = head_height_ratio == 0 ? (1 / 8) : head_height_ratio,
    tlr = thigh_length_ratio == 0 ? 2 : thigh_length_ratio,
    slr = shin_length_ratio == 0 ? 2 : shin_length_ratio,
    flr = foot_length_ratio == 0 ? 0.7 : foot_length_ratio,
    alr = arm_length_ratio == 0 ? 1.5 : arm_length_ratio,
    falr = forearm_length_ratio == 0 ? 1.3 : forearm_length_ratio,
    hlr = hand_length_ratio == 0 ? 0.6 : hand_length_ratio,
    lhlr = low_hip_length_ratio == 0 ? 0.7 : low_hip_length_ratio,
    tl1r = trunk_length_1_ratio == 0 ? 1.5 : trunk_length_1_ratio,
    tl2r = trunk_length_2_ratio == 0 ? 0.5 : trunk_length_2_ratio,
    tl3r = trunk_length_3_ratio == 0 ? 0.5 : trunk_length_3_ratio,

    hh = hhr * height, // head height
    bw2 = br * hh / 2, // basin width / 2
    sw2 = sr * hh / 2, // shoulder width / 2
    ww2 = wr * hh / 2, // wast width / 2
    fl = flr * hh, // foot length
    hl = hlr * hh, // hand length
    tl = tlr * hh, // thigh length
    sl = slr * hh, // shin length
    al = alr * hh, // arm length
    fal = falr * hh, // forearm length
    tl1 = tl1r * hh, // trunk length 1
    tl2 = tl2r * hh, // trunk length 2
    tl3 = tl3r * hh, // trunk length 3
    lhl = lhlr * hh, // low hip length

    sp0 = [ 0, 0, 0 ],
    sp1 = _to_point(hh, to_hip, sp0),
    sp2 = _to_point(tl1, to_navel, sp1),
    sp3 = _to_point(tl2, to_neck, sp2),
    sp4 = _to_point(tl3, to_head, sp3),
      //
    sp1h = _to_point(lhl, to_low_hip, sp0),
    wal = _to_point(ww2, to_left_hip, sp1h),
    war = _to_point(ww2, to_right_hip, sp1h),
      // TODO bring back somehow

    llp0 = _to_point(bw2, to_left_hip, sp0),
    llp1 = _to_point(tl, to_left_knee, llp0),
    llp2 = _to_point(sl, to_left_ankle, llp1),
    llp3 = _to_point(fl, to_left_toe, llp2),

    rlp0 = _to_point(bw2, to_right_hip, sp0),
    rlp1 = _to_point(tl, to_right_knee, rlp0),
    rlp2 = _to_point(sl, to_right_ankle, rlp1),
    rlp3 = _to_point(fl, to_right_toe, rlp2),

    lap0 = _to_point(sw2, to_left_shoulder, sp2),
    lap1 = _to_point(al, to_left_elbow, lap0),
    lap2 = _to_point(fal, to_left_wrist, lap1),
    lap3 = _to_point(hl, to_left_finger, lap2),

    rap0 = _to_point(sw2, to_right_shoulder, sp2),
    rap1 = _to_point(al, to_right_elbow, rap0),
    rap2 = _to_point(fal, to_right_wrist, rap1),
    rap3 = _to_point(hl, to_right_finger, rap2),

    z0 = llp3.z,
    z1 = rlp3.z,
    z = - (z0 < z1 ? z0 : z1)

  ) [
    [ sp0, sp1, sp2, sp3, sp4 ], // spine points
    [ wal, sp1h, war ], // waist points
    [ llp0, llp1, llp2, llp3 ], // left leg points
    [ rlp0, rlp1, rlp2, rlp3 ], // right leg points
    [ lap0, lap1, lap2, lap3 ], // left arm points
    [ rap0, rap1, rap2, rap3 ], // right arm points
    z, // ground to start z
    hh, // head height
    [ [ "hh", hh ]  ] // debug dict
  ];

function bpoint(bpoints, name, default=undef) =
  let(

    n = name,

    sps = bpoints[0], // spine points
    wps = bpoints[1], // waist points
    llps = bpoints[2], // left leg points
    rlps = bpoints[3], // right leg points
    laps = bpoints[4], // left arm points
    raps = bpoints[5], // right arm points

    r =
      n == "spine" ? sps :
      n == "left leg" ? llps :
      n == "right leg" ? rlps :
      n == "left arm" ? laps :
      n == "right arm" ? raps :
      n == "left toe" ? llps[3] :
      n == "right toe" ? rlps[3] :
      n == "left ankle" ? llps[2] :
      n == "right ankle" ? rlps[2] :
      n == "left knee" ? llps[1] :
      n == "right knee" ? rlps[1] :
      n == "left hip" ? llps[0] :
      n == "right hip" ? rlps[0] :
      n == "left hand" ? laps[3] :
      n == "right hand" ? raps[3] :
      n == "left wrist" ? laps[2] :
      n == "right wrist" ? raps[2] :
      n == "left elbow" ? laps[1] :
      n == "right elbow" ? raps[1] :
      n == "left shoulder" ? laps[0] :
      n == "right shoulder" ? raps[0] :
      n == "head" ? sps[4] :
      n == "neck" ? sps[3] :
      n == "neck base" ? sps[2] :
      n == "head height" ? bpoints[7] :
      n == "z" ? bpoints[6] :
      n == "left calf" ? _midpoint(llps[1], llps[2], 0.3) :
      n == "right calf" ? _midpoint(rlps[1], rlps[2], 0.3) :
      n == "left thigh" ? _midpoint(llps[0], llps[1], 0.5) :
      n == "right thigh" ? _midpoint(rlps[0], rlps[1], 0.5) :
      n == "left arm" ? _midpoint(laps[0], laps[1], 0.5) :
      n == "right arm" ? _midpoint(raps[0], raps[1], 0.5) :
      n == "left forearm" ? _midpoint(laps[1], laps[2], 0.5) :
      n == "right forearm" ? _midpoint(raps[1], raps[2], 0.5) :
      n == "left midneck" ? _midpoint(sps[3], laps[0], 0.5) :
      n == "right midneck" ? _midpoint(sps[3], raps[0], 0.5) :
        undef
  )
    r == undef ? default : r;

module _bal(p, d) {
  translate(p) sphere(d);
};
module _hul(p0, d0, p1, d1) {
  hull() { _bal(p0, d0); _bal(p1, d1); }
}


module body(
  body_points, // as generated by the body_points() function
  foot_diameter=0,
  ankle_diameter=0,
  calf_diameter=0,
  knee_diameter=0,
  thigh_diameter=0,
  buttock_diameter=0,
  shoulder_diameter=0,
  neck_diameter=0,
  elbow_diameter=0,
  wrist_diameter=0,
  palm_diameter=0,
  waist_diameter=0,
  diameter=0
) {

  sps = body_points[0]; // spine points
  wps = body_points[1]; // waist points
  llps = body_points[2]; // left leg points
  rlps = body_points[3]; // right leg points
  laps = body_points[4]; // left arm points
  raps = body_points[5]; // right arm points
  z = body_points[6]; // foot to start point (basin) z distance
  hh = body_points[7]; // head height

  d = diameter > 0 ? diameter : hh / 4; // default diameter

  fd = foot_diameter > 0 ? foot_diameter : d;
  ad = ankle_diameter > 0 ? ankle_diameter : d;
  //cd = calf_diameter > 0 ? calf_diameter : d;
  kd = knee_diameter > 0 ? knee_diameter : d;
  //td = thigh_diameter > 0 ? thigh_diameter : d;
  bd = buttock_diameter > 0 ? buttock_diameter : d;
  sd = shoulder_diameter > 0 ? shoulder_diameter : d;
  nd = neck_diameter > 0 ? neck_diameter : d;
  ed = elbow_diameter > 0 ? elbow_diameter : d;
  wd = wrist_diameter > 0 ? wrist_diameter : d;
  pd = palm_diameter > 0 ? palm_diameter : d;
  wad = waist_diameter > 0 ? waist_diameter : d;

  _hul(llps[0], bd, llps[1], kd); // left leg
  _hul(llps[1], kd, llps[2], ad); // left foreleg
  _hul(llps[2], ad, llps[3], fd); // left foot
  _hul(rlps[0], bd, rlps[1], kd); // right leg
  _hul(rlps[1], kd, rlps[2], ad); // right foreleg
  _hul(rlps[2], ad, rlps[3], fd); // right foot

  _hul(llps[0], bd, sps[0], bd); // left butt cheek
  _hul(sps[0], bd, rlps[0], bd); // right butt cheek

  _hul(sps[0], d, sps[1], d);
  _hul(sps[1], d, sps[2], d);
  _hul(sps[2], d, sps[3], d); // lower neck
  _hul(sps[3], d, sps[4], d); // top neck

  _hul(laps[0], sd, sps[2], d); // left shoulder
  _hul(sps[2], d, raps[0], sd); // right shoulder

  _hul(laps[0], sd, laps[1], ed); // left arm
  _hul(laps[1], ed, laps[2], wd); // left forearm
  _hul(laps[2], wd, laps[3], pd); // left hand
  _hul(raps[0], sd, raps[1], ed); // right arm
  _hul(raps[1], ed, raps[2], wd); // right forearm
  _hul(raps[2], wd, raps[3], pd); // right hand

  hull() { // waist
    _bal(llps[0], wad); _bal(rlps[0], wad);
    _bal(wps[0], wad); _bal(wps[2], wad);
  }
  hull() { // torso
    _bal(wps[0], wad); _bal(wps[2], wad);
    _bal(laps[0], sd); _bal(sps[2], sd); _bal(raps[0], sd);
  }
}


module robe(
  body_points, // as generated by the body_points() function
  diameter=0
) {

  hh = body_points[7]; // head height
  //sps = body_points[0]; // spine points
  llps = body_points[2]; // left leg points
  rlps = body_points[3]; // right leg points
  laps = body_points[4]; // left arm points
  raps = body_points[5]; // right arm points
  z = body_points[6]; // start point altitude

  d = diameter > 0 ? diameter : hh / 4;

  //function to_ground(p) =
  //  [ p.x, p.y, -z ];

  hull() {

    _bal(llps[0], d);
    _bal(llps[1], d);
    _bal(llps[2], d);
      _bal(llps[3], d);
    _bal(rlps[0], d);
    _bal(rlps[1], d);
    _bal(rlps[2], d);
      _bal(rlps[3], d);

    //_bal(to_ground(laps[1]), d);
    //_bal(to_ground(laps[2]), d);
    //_bal(to_ground(raps[1]), d);
    //_bal(to_ground(raps[2]), d);

    _bal(laps[0], d);
    _bal(laps[1], d);
    _bal(laps[2], d);
    _bal(laps[3], d);
    _bal(raps[0], d);
    _bal(raps[1], d);
    _bal(raps[2], d);
    _bal(raps[3], d);
  }
}

module skirt(
  body_points,
  lratio=0.5,
  rratio=0.5,
  topd=0,
  bottomd=0
) {

  bps = body_points;

  lt = bpoint(bps, "left hip");
  rt = bpoint(bps, "right hip");

  lk = bpoint(bps, "left knee");
  rk = bpoint(bps, "right knee");

  hh = bpoint(bps, "head height");

  lb = _midpoint(lt, lk, lratio);
  rb = _midpoint(rt, rk, rratio);

  td = topd > 0 ? topd : hh * 0.28;
  bd = bottomd > 0 ? bottomd : hh * 0.6;

  hull() {
    _bal(lt, td);
    _bal(rt, td);
    translate(lb) cylinder(d=bd, h=0.01);
    translate(rb) cylinder(d=bd, h=0.01);
  }
}

module skull(body_points) {

  hp = body_points[0][4]; // head point
  hh = body_points[7]; // head height

  difference() {
    union() {
      translate([ hp.x, hp.y + hh / 10, hp.z - hh / 3 ])
        cylinder(d=hh/1.3, h=hh/3, center=true);
      translate([ 0, 0, hh / 7 ])
        scale([ 0.8, 1, 1 ])
          _bal(hp, hh * 0.6); // head
    }
    translate([ - hh / 3.7, hh / 2.1, hh / 7 ])
      _bal(hp, hh * 0.16); // eyesocket
    translate([ hh / 3.7, hh / 2.1, hh / 7 ])
      _bal(hp, hh * 0.16); // eyesocket
  }
}

module head(body_points) {

  h = bpoint(body_points, "head");
  hh = bpoint(body_points, "head height");

  d = hh * 0.6;

  hull() {
    scale([ 0.8, 1, 1 ]) _bal(h, d);
    translate([ 0, 0, hh * 0.2 ]) scale([ 0.8, 1, 1 ]) _bal(h, d);
  }
}

module ear(length, diameter) {

  l = length;
  d = diameter;

  difference() {
    hull() {
      sphere(d=d);
      translate([ 0, 0, length ]) sphere(d=0.1);
    }
    translate([ d * 0.5, 0, d ])
      cube([ l * 0.5, l * 1.5, l * 2 ], center=true);
  }
};

module cap(body_points) {

  h = bpoint(body_points, "head");
  hh = bpoint(body_points, "head height");
  r = hh * 0.64;

  translate(h + [ 0, 0, hh * 0.4 ])
    rotate([ 10, 0, 0 ])
      scale([ 0.8, 1, 1 ])
        dome(r, trunk_height=hh * 0.05);
}

module pointy_cap(body_points) {

  h = bpoint(body_points, "head");
  hh = bpoint(body_points, "head height");

  r1 = hh * 0.6;

  translate(h + [ 0, hh * -0.07, hh * 0.4 ])
    rotate([ 30, 10, 0 ]) union() {
      cylinder(h=hh * 0.2, r=r1);
      translate([ 0, 0, hh * 0.2 ])
        cylinder(h=hh * 0.4, r1=r1, r2=0);
    }
}

module phrygian_cap(body_points, drift=-0.7, rotation=[ 10, 0, 0 ]) {

  ro = rotation;
  h = bpoint(body_points, "head");
  hh = bpoint(body_points, "head height");
  r = hh * 0.64;
  rh = 0.2; // ring height

  r0 = r;         h0 = hh * 0.28;      d0 = [ 0, 0, h0 ];
  r1 = r * 1.0;   h1 = h0 + r * 0.3;   d1 = [ 0, -0.3, h1 ];
  r2 = r * 0.73;  h2 = h1 + r * 0.3;   d2 = [ 0, -0.6, h2 ];
  r3 = 0.6;       h3 = h2 + r * 0.21;  d3 = [ drift, 2, h3 ];

  ro2 = [ -21, 0, 0 ];
    // cylinder before final sphere has a differentation rotation

  scale([ 0.8, 1, 1 ]) {
    hull() {
      translate(h + d0) rotate(ro) cylinder(r=r0, h=rh);
      translate(h + d1) rotate(ro) cylinder(r=r1, h=rh);
    }
    hull() {
      translate(h + d1) rotate(ro) cylinder(r=r1, h=rh);
      translate(h + d2) rotate(ro + ro2) cylinder(r=r2, h=rh);
    }
    hull() {
      translate(h + d2) rotate(ro + ro2) cylinder(r=r2, h=rh);
      translate(h + d3) rotate(ro) sphere(r=r3);
    }
  }
}

module veil(
  body_points,
  thickness=0
) {

  hp = body_points[0][4]; // head point
  hh = body_points[7]; // head height

  t = thickness > 0 ? thickness : hh / 7;

  sd = hh * 0.2; // shoulder diameter
  sw = hh / 3; // shoulder width

  difference() {

    hull() {
      translate([ 0, 0, hh / 7 ]) scale([ 0.8, 1, 1 ]) _bal(hp, hh * 0.6 + t);
      translate([ -sw, 0, -2 * hh ]) _bal(hp, sd + t);
      translate([ sw, 0, -2 * hh ]) _bal(hp, sd + t);
    }
    union() {
      hull() {
        translate([ 0, 0, hh / 7 ]) scale([ 0.8, 1, 1 ]) _bal(hp, hh * 0.6);
        translate([ 0, 0, hh / 7 ]) scale([ 0.8, 1, 1 ]) _bal(hp, hh * 0.6);
        translate([ -sw, 0, -2 * hh ]) _bal(hp, sd);
        translate([ sw, 0, -2 * hh ]) _bal(hp, sd);
      }
      translate([ 0, hh / 2, hp.z - hh ])
        cube([ hh / 1.4, hh, 3 * hh ], center=true);
    }
  }
}

module sling_bag(body_points) {

  rc0 = 2;
  rc1 = 2;
  ch = 0.5;
  cd = 6;

  hh = bpoint(body_points, "head height");

  nb = bpoint(body_points, "neck base");
  ls = bpoint(body_points, "left shoulder");
  sp = _midpoint(nb, ls, 0.5); // shoulder point
  //translate(sp) color("blue", 0.6) sphere(r=2);

  rh = bpoint(body_points, "right hip") + [ 0, 0, hh * 0.4 ];
  //translate(rh) color("blue", 0.6) sphere(r=2);

  r0 = hh * 0.2;
  r1 = hh * 0.5;
  bdy = -hh * 0.2;
  hull() { // front
    translate(sp + [ 0, 0.7, 0.7 ]) sphere(r=r0);
    translate(rh + [ 0.5, 0.7, 0.9 ]) sphere(r=r0);
  }
  hull() { // bag
    translate(sp + [ 0, bdy, 0 ]) sphere(r=r1);
    translate(rh + [ 0, bdy, hh * 0.4 ]) sphere(r=r1);
  }
  hull() {
    translate(sp + [ 0, 0.7, 0.7 ]) sphere(r=r0);
    translate(sp + [ 0, bdy, 0 ]) sphere(r=r1);
  }
  hull() {
    translate(rh + [ 0.5, 0.7, 0.9 ]) sphere(r=r0);
    translate(rh + [ 0, bdy, hh * 0.4 ]) sphere(r=r1);
  }

  //#translate(body_points[5][0]) sphere(r=3);

  //translate([ 0, 0, ls.z * 0.77 ])
  //  rotate([ 0, 50, 0 ])
  //    hull() {
  //      translate([ -cd / 2, 0, 0 ]) cylinder(r=rc0, h=ch);
  //      translate([ cd / 2, 0, 0 ]) cylinder(r=rc1, h=ch);
  //    }
}

/*
translate([ 30, 0, 0 ]) {
  $fn = 24;

  height = 33;

  bps = body_points(
    height,
    to_hip=90,
    to_left_knee=-80,
    to_right_knee=-95,
    to_right_ankle=-95,
    to_left_toe=[ 0, 10 ],
    to_right_toe=[ 0, -10 ],
    to_left_wrist=-75,
    to_left_finger=-70,
    to_right_elbow=[ -70, 90 ],
    to_right_wrist=[ -70, -60 ],
    to_right_finger=[ 0, -90 ]
  );
  echo(bps);

  d = [ 0, 0, bps[6] ];

  #base();

  //echo(concat("spine points", bps[0]));
  for (sp = bps[0]) translate(d + sp) sphere(0.7);

  //echo(concat("waist points", bps[1]));
  for (wp = bps[1]) translate(d + wp) sphere(0.6);

  //echo(concat("left leg points", bps[2]));
  for (llp = bps[2]) translate(d + llp) color("blue", 0.6) sphere(0.5);

  ////echo(concat("right leg points", bps[3]));
  for (rlp = bps[3]) translate(d + rlp) color("red", 0.6) sphere(0.5);

  ////echo(concat("left arm points", bps[4]));
  for (lap = bps[4]) translate(d + lap) color("red", 0.6) sphere(0.5);

  //echo(concat("right arm points", bps[5]));
  for (rap = bps[5]) translate(d + rap) color("blue", 0.6) sphere(0.5);
}
*/

