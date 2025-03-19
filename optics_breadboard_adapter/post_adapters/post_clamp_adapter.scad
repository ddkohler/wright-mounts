// need BOSL2 libraries
// post mount with screws to mount to another unit

include <BOSL2/std.scad>
include <BOSL2/linear_bearings.scad>
include <BOSL2/screws.scad>


$fn=50;
inch = 25.4;

// post clamp params
d_post = 0.505*inch;  // post diameter
l = 15; // post clamp length

// tic500 board params
bw = 1*inch;  // screws placed 1" apart
mw = bw + 0.5*inch;
mh = l;
screw_id = "#4"; 

md = 0.28*inch;  // mounting hole diameter
bd = 0.09*inch;  // board hole diameter
wall = 2.;  // wall thickness

// echo(screw_info("#4-40", head="flat"));

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

module counterSunk(position, radius) {
  union() {
    translate(position)
    translate([0,0,-0.1])
    union() {
      cylinder(3.2, radius, radius, 8, center=false);
      translate([0,0,0.1])
      cylinder(3.5, 0, 3.5, center=false);
    }
  }
}


union(){
    linear_bearing_housing(
        d=d_post, l=15, wall=wall, tab=8, screwsize=3
    );
    //rotate([0,90,0])
    translate([0, 0, -wall/2])
    rotate(90)
    difference(){
      roundedRect([mw, mh, wall], 5);
      // four table mounting holes
      union() {
        left(bw/2)
        screw_hole(screw_id, length=5, head="flat");
        right(bw/2)
        screw_hole(screw_id, length=5, head="flat");
        //counterSunk([bw/2, 0, 0], bd/2);
        //counterSunk([-bw/2, 0, 0], bd/2);
      }
  }
}

