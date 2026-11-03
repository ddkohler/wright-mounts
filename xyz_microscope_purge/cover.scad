// purge station anchored to newport xyz stage
include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fn = 64;
inch = 25.4;

plate_thickness = 5;
height = 3*inch;  // note: offset from xyz stage to 5" plane of imaging is about 2", so we need a bit of height adjustment
d_base = [3.75*inch, 2.48*inch];
tube_length = 1.5*inch;
// 50x uscope objective has 32 mm OD, needs to fit inside + 0.5" slack for movement
tube_id = 0.5*inch + 32;
wall = 3;
// cylinders intersect 10 mm inside the box, we should print a stage to hold the sample there
ref_corner = [-d_base[0]/2,d_base[1]/2, height/2];

screwhole_locations = [
    [d_base[0]/2-10, d_base[1]/2-10],
    [d_base[0]/2-10, -d_base[1]/2+10],
    [-d_base[0]/2+10, -d_base[1]/2+10],
];

// TODO:
// - get wall height cylinder openings sized for setup
// - ports for air flow
// bulkhead unions for quick-connect:  .67" hole (~17 mm) will work, also 15mm notches
// - need 23.4 mm surrounding surface

module lid(){
    difference(){
        union(){
            linear_extrude(wall){
                square(d_base, center=true);
            };
            translate([0, 0, -wall]) linear_extrude(wall){
               offset(r=-wall){square(d_base, center=true);};
            };
        };
        // screwholes and bulkead mount
        linear_extrude(3*wall, center=true){
            intersection(){
                circle(d=17);
                square([15.1,20], center=true);
            };
        };
        
    };
};


module base(){
    difference(){
        union(){
            translate([0,0,-plate_thickness])
            linear_extrude(plate_thickness){
                square(d_base, center=true);
            };
            linear_extrude(height){
                difference(){
                    square(d_base, center=true);
                    offset(r=-wall) {difference(){
                        square(d_base, center=true);
                        // screw hole regions
                        translate([ d_base[0]/2,  d_base[1]/2, 0]) circle(.7*inch);
                        translate([ d_base[0]/2, -d_base[1]/2, 0]) circle(.7*inch);
                        translate([-d_base[0]/2, -d_base[1]/2, 0]) circle(.7*inch);
                    }};
                };
            };
            // circular mating outlets
            // first the union of outer tubes
            // subtract the id volumes later
            translate(ref_corner)
            union(){
                translate([10,-3,0]) rotate([-90,0,0]) cylinder(h=tube_length, d=tube_id+2*wall);
                translate([3,-10,0]) rotate([0,-90,0]) cylinder(h=tube_length, d=tube_id+2*wall);
            };
        };
        translate(ref_corner)
        union(){
            translate([10,0,0]) rotate([-90,0,0]) translate([0,0,-wall-1]) cylinder(h=tube_length+2, d=tube_id);
            translate([0,-10,0]) rotate([0,-90,0]) translate([0,0,-wall-1]) cylinder(h=tube_length+2, d=tube_id);
        };
    // lid imprint 
    translate([0,0,height]) lid();
    // threaded inserts
    for (i=[0:1:2]) {
        translate([screwhole_locations[i][0],screwhole_locations[i][1], height-inch]) cylinder(inch, d=5.8);
        };
    // bulkhead mount
    translate([0*inch, -d_base[1]/2, 0.5*height]) rotate([-90,0,0])
    linear_extrude(3*wall, center=true){
        intersection(){
            circle(d=17);
            square([15.1,20], center=true);
        };
    };
        
    };
};


// design base footprint of xyz stage
difference(){
    base();
    for (i=[-1,0,1]){
        translate([1.5*i*inch, 0, 0]) 
        screw_hole("M4,10", anchor=TOP);
    };
    translate([0, -1.5*inch, 0])
    rotate([0,0,45])
    for (k=[0:1:3], j=[0:1:3]){
        if ((k==3&&j==0)||(j==3&&k==0)){} // don't overwrite the 8-32 holes
        else {
            translate([k/sqrt(2)*inch, j/sqrt(2)*inch, 0])
            screw_hole("M6,10", anchor=TOP);
        };
    };
};

// lid
// translate([0,0,height])
// color("green", alpha=0.5)
// lid();


// color("red")
// translate([-(3.75/2)*inch+10, (2.48/2)*inch-10, 0])
// cylinder(h=inch, r=6);