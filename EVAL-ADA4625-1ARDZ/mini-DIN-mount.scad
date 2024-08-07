$fn=50;
inch = 25.4;

// center to center dimensions
mw = 2*inch + 10;  // mounting width
mh = 2*inch + 10;  // mounting width
bw = 43.8;  // board width
bh = 43.8;  // board height
z = 3; // board thickness

br = [0.8*inch, 1.25*inch, 2];  // bracket size

offset = 5; // offset side to fit din mount

// hole diameters
md = 0.28*inch;  // mounting hole diameter
bd = 0.15*inch;  // board hole diameter

module roundedRect(size, radius) {
  x = size[0];
  y = size[1];
  z = size[2];
  linear_extrude(height=z)
  hull() {
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+radius, (-y/2)+radius, 0])
    circle(r=radius);
    translate([(x/2)-radius+offset, (-y/2)+radius, 0])
    circle(r=radius);
    translate([(-x/2) + radius, (y/2)-radius, 0])
    circle(r=radius);
    translate([(x/2)-radius+offset, (y/2)-radius, 0])
    circle(r=radius);
  }
}

module mini_din(thickness, rot) {
  linear_extrude(thickness, true)
  rotate([0, 0, rot])
  intersection(){
    circle(r=12.83/2);
    translate([-12.83/2,-12.83/2 + (12.83-12.07), 0])
    square([12.83, 12.07], false);
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
  union(){
    roundedRect([mw, mh, z], 5);
    translate([mw/2+offset, 0, z])
    rotate([90, 0, 0])
    linear_extrude(height=br[1], center=true)
    polygon([[0,0], [-br[0]/2,0], [-br[2], br[0]],[0, br[0]]]);
  };
  // bracket for power in
  translate([mw/2+5, 0, z+3/8*inch])
  rotate([0, 90, 0])
  translate([-0.5, 0, -br[2]])
  union(){
    mini_din(br[2]*10, -90);
    translate([0,0, -20-br[2]])
    cylinder(r=3/8*inch, h=22, center=false);
  }
  // four board holes
  translate([bw/2, bh/2, 0])
  cylinder(3, bd/2, bd/2);
  translate([-bw/2, bh/2, 0])
  cylinder(3, bd/2, bd/2);
  translate([bw/2, -bh/2, 0])
  cylinder(3, bd/2, bd/2);
  translate([-bw/2, -bh/2, 0])
  cylinder(3, bd/2, bd/2);
}
