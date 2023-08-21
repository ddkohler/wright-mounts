// TODO: add clearance on bottom for cable
// TODO: extra clearance space (~1.5 mm on each side) for board

$fn=50;
inch = 25.4;

// center to center dimensions
mw = 66;  // board width
mh = 82.5;  // board height
bw = 60;  // mounting rect width
bh = 60;  // mounting rect height
ct = 19;  // cover thickness (neglecting wall)
thick = 3; // wall thickness
clearance = 2; // side clearance

// hole diameters
bd = 0.15*inch;  // board hole diameter

module roundedRect(size, offset, radius) {
  x = size[0];
  y = size[1];  // what was I thinking again??
  z = size[2];  
  
  x0 = offset[0];
  y0 = offset[1];
  z0 = offset[2];

  points = [
    [-x/2+radius, -y/2+radius-8.25, 0],
    [x/2-radius, -y/2+radius-8.25, 0],
    [-x/2+radius, y/2-radius-8.25, 0],
    [x/2-radius, y/2-radius-8.25, 0]
  ];

  linear_extrude(height=z)
  hull() {
    // place 4 circles in the corners, with the given radius
    for (p=points){
        translate(p)
        circle(r=radius);
    }
  }
}

module counterSunk(position, radius) {
  union() {
    translate(position)
    union() {
      cylinder(3, radius, radius, center=false);
      cylinder(3, 0, 3.5, center=false);
    }
  }
}

// plate itself
difference() {
  // positive rectangle
  roundedRect([mw + 2*(thick + clearance), mh + 2*thick + clearance, ct + 3], [0, 8.25, 0], 5, center=false);
  // four board holes
  union() {
    counterSunk([bw/2, bh/2, ct], bd/2);
    counterSunk([-bw/2, bh/2, ct], bd/2);
    counterSunk([bw/2, -bh/2, ct], bd/2);
    counterSunk([-bw/2, -bh/2, ct], bd/2);
  }
  // negative cutouts
  linear_extrude(height=ct+3)
  offset(r=3){
    offset(r=-6){      
        circle(r=0.625*inch);
    }
  }
  roundedRect([mw+2*clearance, mh+2*clearance, ct], [0, 8.25, 0], 5, center=false);
}






