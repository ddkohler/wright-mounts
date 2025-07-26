// mount tic500 to optical breadboard

$fn=50;
inch = 25.4;

// center to center dimensions
mw = 2*inch;  // mounting width
mh = 1*inch;  // mounting width
bw = 1.5*inch - 5.1 - 2.5;  // board width
bh = 1.05*inch - 5.0;  // board height

// hole diameters
md = 0.28*inch;  // mounting hole diameter
bd = 0.09*inch;  // board hole diameter

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

module place_tic500(pos, rot=0){
    translate(pos)
    color("red", 0.3)
    //flip downward facing
    rotate([180, 0, 0])
    // center board holes and move downward
    translate([-(0.75+0.05)*inch, -0.5025*inch, 0.125 * inch])
    import("tic_t500_crude.stl");
}


// plate itself
difference() {
  // positive rectangle
  roundedRect([mw + 0.5*inch, mh + 0.5*inch, 3], 5, center=false);
  // four table mounting holes
  translate([-mw/2, -mh/2, -0.1])
  cylinder(3.2, md/2, md/2, 8, center=false);
  translate([-mw/2, mh/2, -0.1])
  cylinder(3.2, md/2, md/2, 8, center=false);  
  translate([mw/2, -mh/2, -0.1])
  cylinder(3.2, md/2, md/2, 8, center=false);  
  translate([mw/2, mh/2, -0.1])
  cylinder(3.2, md/2, md/2, 8, center=false);
  // four board holes
  union() {
    counterSunk([bw/2, bh/2, 0], bd/2);
    counterSunk([-bw/2, bh/2, 0], bd/2);
    counterSunk([bw/2, -bh/2, 0], bd/2);
    counterSunk([-bw/2, -bh/2, 0], bd/2);
  }
  // negative cutouts
  translate([0,0,-0.1])
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

place_tic500();