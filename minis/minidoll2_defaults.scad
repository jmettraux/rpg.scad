
//
// minidoll2_defaults.scad
//


//
// points

default_humanoid_body_points = [

  [ "height", 33 ],
  [ "head height ratio", 1 / 8 ], // to compute head height

  [ "side hip ratio", 0.5 ], // from now on, ratios are head height based
  [ "knee ratio", 2 ],
  [ "ankle ratio", 2 ],
  [ "ball ratio", 0.4 ],
  [ "toe ratio", 0.3 ],

  [ "side waist ratio", 0.56 ],

    // origin to waist : 1
    // waist to back : 1
    // back to neck : 1
  [ "waist ratio", 1 ],
  [ "back ratio", 1 ],
  [ "shoulder ratio", 0.5 ],
  [ "neck ratio", 0.4 ],
  [ "head ratio", 0.42 ],

  [ "side shoulder ratio", 1.1 ],
  [ "elbow ratio", 1.5 ],
  [ "wrist ratio", 1 ],
  [ "hand ratio", 0.5 ],

    // relative points
  [ "l hip",        0,  90, "side hip ratio", "origin" ],
  [ "l knee",     -90,   0, "knee ratio", "l hip" ],
  [ "l ankle",    -90,   0, "ankle ratio", "l knee" ],
  [ "l ball",       0,   0, "ball ratio", "l ankle" ],
  [ "l toe",        0,   0, "toe ratio", "l ball" ],

  [ "r hip",        0, -90, "side hip ratio", "origin" ],
  [ "r knee",     -90,   0, "knee ratio", "r hip" ],
  [ "r ankle",    -90,   0, "ankle ratio", "r knee" ],
  [ "r ball",       0,   0, "ball ratio", "r ankle" ],
  [ "r toe",        0,   0, "toe ratio", "r ball" ],

  [ "waist",       90,   0, "waist ratio", "origin" ],
  [ "back",        90,   0, "back ratio", "waist" ],
  [ "shoulder",    90,   0, "shoulder ratio", "back" ],
  [ "neck",        90,   0, "neck ratio", "shoulder" ],
  [ "head",        90,   0, "head ratio", "neck" ],

  [ "l waist",      0,  90, "side waist ratio", "waist" ],
  [ "r waist",      0, -90, "side waist ratio", "waist" ],

  [ "l shoulder",   0,  90, "side shoulder ratio", "shoulder" ],
  [ "l elbow",    -90,   0, "elbow ratio", "l shoulder" ],
  [ "l wrist",    -90,   0, "wrist ratio", "l elbow" ],
  [ "l hand",     -90,   0, "hand ratio", "l wrist" ],

  [ "r shoulder",   0, -90, "side shoulder ratio", "shoulder" ],
  [ "r elbow",    -90,   0, "elbow ratio", "r shoulder" ],
  [ "r wrist",    -90,   0, "wrist ratio", "r elbow" ],
  [ "r hand",     -90,   0, "hand ratio", "r wrist" ],


    // line points
  [ "r thigh", "r knee", 0.4 ], // 0.4 between "r knee" and its parent "r hip"
  [ "l thigh", "l knee", 0.4 ], // ...

    // mid points
  [ "r chop", "r waist", "r shoulder", 0.5 ], // right between rwai and rsho...
  [ "l chop", "l waist", "l shoulder", 0.5 ],

    // cross points
  [ "sternum", "back", 0.25, "back", [ "l shoulder", "r shoulder" ] ],

  //[ "r x", 0, 0, 2.5, "r thigh" ], literal ratio
];

