// mount tic500 to optical breadboard (1" grid)

include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>
include <../BOSL2/hooks.scad>
include <../D-Sub/dsub.scad>
include <./center_module.scad>

$fn=50;
inch = 25.4;

barrel_size = 5/16 * inch;

// center to center dimensions
pw = 2.5*inch;  // panel width
ph = 1.5*inch;  // panel height
pt = 3;  // panel height
mw = 2*inch;  // mounting width
mh = 1*inch;  // mounting height
bw = 1.5*inch - 5.1 - 2.5;  // board width
bh = 1.05*inch - 5.0;  // board height

// hole diameters
md = 0.28*inch;  // mounting hole diameter
bd = 0.09*inch;  // board hole diameter



module place_tic500(){
  color("red", 0.6)
  //flip downward facing
  // center board holes and move downward
  translate([-(0.75+0.05)*inch, -0.5025*inch, 0.125 * inch])
  import( "ImageToStl.com_tic-t825-usb-multi-interface-stepper-motor-controller.stl");
}

// plate itself
difference() {
  // positive rectangle
  union(){
    linear_extrude(pt)
    roundedRect([pw + 0.6*inch, ph + 0.6*inch, pt], 6);
  }
  // four board-mount holes
  translate([-10, 8, 0])
  union() {
    for (sx=[1,-1], sy=[1,-1])
        translate([sx*bw/2, sy*bh/2, pt-1]) screw_hole("#2", "socket", length=pt, counterbore=0, orient=DOWN);
      translate([0,0,-0.1])
      // clearance opening
      linear_extrude(height=5)
      offset(r=3){
        offset(r=-6){
          union(){
            square([mw, bh-0.4*inch], center=true);
            square([bw-0.4*inch, mh], center=true);
          }
        }
      }
  }
  // db9 retrofit (for home-built filter/nd stages)
  translate([mw/2, 0, -0.1]) rotate([0,0,180]) dsub(1.1,17.04,10);
}

color("blue")
translate([0,0,pt])
shellWithPorts([-5, 0, 22], [pw + 0.6*inch, ph + 0.6*inch, 1.25*inch], radius=6, thickness=3);

translate([-10, 8, 10])
place_tic500();