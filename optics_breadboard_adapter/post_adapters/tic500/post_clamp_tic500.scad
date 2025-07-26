// board mount for tic500; connects to post_clamp_adapter

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;
inch = 25.4;

// tic500 board params
bw = 1.5*inch - 5.1 - 2.5;  // board width
bh = 1.05*inch - 5.0;  // board height

wall = 2.5;  // wall thickness
screw_board = "#2";
screw_conn = "#4";

mw = bw + 0.6*inch;
mh = bh + 0.6*inch;
echo(screw_info("#2"));
echo(screw_info("#4"));

module roundedRect(size, radius) {
  x = size[0];
  y = size[1];  // what was I thinking again??

  z = size[2];
  linear_extrude(height=z)
  hull() {
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+radius, (-y/2)+radius, 0])
    circle(r=radius);
    translate([(x/2)-radius, (-y/2)+radius, 0])
    circle(r=radius);
    translate([(-x/2) + radius, (y/2)-radius, 0])
    circle(r=radius);
    translate([(x/2)-radius, (y/2)-radius, 0])
    circle(r=radius);
  }
}


module board_hole(position) {
  // countersunk
  union() {
    translate(position)
    up(wall)
    screw_hole(screw_board, l=wall+0.1, head="flat", anchor=TOP, tolerance="medium");
  }
}


module post_clamp_hole(){
    up(wall)
    screw_hole(screw_conn, l=wall+0.1, anchor=TOP) 
    position(BOT)
    nut_trap_inline(wall/2, screw_conn);
}


difference(){
  roundedRect([mw, mh, wall], 5);
  // screw holes
  union() {
    // attach post clamp
    left(0.5*inch) post_clamp_hole();
    right(0.5*inch) post_clamp_hole();
    fwd(0.5*inch) post_clamp_hole();
    back(0.5*inch) post_clamp_hole();
    // attach board
    board_hole([bw/2, bh/2, 0]);
    board_hole([bw/2, -bh/2, 0]);
    board_hole([-bw/2, bh/2, 0]);
    board_hole([-bw/2, -bh/2, 0]);
  }
}