quadruped_body_points = [

  [ "height", 42 ],
  [ "head height ratio", 1 / 7 ], // to compute head height

  [ "side hip ratio", 1.2 ], // from now on, ratios are head height based
  [ "knee ratio", 2 ],
  [ "ankle ratio", 2 ],
  [ "ball ratio", 1.4 ],
  [ "toe ratio", 0.9 ],

  [ "side waist ratio", 0.56 ],

    // origin to waist : 1
    // waist to back : 1
    // back to neck : 1
  [ "waist ratio", 2 ],
  [ "back ratio", 2 ],
  [ "shoulder ratio", 1 ],
  [ "neck ratio", 1 ],
  [ "head ratio", 1 ],

  [ "side shoulder ratio", 1.3 ],
  [ "elbow ratio", 1.7 ],
  [ "wrist ratio", 1.4 ],
  [ "hand ratio", 1 ],

    // relative points

  [ "l waist",      0,  90, "side waist ratio", "waist" ],
  [ "r waist",      0, -90, "side waist ratio", "waist" ],
  [ "l back",       0,  90, "side back ratio", "back" ],
  [ "r back",       0, -90, "side back ratio", "back" ],

  [ "l hip",        0,  90, "side hip ratio", "origin" ],
  [ "l knee",     -20,   0, "knee ratio", "l hip" ],
  [ "l ankle",   -160,   0, "ankle ratio", "l knee" ],
  [ "l ball",     -90,   0, "ball ratio", "l ankle" ],
  [ "l toe",      -30,   0, "toe ratio", "l ball" ],

  [ "r hip",        0, -90, "side hip ratio", "origin" ],
  [ "r knee",     -20,   0, "knee ratio", "r hip" ],
  [ "r ankle",   -160,   0, "ankle ratio", "r knee" ],
  [ "r ball",     -90,   0, "ball ratio", "r ankle" ],
  [ "r toe",      -30,   0, "toe ratio", "r ball" ],

  [ "waist",        0,   0, "waist ratio", "origin" ],
  [ "back",         0,   0, "back ratio", "waist" ],
  [ "shoulder",     0,   0, "shoulder ratio", "back" ],
  [ "neck",         0,   0, "neck ratio", "shoulder" ],
  [ "head",         0,   0, "head ratio", "neck" ],

  //[ "l waist",      0,  90, "side waist ratio", "waist" ],
  //[ "r waist",      0, -90, "side waist ratio", "waist" ],

  [ "l shoulder",   0,  90, "side shoulder ratio", "shoulder" ],
  [ "l elbow",    -90,   0, "elbow ratio", "l shoulder" ],
  [ "l wrist",    -45,   0, "wrist ratio", "l elbow" ],
  [ "l hand",     -30,   0, "hand ratio", "l wrist" ],

  [ "r shoulder",   0, -90, "side shoulder ratio", "shoulder" ],
  [ "r elbow",    -90,   0, "elbow ratio", "r shoulder" ],
  [ "r wrist",    -45,   0, "wrist ratio", "r elbow" ],
  [ "r hand",     -30,   0, "hand ratio", "r wrist" ],


    // line points
  //[ "r thigh", "r knee", 0.4 ], // 0.4 between "r knee" and its parent "r hip"
  //[ "l thigh", "l knee", 0.4 ], // ...
  //  // mid points
  //[ "r chop", "r waist", "r shoulder", 0.5 ], // right btwn rwai and rsho...
  //[ "l chop", "l waist", "l shoulder", 0.5 ],
  //  // cross points
  //[ "sternum", "back", 0.25, "back", [ "l shoulder", "r shoulder" ] ],
    ];

tail_4_points = [
  //[ "tail 0 ratio", 2 ],
  [ "tail 0", -180, 0, "tail 0 ratio", "origin" ],
  [ "tail 1", -180, 0, "tail 1 ratio", "tail 0" ],
  [ "tail 2", -180, 0, "tail 2 ratio", "tail 1" ],
  [ "tail 3", -180, 0, "tail 3 ratio", "tail 2" ],
    ];

tail_2_points = [
  [ "tail 0 ratio", 3 ],
  [ "tail 1 ratio", 2 ],
  [ "tail 0", -180, 0, "tail 0 ratio", "origin" ],
  [ "tail 1", -180, 0, "tail 1 ratio", "tail 0" ],
    ];

  // not for humans though...
  //
