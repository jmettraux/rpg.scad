
//
// doll.scad
//

//include <minis_core.scad>;
  // so that vars in minis_core.scad are brought in
//include <minis_shields.scad>;
//include <minis_weapons.scad>;

$fn = 24;

//#base();

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
    hh = height / 8, // head_height
    bw2 = hh * basin_ratio / 2, // basin_width / 2
    sw2 = hh * shoulder_ratio / 2 // shoulder_width / 2
  )
    [ hh, bw2, sw2 ];

echo("=======================================================================");
echo(body_points(33, 3, 3.1));

