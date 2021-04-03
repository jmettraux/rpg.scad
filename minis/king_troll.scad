
//
// giant_boar.scad
//

include <minidoll.scad>;


$fn = 24;

height = 40 * 1.4;


bps = body_points(

  height,
  thigh_length_ratio=2.0, // 2
  shin_length_ratio=2.0, // 2
  foot_length_ratio=1.1, // 0.7

  to_low_hip=50,
  to_hip=50,
  to_navel=50,
  to_neck=50,
  to_head=50,

  to_left_knee=[ -40, 14 ],
  to_left_ankle=250,
  to_left_toe=[ 0, 14 ],
    //
  to_right_knee=[ -40, -14 ],
  to_right_ankle=250,
  to_right_toe=[ 0, -14 ],

  to_left_elbow=[ -120, -14 ],
  to_left_wrist=[ -70, 0 ],
  //to_left_finger=[ -60, 0 ],
    //
  to_right_elbow=[ -120, 14 ],
  to_right_wrist=[ -70, 0 ]
  //to_right_finger=[ -60, 0 ]
);
//echo(bps);
hh = bpoint(bps, "head height");


base(diameter=50, text="  KT0", font_size=5, font_spacing=0.95, $fn=12);


module trollHead(body_points, angle=-40) {

  hp = bpoint(body_points, "head");
  hh = bpoint(body_points, "head height") * 0.8;
  //np = _to_point(hh * 2, angle, hp);

  rotate([ 0, 0, 0 ]) union() {
    d = hh * 0.6;

    hull() {
      scale([ 0.8, 1.1, 1 ]) _bal(hp, d);
      translate([ 0, 0, hh * 0.2 ]) scale([ 0.8, 1, 1 ]) _bal(hp, d);
    }
    //cap(bps);
    translate(hp + [ hh * 0.5, 0, hh * 0.2 ]) rotate([ 60, 20, 0 ])
      ear(hh * 1.0, hh * 0.6);
    translate(hp + [ -hh * 0.5, 0, hh * 0.2 ]) rotate([ -60, 20, 180 ])
      ear(hh * 1.0, hh * 0.6);
  }
}

rotate([ 0, 0, 0 ]) {

  translate([ 0, -10, bps[6] ]) {

    body(bps,
      diameter=hh * 0.2,
      buttock_diameter=hh * 0.3,
      ankle_diameter=hh * 0.21,
      foot_diameter=hh * 0.2,
      shoulder_diameter=hh * 0.42,
      wrist_diameter=hh * 0.2,
      palm_diameter=hh * 0.2);

    //rotate([ 0, 0, 40 ]) union() {
    //  trollHead(bps);
    //}
    trollHead(bps);

    //np = bpoint(bps, "neck");
    //hp = bpoint(bps, "head");
    //sps = bpoint(bps, "spine");
      //
    //hull() {
    //  _bal(sps[0] + [ 0, 0, hh * 0.2 ], hh * 0.5);
    //  _bal(np + [ 0, -hh * 0.3, hh * 0.3 ], hh * 0.7);
    //  _bal(hp, hh * 0.5);
    //}
  }
}

