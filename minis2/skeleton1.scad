
//
// skeleton1.scad
//

include <doll2.scad>;
include <weapons.scad>;


module skull(body_points) {

  hp = bpoint(body_points, "head"); // head point
  hh = _bpoint_hh(body_points); // head height

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


#base(text="", $fn=12);

//$fn=12;

  //[ "r thigh", "r knee", 0.4 ], // 0.4 between "r knee" and its parent "r hip"
  //[ "l thigh", "l knee", 0.4 ], // ...
  //[ "sternum", "back", 0.25, "back", [ "l shoulder", "r shoulder" ] ],
bps = make_humanoid_body_points([
  [ "knee ratio", 2 ],
  [ "hand ratio", 0.5 ],

  [ "l knee", -86 ],
  [ "l ankle", -105 ],

  [ "r knee", -70, -25 ],
  [ "r ankle", -110, 14 ],
  [ "r ball", -30, 0 ],

  [ "l elbow", -100, 0 ],
  [ "l wrist", -15, 0 ],
  [ "l hand", 0, -90 ],

  //[ "l shoulder", 0, 0 ],
  //[ "r shoulder", 0, 0 ],

  [ "l waist", 90, 90, 0.3, "l hip" ],
  [ "r waist", 90, 90, 0.3, "r hip" ],

  [ "l chop", 85, 90, 0.8, "l waist", "!" ], // <-- "!" enforces OVERWRITE...
  [ "r chop", 95, 90, 0.8, "r waist", "!" ],

  [ "l thorax", 85, 90, 1.4, "l chop" ],
  [ "r thorax", 95, 90, 1.4, "r chop" ],
    ]);
//enumerate_points(bps);

//move_z(bps) draw_points(bps);

hs = make_humanoid_body_hulls([
  [ "neck diameter", 0.9 ],
  [ "knee diameter", 1.2 ],
  [ "leg diameter", 1.2 ],
  [ "thigh diameter", 1.0 ],
  [ "hip diameter", 1.0 ],
  [ "waist diameter", 1.0 ],
  [ "shoulder diameter", 1.0 ],
  [ "column diameter", 1.2 ],
  [ "ankle diameter", 1.0 ],
  [ "ball diameter", 1.0 ],
  [ "toe diameter", 1.0 ],

  [ "column 1",
    [ "origin", "column diameter" ],
    [ "waist", "column diameter" ] ],
  [ "column 2",
    [ "waist", "column diameter" ],
    [ "back", "column diameter" ] ],
  [ "column 3",
    [ "shoulder", "column diameter" ],
    [ "neck", "column diameter" ] ],

  [ "l link",
    [ "l thorax", "column diameter" ],
    [ "l shoulder", "column diameter" ] ],
  [ "r link",
    [ "r thorax", "column diameter" ],
    [ "r shoulder", "column diameter" ] ],

  [ "l forearm",
    [ "l elbow", "elbow diameter" ],
    [ "l wrist", "wrist diameter" ] ],

  [ "l knee", [ "l knee", 1.1 ] ],
  [ "r knee", [ "r knee", 1.1 ] ],
  [ "l elbow", [ "l elbow", 0.9 ] ],
  [ "r elbow", [ "r elbow", 0.9 ] ],

  [ "torso", "?" ], // <-- which removes the "torso" hull...
  [ "torso hi",
    [ "l chop", "waist diameter" ],
    [ "r chop", "waist diameter" ],
    [ "sternum", "waist diameter" ],
    [ "l thorax", "shoulder diameter" ],
    [ "r thorax", "shoulder diameter" ] ],

  //[ "basin",
  //  [ "l hip", "hip diameter" ],
  //  [ "r hip", "hip diameter" ],
  //  [ "l waist", "waist diameter" ],
  //  [ "r waist", "waist diameter" ] ],

  //[ "torso",
  //  [ "l waist", "waist diameter" ],
  //  [ "r waist", "waist diameter" ],
  //  [ "l chop", "waist diameter" ],
  //  [ "r chop", "waist diameter" ],
  //  [ "l shoulder", "shoulder diameter" ],
  //  [ "r shoulder", "shoulder diameter" ],
  //  //[ "sternum", "neck diameter" ],
  //  [ "shoulder", "neck diameter" ],
  //  [ "neck", "neck diameter" ]
  //    ],
      ]);

hh = _bpoint_hh(bps);

supported()
  move_z(bps) {

    draw_hulls(bps, hs);

    translate([ 0, 1, 0 ]) rotate([ 3, 0, 0 ]) skull(bps);

    translate([ 4.5, 1.4, -3.7 ])
      rotate([ 0, 155, 90 ])
        long_sword(hh * 4.2, hh * 0.6); // long sword

    translate([ -3, 3.1, 3.9 ])
      rotate([ 0, -10, 0 ])
        tear_shield(hh * 4.9, hh * 2.8);

    //support(bps, "origin");
    //translate([ 0, 1.3, 0 ]) support(bps, "head", maxlen=6);

    support(bps, "l elbow");

    translate([ 0.5, 0, 0 ]) support(bps, "l chop", maxlen=5);
    translate([ -0.5, 0, 0 ]) support(bps, "r chop", maxlen=5);
  }

