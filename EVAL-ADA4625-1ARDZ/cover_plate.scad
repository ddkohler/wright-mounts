$fn=50;
inch = 25.4;

// center to center dimensions
mw = 2*inch;  // mounting width
mh = 2*inch;  // mounting width
bw = 43.8;  // board width
bh = 43.8;  // board height

br = 6; // banana plug opening

// hole diameters
md = 0.28*inch;  // mounting hole diameter
bd = 0.15*inch;  // board hole diameter

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
    union() {
      cylinder(3, radius, radius, 8, center=false);
      cylinder(3, 0, 3.5, center=false);
    }
  }
}

// plate itself
difference() {
  // positive rectangle
  roundedRect([mw + 10, mh + 10, 3], 5, center=false);
  // four board holes
  union() {
    counterSunk([bw/2, bh/2, 0], bd/2);
    counterSunk([-bw/2, bh/2, 0], bd/2);
    counterSunk([bw/2, -bh/2, 0], bd/2);
    counterSunk([-bw/2, -bh/2, 0], bd/2);
  }
  // three banana plug holes
  translate([mw/2-16, mh/2-9, 0])
  cylinder(3, br, br, center=false);
  translate([mw/2-17, -mh/2+7, 0])
  cylinder(3, br, br, center=false);
  translate([mw/2-33, -mh/2+7, 0])
  cylinder(3, br, br, center=false);
}