default_head_points = [

  [ "height", 33 ],
  [ "head height ratio", 1 / 8 ], // to compute head height

  [ "front jaw ratio", 1 / 2 ],
  [ "center jaw ratio", 2 / 3 ],
  [ "back jaw ratio", 2 / 3 ],

  [ "front ratio", 1 / 1 ],
  [ "orbit ratio", 1 / 2 ],
  [ "cheek ratio", 1 / 3 ],
  [ "nose ratio", 1 / 2 ],
  [ "tip ratio", 1 / 2 ],

  [ "occipital ratio", 1 / 3 ],

  [ "side front jaw ratio", 1 / 4 ],
  [ "side center jaw ratio", 1 / 3 ],
  [ "side back jaw ratio", 1 / 3 ],

  [ "side front ratio", 1 / 2 ],
  [ "side orbit ratio", 1 / 2 ],
  [ "side cheek ratio", 0.6 ],
  [ "side nose ratio", 1 / 2 ],
  [ "side tip ratio", 1 / 4 ],

  [ "side occipital ratio", 1 / 3 ],

  [ "front jaw", 0, 0, "front jaw ratio", "center jaw" ],
  [ "center jaw", 0, 0, "center jaw ratio", "back jaw" ],
  [ "back jaw", 0, 0, "back jaw ratio", "origin" ],

  [ "front", 60, 0, "front ratio", "origin" ],
  [ "orbit", -10, 0, "orbit ratio", "front" ],
  [ "cheek", -90, 0, "cheek ratio", "orbit" ],
  [ "nose", -30, 0, "nose ratio", "orbit" ],
  [ "tip", -10, 0, "tip ratio", "nose" ],

  [ "occipital", 180 - 80, 0, "occipital ratio", "origin" ],

  [ "l front jaw", 0,  90, "side front jaw ratio", "front jaw" ],
  [ "r front jaw", 0, -90, "side front jaw ratio", "front jaw" ],
  [ "l center jaw", 0,  90, "side center jaw ratio", "center jaw" ],
  [ "r center jaw", 0, -90, "side center jaw ratio", "center jaw" ],
  [ "l back jaw", 0,  90, "side back jaw ratio", "back jaw" ],
  [ "r back jaw", 0, -90, "side back jaw ratio", "back jaw" ],

  [ "l top jaw", "l back jaw", "l front", 0.5 ],
  [ "r top jaw", "r back jaw", "r front", 0.5 ],

  [ "l front", 0,  90, "side front ratio", "front" ],
  [ "r front", 0, -90, "side front ratio", "front" ],
  [ "l orbit", 0,  90, "side orbit ratio", "orbit" ],
  [ "r orbit", 0, -90, "side orbit ratio", "orbit" ],
  [ "l cheek", 0,  90, "side cheek ratio", "cheek" ],
  [ "r cheek", 0, -90, "side cheek ratio", "cheek" ],
  [ "l nose", 0,  90, "side nose ratio", "nose" ],
  [ "r nose", 0, -90, "side nose ratio", "nose" ],
  [ "l tip", 0,  90, "side tip ratio", "tip" ],
  [ "r tip", 0, -90, "side tip ratio", "tip" ],

  [ "l occipital", 0,  90, "side occipital ratio", "occipital" ],
  [ "r occipital", 0, -90, "side occipital ratio", "occipital" ],
    ];

default_head_hulls = [

  [ "back",
    [ "l back jaw" ], [ "r back jaw" ],
    [ "l occipital" ], [ "r occipital" ],
    [ "l front" ], [ "r front" ] ],
  [ "middle",
    [ "l front" ], [ "r front" ],
    [ "l top jaw" ], [ "r top jaw" ],
    [ "l orbit" ], [ "r orbit" ],
    [ "l cheek" ], [ "r cheek" ],
    [ "l nose" ], [ "r nose" ], ],
  [ "nose",
    [ "l nose" ], [ "r nose" ],
    [ "l tip" ], [ "r tip" ] ],
  [ "front tongue",
    [ "l front jaw" ], [ "r front jaw" ],
    [ "l center jaw" ], [ "r center jaw" ],
    [ "nose" ], [ "orbit" ], [ "front" ],
    [ "l back jaw" ], [ "r back jaw" ] ],
      ];


//
// hulls

default_spine_hulls = [

  //[ "neck diameter", 3 ],
  //[ "spine1 diameter", 3 ],

  [ "spine0", [ "origin" ], [ "waist" ] ],
  [ "spine1", [ "waist" ], [ "back" ] ],
  [ "spine2", [ "back" ], [ "shoulder" ] ],
  [ "spine3", [ "shoulder" ], [ "neck" ] ],
  [ "spine4", [ "neck" ], [ "head" ] ],

  [ "l basin", [ "l hip" ], [ "origin" ] ],
  [ "r basin", [ "r hip" ], [ "origin" ] ],

  [ "l shoulder", [ "l shoulder", ], [ "shoulder" ] ],
  [ "r shoulder", [ "r shoulder" ], [ "shoulder" ] ],
    ];

