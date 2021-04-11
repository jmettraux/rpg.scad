
$fn=6;

// unit is mm


baldia = 17; // ball diameter
//holdia = 12; // hole diameter

culen = baldia * 1.3; // cube length
cudep = baldia * 0.7; // cube depth
cuhei = baldia * 0.9; // cube height

difference() {
  translate([ 0, 0, cuhei * 0.21 ])
    cube(size=[ culen, cudep, cuhei ], center=true);
  #sphere(d=baldia, $fn=36);
  #translate([ -baldia / 4, 0, -baldia / 4 ])
    cube(size=[ baldia / 2, baldia, baldia / 2 ], center=true);
}

