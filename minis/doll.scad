
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
    hh = height / 8, // head height
    bw2 = hh * basin_ratio / 2, // basin width / 2
    sw2 = hh * shoulder_ratio / 2 // shoulder width / 2
  ) [
    [
      [ 0, 0, 0 ],
      [ 0, 0, hh ],
      [ 0, 0, 2 * hh ],
      [ 0, 0, 3 * hh ],
      [ 0, 0, 3.25 * hh ]
    ], // spine points
    [], // left leg points
    [], // right leg points
    [], // left arm points
    [], // right arm points
    [ "hh", hh, "bw2", bw2, "sw2", sw2 ] // debug
  ];

echo("=======================================================================");
bps = body_points(33, 3, 3.1);
echo(bps);
sps = bps[0];
for (sp = sps) translate(sp) sphere(0.5);

