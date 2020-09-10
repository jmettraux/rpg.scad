
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
  basin_width,
  shoulder_width,
  spine_vectors=[],
  left_leg_vectors=[],
  right_leg_vectors=[],
  left_arm_vectors=[],
  right_arm_vectors=[]
) =
  let(
    head_height = height / 8
  )
    head_height;

echo("=======================================================================");
echo(body_points(33));

