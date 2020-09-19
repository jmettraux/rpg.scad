
//
// doll.scad
//

include <minilib.scad>;


function _lu(dict, key, list, index, default) =
  let(
    dv = _get(dict, key),
    lv = _idx(list, index)
  )
    dv != undef ? dv :
    lv != undef ? lv :
      default;

function _vor(vector, index, default) =
  vector[index] ? vector[index] : default;
    //
    // [], false, 0, and undef are all falsy...

function body_points(
  height,
  spine_vectors=[],
  left_leg_vectors=[],
  right_leg_vectors=[],
  left_arm_vectors=[],
  right_arm_vectors=[],
  basin_ratio=0,
  waist_ratio=0,
  shoulder_ratio=0,
  vectors=[]
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

    vs = vectors,

    hh = height / 8, // head height
    hh2 = hh * 2,
    bw2 = hh * br / 2, // basin width / 2
    sw2 = hh * sr / 2, // shoulder width / 2
    ww2 = hh * wr / 2, // wast width / 2
    fl = hh * 0.7, // foot length
    hl = hh * 0.6, // hand length

    svs = spine_vectors,
    llvs = left_leg_vectors,
    rlvs = right_leg_vectors,
    lavs = left_arm_vectors,
    ravs = right_arm_vectors,

    up = [ 90, 0 ],
    down = [ -90, 0 ],
    left = [ 0, 90 ],
    right = [ 0, -90 ],

    sp0 = [ 0, 0, 0 ],
    sp1 = _to_point(hh, _lu(vs, "to hip", svs, 0, up), sp0),
    sp2 = _to_point(1.5 * hh, _lu(vs, "to navel", svs, 2, up), sp1),
    sp3 = _to_point(0.5 * hh, _lu(vs, "to neck", svs, 3, up), sp2),
    sp4 = _to_point(0.5 * hh, _lu(vs, "to head", svs, 4, up), sp3),
      //
    sp1h = _to_point(0.7 * hh, _lu(vs, "to low hip", svs, 0, up), sp0),
    wal = _to_point(ww2, _lu(vs, "to left hip", llvs, 0, left), sp1h),
    war = _to_point(ww2, _lu(vs, "to right hip", rlvs, 0, right), sp1h),
      // TODO bring back somehow

    llp0 = _to_point(bw2, _lu(vs, "to left hip", llvs, 0, left), sp0),
    llp1 = _to_point(hh2, _lu(vs, "to left knee", llvs, 1, down), llp0),
    llp2 = _to_point(hh2, _lu(vs, "to left ankle", llvs, 2, down), llp1),
    llp3 = _to_point(fl, _lu(vs, "to left toe", llvs, 3, [ 0, 0 ]), llp2),

    rlp0 = _to_point(bw2, _lu(vs, "to right hip", rlvs, 0, right), sp0),
    rlp1 = _to_point(hh2, _lu(vs, "to right knee", rlvs, 1, down), rlp0),
    rlp2 = _to_point(hh2, _lu(vs, "to right ankle", rlvs, 2, down), rlp1),
    rlp3 = _to_point(fl, _lu(vs, "to right toe", rlvs, 3, [ 0, 0 ]), rlp2),


    lap0 = _to_point(sw2, _lu(vs, "to left shoulder", lavs, 0, left), sp2),
    lap1 = _to_point(1.5 * hh, _lu(vs, "to left elbow", lavs, 1, down), lap0),
    lap2 = _to_point(1.3 * hh, _lu(vs, "to left wrist", lavs, 2, down), lap1),
    lap3 = _to_point(hl, _lu(vs, "to left finger", lavs, 3, down), lap2),

    rap0 = _to_point(sw2, _lu(vs, "to right shoulder", ravs, 0, right), sp2),
    rap1 = _to_point(1.5 * hh, _lu(vs, "to right elbow", ravs, 1, down), rap0),
    rap2 = _to_point(1.3 * hh, _lu(vs, "to right wrist", ravs, 2, down), rap1),
    rap3 = _to_point(hl, _lu(vs, "to right finger", ravs, 3, down), rap2),

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
      n == "head height" ? bpoints[7] :
      n == "z" ? bpoints[6] :
        undef
  )
    r == undef ? default : r;

