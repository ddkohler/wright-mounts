// adapt camera to a post mount or 30 mm cage mount
// for post mount, requires threaded press insert

$fn=50;
inch=25.4;

cd = 28; // hole diameter for camera
// smount has 21.0 mm diameter
// cmount has 27.8 mm diameter

csm1 = 1.2*inch; // hole diameter for sm1 mount

csq = 24.0; // mounting square dimension for camera
csq_d = 2.2; // hole size for mounting square

post_d = 0.218*inch; // hole diameter for post mount
post_depth = 0.32*inch; 

cage = 30.0; // square dimension for cage
cage_screw = 0.1285*inch; // hole for cage (4-40 screws)

thickness = 0.4*inch;

corners = [[-1,-1],[-1,1],[1,-1],[1,1]];

module roundedRect(size, radius) {
  x = size[0]/2;
  y = size[1]/2;  // what was I thinking again??
  z = size[2];
  linear_extrude(height=z)
  hull() {
    // place 4 circles in the corners, with the given radius
    for (c=corners) {
      translate([c[0]*(x-radius), c[1]*(y-radius), 0])
      circle(r=radius);
    }
  }
}


difference() {
  // positive rectangle
  roundedRect([cage + 0.5*inch, cage + 0.5*inch, thickness], 12);
  // mounting holes
  for (c=corners) {
      translate([c[0]*cage/2, c[1]*cage/2, 0])
      cylinder(thickness, r=cage_screw/2, center=false);
    union(){
      translate([c[0]*csq/2, c[1]*csq/2, 0])
      cylinder(thickness, r=csq_d/2);
      translate([c[0]*csq/2, c[1]*csq/2, 3.2])
      cylinder(thickness, r=2., center=false);
    }
  }
  // negative cutouts
  cylinder(thickness, r=cd/2, center=false);
  for (rot=[0,90,180,270]){
    rotate([0,0,rot])
    translate([(cage+0.5)/2, 0, thickness/2])
    rotate([0,90,0])
    cylinder(post_depth, r=post_d/2, center=false);
  }
}

