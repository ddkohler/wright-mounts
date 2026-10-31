// xeryon bottom plate for mounting stage to post via an 8-32 screw

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;
plate_thickness = 6;
inch = 25.4;

plate_dims = [47.6, 40];

module base_v2(plate_thickness, plate_dims){
    // includes beam path etch, base uses hull of holes
    difference(){
        linear_extrude(plate_thickness){
            offset(r=3){
            hull(){
            union(){
                for (s1=[1,-1]){
                    for(i=[0,1]) {
                            translate([s1*30.4/2, 10 -20*i, 0])
                            circle(r=1);
                        };
                    };
                };
            };
        };
        };
        for (sl=[1,-1]){
            for(i=[0,1]) {
                translate([sl*30.4/2, 10 -20*i, plate_thickness])
                screw_hole("M2,8",head="socket", anchor=TOP);
            };
        };
        rotate([180, 0, 0]) screw_hole("8-32,0.25", head="socket", anchor=TOP);
    }    
};


//translate([0,0,-plate_thickness])
base_v2(plate_thickness, plate_dims);
// color("red")
// translate([30.4/2, 10 -20, plate_thickness])
// screw_hole("M2,8",head="socket",anchor=TOP);

