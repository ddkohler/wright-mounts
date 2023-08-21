// mount ellx controller to an optical breadboard
// recommend 6-32 spacers for controller board, 1/4-20 for breadboard

$fn=50;
inch = 25.4;

// center to center dimensions
mw = 3*inch;  // mounting width
mh = 2*inch;  // mounting width
bw = 57;  // board width
bh = 24;  // board height
bt = 3; // boad thickness

// hole diameters
md = 0.28*inch;  // mounting hole diameter
bd = 0.15*inch;  // board hole diameter

// countersink params
cs_d1 = 0.272*inch; // head diameter (size 6-32)
hh = 0.083*inch;  // head height (size 6-32)

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

module counterSunk(position, radius, radius2, head_height) {
  union() {
    translate(position)
    union() {
      cylinder(3, r1=radius, r2=radius, center=false);
      translate([0, 0, 3-head_height])
      cylinder(head_height, r1=radius, r2=radius2, center=false);
    }
  }
}

// plate itself
difference() {
  // positive rectangle
  roundedRect([mw + 0.5*inch, mh + 0.5*inch, bt], 5);
  // four table mounting holes
  translate([-mw/2, -mh/2, 0])
  cylinder(3, md/2, md/2, center=false);
  translate([-mw/2, mh/2, 0])
  cylinder(3, md/2, md/2, center=false);  
  translate([mw/2, -mh/2, 0])
  cylinder(3, md/2, md/2, center=false);  
  translate([mw/2, mh/2, 0])
  cylinder(3, md/2, md/2, center=false);
  // four board holes
  union() {
    counterSunk([bw/2, bh/2, 0], bd/2, cs_d1/2, hh);
    counterSunk([-bw/2, bh/2, 0], bd/2, cs_d1/2, hh);
    counterSunk([bw/2, -bh/2, 0], bd/2, cs_d1/2, hh);
    counterSunk([-bw/2, -bh/2, 0], bd/2, cs_d1/2, hh);
  }
  // negative cutouts
  linear_extrude(height=5)
  offset(r=3){
    offset(r=-6){
      union(){
        square([mw,bh-0.5*inch], center=true);
        square([bw-0.5*inch,mh], center=true);
      }
    }
  }
}