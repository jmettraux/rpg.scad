
//
// giant_boar.scad
//

include <minidoll.scad>;


$fn = 24;

height = 33 * 1.4;


bps = body_points(

  height,
  thigh_length_ratio=1.2, // 2
  shin_length_ratio=1.4, // 2
  foot_length_ratio=1.4, // 0.7

  to_low_hip=10,
  to_hip=10,
  to_navel=10,
  to_neck=10,
  to_head=10,

  to_left_knee=-80,
  to_left_ankle=-160,
  to_left_toe=[ -70, 0 ],
  //
  to_right_knee=-80,
  to_right_ankle=-160,
  to_right_toe=[ -70, 0 ],

  to_left_elbow=[ -80, 0 ],
  to_left_wrist=[ -70, 0 ],
  to_left_finger=[ -60, 0 ],
  //
  to_right_elbow=[ -80, 0 ],
  to_right_wrist=[ -70, 0 ],
  to_right_finger=[ -60, 0 ]
);
//echo(bps);
hh = bpoint(bps, "head height");


base(diameter=50, text=" GB0", font_size=5, font_spacing=0.95, $fn=12);


module boarHead(body_points, angle=-40) {

  hp = bpoint(body_points, "head");
  hh = bpoint(body_points, "head height");
  np = _to_point(hh * 2, angle, hp);

  translate([ 0, 0, -hh * 0.2 ]) {

    hull() {
      _bal(hp, 5);
      //_bal(np, hh * 0.42);
      translate(np) rotate([ 60, 0, 0 ]) cylinder(r=hh * 0.28, h = hh * 0.3);
    }

    //translate(hp + [ hh * 0.5, 0, hh * 0.6 ])
    //  rotate([ 100 + 90, 180, 10 ])
    //    ear(hh * 1.2, hh * 0.6);
    //translate(hp + [ -hh * 0.5, 0, hh * 0.6 ])
    //  rotate([ 100, 0, -10 ])
    //    ear(hh * 1.2, hh * 0.6);
  }
}

rotate([ 0, 0, 0 ]) {

  translate([ 0, -9, bps[6] ]) {

    body(bps,
      diameter=hh * 0.6,
      buttock_diameter=hh * 0.7,
      ankle_diameter=hh * 0.3,
      foot_diameter=hh * 0.3,
      shoulder_diameter=hh * 0.8,
      wrist_diameter=hh * 0.3,
      palm_diameter=hh * 0.3);

    //rotate([ 0, 0, 40 ]) union() {
    boarHead(bps);
    //}

    np = bpoint(bps, "neck");
    hp = bpoint(bps, "head");
    sps = bpoint(bps, "spine");

    hull() {
      _bal(sps[0] + [ 0, 0, hh * 0.2 ], hh * 0.5);
      _bal(np + [ 0, -hh * 0.3, hh * 0.3 ], hh * 0.7);
      _bal(hp, hh * 0.5);
    }
  }
}