module bal(p, d) {
  translate(p) sphere(d);
};
module hul(p0, d0, p1, d1) {
  hull() { bal(p0, d0); bal(p1, d1); }
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
  palm_diameter=0
) {

  sps = body_points[0]; // spine points
  wps = body_points[1]; // waist points
  llps = body_points[2]; // left leg points
  rlps = body_points[3]; // right leg points
  laps = body_points[4]; // left arm points
  raps = body_points[5]; // right arm points
  z = body_points[6]; // foot to start point (basin) z distance
  hh = body_points[7]; // head height

  d = hh / 4; // default diameter

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

  hul(llps[0], bd, llps[1], kd); // TODO replace buttock
  hul(llps[1], kd, llps[2], ad);
  hul(llps[2], ad, llps[3], fd);
  hul(rlps[0], bd, rlps[1], kd); // TODO replace buttock
  hul(rlps[1], kd, rlps[2], ad);
  hul(rlps[2], ad, rlps[3], fd);

  hul(llps[0], bd, sps[0], bd); // TODO replace buttock
  hul(sps[0], bd, rlps[0], bd); // TODO replace buttock

  hul(sps[0], d, sps[1], d);
  hul(sps[1], d, sps[2], d);
  hul(sps[2], d, sps[3], d);
  hul(sps[3], d, sps[4], d);

  hul(laps[0], sd, sps[2], d);
  hul(sps[2], d, raps[0], sd);

  hul(laps[0], sd, laps[1], ed);
  hul(laps[1], ed, laps[2], wd);
  hul(laps[2], wd, laps[3], pd);
  hul(raps[0], sd, raps[1], ed);
  hul(raps[1], ed, raps[2], wd);
  hul(raps[2], wd, raps[3], pd);

  hull() {
    bal(llps[0], d); bal(rlps[0], d);
    bal(wps[0], d); bal(wps[2], d);
  }
  hull() {
    bal(wps[0], d); bal(wps[2], d);
    bal(laps[0], d); bal(sps[2], d); bal(raps[0], d);
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

    bal(llps[0], d);
    bal(llps[1], d);
    bal(llps[2], d);
      bal(llps[3], d);
    bal(rlps[0], d);
    bal(rlps[1], d);
    bal(rlps[2], d);
      bal(rlps[3], d);

    //bal(to_ground(laps[1]), d);
    //bal(to_ground(laps[2]), d);
    //bal(to_ground(raps[1]), d);
    //bal(to_ground(raps[2]), d);

    bal(laps[0], d);
    bal(laps[1], d);
    bal(laps[2], d);
    bal(laps[3], d);
    bal(raps[0], d);
    bal(raps[1], d);
    bal(raps[2], d);
    bal(raps[3], d);
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
          bal(hp, hh * 0.6); // head
    }
    translate([ - hh / 3.7, hh / 2.1, hh / 7 ])
      bal(hp, hh * 0.16); // eyesocket
    translate([ hh / 3.7, hh / 2.1, hh / 7 ])
      bal(hp, hh * 0.16); // eyesocket
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
      translate([ 0, 0, hh / 7 ]) scale([ 0.8, 1, 1 ]) bal(hp, hh * 0.6 + t);
      translate([ -sw, 0, -2 * hh ]) bal(hp, sd + t);
      translate([ sw, 0, -2 * hh ]) bal(hp, sd + t);
    }
    union() {
      hull() {
        translate([ 0, 0, hh / 7 ]) scale([ 0.8, 1, 1 ]) bal(hp, hh * 0.6);
        translate([ 0, 0, hh / 7 ]) scale([ 0.8, 1, 1 ]) bal(hp, hh * 0.6);
        translate([ -sw, 0, -2 * hh ]) bal(hp, sd);
        translate([ sw, 0, -2 * hh ]) bal(hp, sd);
      }
      translate([ 0, hh / 2, hp.z - hh ])
        cube([ hh / 1.4, hh, 3 * hh ], center=true);
    }
  }
}


echo("======================================================================");


$fn = 24;

bps = body_points(
  33,
  vectors=[
    "to hip", 90,
    "to left knee", -80,
    "to right knee", -95,
    "to right ankle", -95,
    "to left toe", [ 0, 10 ],
    "to right toe", [ 0, -10 ]
  ]
); // right arm vectors
echo(bps);

//d = [ 0, 0, bps[6] ];
//
//#base();
//
////echo(concat("spine points", bps[0]));
//for (sp = bps[0]) translate(d + sp) sphere(0.7);
//
////echo(concat("waist points", bps[1]));
//for (wp = bps[1]) translate(d + wp) sphere(0.6);
//
////echo(concat("left leg points", bps[2]));
//for (llp = bps[2]) translate(d + llp) color("blue", 0.6) sphere(0.5);
//
//////echo(concat("right leg points", bps[3]));
//for (rlp = bps[3]) translate(d + rlp) color("red", 0.6) sphere(0.5);
//
//////echo(concat("left arm points", bps[4]));
//for (lap = bps[4]) translate(d + lap) color("red", 0.6) sphere(0.5);
//
////echo(concat("right arm points", bps[5]));
//for (rap = bps[5]) translate(d + rap) color("blue", 0.6) sphere(0.5);

//echo ("-------------------------------------------------------------------");
//translate(d + sps[3]) color("black") sphere(1);
//echo([ "hh", 33 / 8 ]);
//echo([ "sp3", sps[3] ]);
//echo([ "sp3 spherical", to_spherical(sps[3]) ]);

translate([ -25, 0, 0 ]) {
  base(text=" C", $fn=12);
  translate([ 0, 0, bps[6] ]) {
    body(bps);
    //robe(bps);
    //skirt(bps);
    //veil(bps);
    //skull(bps);
  }
}


//function _get(dict, key, default=undef) =
//  //let (r = search(key, dict)[0]) r == undef ? default : r;
//  search(key, dict)[0]) r == undef ? default : r;
//dict = [ [ "t", [ 90, 0 ] ] ];
//echo(dict);
//echo(_get(dict, "t"));

