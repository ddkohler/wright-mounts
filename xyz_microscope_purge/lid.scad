include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fn = 64;
inch = 25.4;

height = 3*inch;
d_base = [3.75*inch, 2.48*inch];
wall = 3;

screwhole_locations = [
    [ d_base[0]/2-10,  d_base[1]/2-10],
    [ d_base[0]/2-10, -d_base[1]/2+10],
    [-d_base[0]/2+10, -d_base[1]/2+10],
];


module lid(base, wall){
    difference(){
        union(){
            linear_extrude(wall){
                square(base, center=true);
            };
            translate([0, 0, -wall]) linear_extrude(wall){
               offset(r=-wall-0.1){square(base, center=true);};
            };
        };
        // screwholes and bulkead mount
        linear_extrude(3*wall, center=true){
            intersection(){
                circle(d=17);
                square([15.1,20], center=true);
            };
        };
        for (i=[0:1:2]) {
            translate([screwhole_locations[i][0],screwhole_locations[i][1],0]) screw_hole("8-32,1");
        };        
    };
};

// lid(d_base, wall);
