include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

inch = 25.4;


module shellWithPorts(barrel, size, radius, thickness=3){
  // barrel plug, usb openings, 1/4" screw slots for breadboard
  difference() {
    shell(size, radius, thickness);        
    translate(barrel) rotate([90,0,0]) cylinder(size[1] / 2 + 0.1, r=8/32 *inch+0.1);
    // just tinker to find the correct usb coordinates
    translate([-23, 0, 15]) rotate([-90, 0,0])
    linear_extrude(size[1]/2 + 0.1) offset(r=4) square([5, 12], center=true);
    translate([size[0]/2-3, 0, barrel[2]]) rotate([0,90,0]) screw_hole("1/4-20,1", counterbore=0, orient=DOWN);
  }
}


module roundedRect(size, radius) {
  x = size[0];
  y = size[1];
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


module shell(size, radius, thickness=3){
  linear_extrude(height=size[2])
  difference(){
    roundedRect(size, radius);
    offset(r=-thickness) roundedRect(size, radius);
  };
}

// shellWithPorts(0, 20, [55, 35, 30], radius=6, thickness=3);