default_leg_hulls = [

    [ "l thigh",
      [ "l hip", "leg diameter" ],
      //[ "l thigh", "thigh diameter" ],
      [ "l knee", "knee diameter" ] ],
    [ "l shin",
      [ "l knee", "knee diameter" ],
      [ "l ankle", "ankle diameter" ] ],
    [ "l palm",
      [ "l ankle", "ankle diameter" ],
      [ "l ball", "ball diameter" ] ],
    [ "l toe",
      [ "l ball", "ball diameter" ],
      [ "l toe", "toe diameter" ] ],

    [ "r thigh",
      [ "r hip", "leg diameter" ],
      //[ "r thigh", "thigh diameter" ],
      [ "r knee", "knee diameter" ] ],
    [ "r shin",
      [ "r knee", "knee diameter" ],
      [ "r ankle", "ankle diameter" ] ],
    [ "r palm",
      [ "r ankle", "ankle diameter" ],
      [ "r ball", "ball diameter" ] ],
    [ "r toe",
      [ "r ball", "ball diameter" ],
      [ "r toe", "toe diameter" ] ],
  ];

default_arm_hulls = [

    [ "l arm",
      [ "l shoulder", "shoulder diameter" ],
      [ "l elbow", "elbow diameter" ] ],
    [ "l forearm",
      [ "l elbow", "elbow diameter" ],
      [ "l wrist", "wrist diameter" ] ],
    [ "l hand",
      [ "l wrist", "wrist diameter" ],
      [ "l hand", "hand diameter" ] ],

    [ "r arm",
      [ "r shoulder", "shoulder diameter" ],
      [ "r elbow", "elbow diameter" ] ],
    [ "r forearm",
      [ "r elbow", "elbow diameter" ],
      [ "r wrist", "wrist diameter" ] ],
    [ "r hand",
      [ "r wrist", "wrist diameter" ],
      [ "r hand", "hand diameter" ] ],
  ];

default_humanoid_body_hulls = concat([

    // diameters

    [ "knee diameter", 1 ],
    [ "leg diameter", 1.2 ],
    [ "thigh diameter", 1.4 ],
    [ "hip diameter", 1.2 ],
    [ "shoulder diameter", 1.3 ],
    [ "neck diameter", 1.1 ],
    [ "tail diameter", 1.2 ],
    [ "tail end diameter", 0.2 ],

    // hulls

    [ "l thigh",
      [ "l hip", "leg diameter" ],
      [ "l thigh", "thigh diameter" ],
      [ "l knee", "knee diameter" ] ],
    [ "l shin",
      [ "l knee", "knee diameter" ],
      [ "l ankle", "ankle diameter" ] ],
    [ "l palm",
      [ "l ankle", "ankle diameter" ],
      [ "l ball", "ball diameter" ] ],
    [ "l toe",
      [ "l ball", "ball diameter" ],
      [ "l toe", "toe diameter" ] ],

    [ "r thigh",
      [ "r hip", "leg diameter" ],
      [ "r thigh", "thigh diameter" ],
      [ "r knee", "knee diameter" ] ],
    [ "r shin",
      [ "r knee", "knee diameter" ],
      [ "r ankle", "ankle diameter" ] ],
    [ "r palm",
      [ "r ankle", "ankle diameter" ],
      [ "r ball", "ball diameter" ] ],
    [ "r toe",
      [ "r ball", "ball diameter" ],
      [ "r toe", "toe diameter" ] ],

    [ "basin",
      [ "l hip", "hip diameter" ],
      [ "r hip", "hip diameter" ],
      [ "l waist", "waist diameter" ],
      [ "r waist", "waist diameter" ] ],
    [ "torso",
      [ "l waist", "waist diameter" ],
      [ "r waist", "waist diameter" ],
      [ "l shoulder", "shoulder diameter" ],
      [ "r shoulder", "shoulder diameter" ],
      [ "sternum", "neck diameter" ],
      [ "shoulder", "neck diameter" ],
      [ "neck", "neck diameter" ] ],

    [ "neck",
      [ "neck", "neck diameter" ],
      [ "head", "neck diameter" ] ],
  ],
  default_arm_hulls);

