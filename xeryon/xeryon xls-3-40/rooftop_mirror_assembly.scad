// xeryon top plate for mounting kms1 and fmp1 in a rooftop retroreflector configuration
// holes and heights positioned for matching mirrors when at 45 deg
// 1" beam displacement when centered

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;
plate_thickness = 5;
inch = 25.4;
backup_stage_y = 3; // move the retroreflectors along y to avoid other screwholes

// use a gap for 1" beam displacement
gap = inch * (1-sqrt(2)/2);
kms_offset = 18.85;
fmp_offset = 2.4;
kms_v_offset = 15.9;
fmp_v_offset = 22.1;
hole_displacements = [
    gap + sqrt(2)/2 * (inch + kms_offset + fmp_offset),
    sqrt(2)/2 * (kms_offset-fmp_offset),
];
echo(hole_displacements);
// plate_dims = [47.6, 40];
plate_dims = [50, 40];
// aluminum density 2.7 g/cm^3; approximate weight of 2.7 * 5 * 4 * 0.5 ~ 27 g

module rooftop_triangle(side=inch*sqrt(2)/2){
        // origin is the 90 deg vertex
        polygon([[0, 0], [side, 0], [0, side], [0, 0]]);
    };

// two strategies: 
//  (1) plate adapter with vertical countersunk screw holes
//  (2) triangle plate with with side mount holes for custom mirror mounts; triangle offset from center


module base_v2(plate_thickness, plate_dims){
    // includes beam path etch, base uses hull of holes
    difference(){
        linear_extrude(plate_thickness){
            offset(r=3){
            hull(){
            union(){
                for (s1=[1,-1]){
                    for(i=[0:3]) {
                            translate([s1*44/2, 30/2 -10*i, 0])
                            circle(r=2.5/2);
                        };
                    };
                };
            };
        };
        };
        for(i=[1,2,3]) {
                translate([44/2, 30/2 -10*i, 0])
                screw_hole("M2.5,7",head="socket",counterbore=3);
        };
        for(i=[0,3]) {
                translate([-44/2, 30/2 -10*i, 0])
                screw_hole("M2.5,7",head="socket",counterbore=3);
        };
        translate([-hole_displacements[0]/2, backup_stage_y, 0])
        rotate([180, 0, 0])
        screw_hole("8-32,0.25", head="socket", anchor=TOP);
        translate([hole_displacements[0]/2, hole_displacements[1]+backup_stage_y, 0])
        rotate([180, 0, 0])
        screw_hole("8-32,0.25", head="socket", anchor=TOP);
        // beam path indicator
        translate([0,0,plate_thickness])
        linear_extrude(1, center=true){
            difference(){
                offset(r=0.5){
                    polygon([[-5-inch/2, 0], [-5-inch/2, -inch], [-5+inch/2, -inch], [-5+inch/2, 0], [-5-inch/2, 0]]);};
                offset(r=-0.5){
                    polygon([[-5-inch/2, 0], [-5-inch/2, -inch], [-5+inch/2, -inch], [-5+inch/2, 0], [-5-inch/2, 0]]);};
            };
        };
        // translate([-5, 0, plate_thickness]) cube([inch, 1,1], center=true);
        // translate([-5-0.5*inch, -0.5*inch, plate_thickness]) cube([1, inch, 1], center=true);
        // translate([-5+0.5*inch, -0.5*inch, plate_thickness]) cube([1, inch, 1], center=true);
    }    
};


module base(plate_thickness, plate_dims){
    difference(){
        linear_extrude(plate_thickness){
            square(plate_dims, center=true);
        };
        for(i=[1,2,3]) {
                translate([44/2, 30/2 -10*i, 0])
                screw_hole("M2.5,7",head="socket",counterbore=3);
        };
        for(i=[0,3]) {
                translate([-44/2, 30/2 -10*i, 0])
                screw_hole("M2.5,7",head="socket",counterbore=3);
        };
        translate([-hole_displacements[0]/2, backup_stage_y, 0])
        rotate([180, 0, 0])
        screw_hole("8-32,0.25", head="socket", anchor=TOP);
        translate([hole_displacements[0]/2, hole_displacements[1]+backup_stage_y, 0])
        rotate([180, 0, 0])
        screw_hole("8-32,0.25", head="socket", anchor=TOP);

    }    
};

// just an ad-hoc visual of 45 deg triangle with 1" hypotenuse; for verifying the mirror placements look reasonable
// color("red", 0.5)
// translate([-4.8, 13, 22.1]) rotate([0, 0, 225]) linear_extrude(3, center=true){
//    rooftop_triangle();
// };


translate([0,0,-plate_thickness])
base_v2(plate_thickness, plate_dims);

// kms mirror position
// color("silver", 0.5)
// translate([hole_displacements[0]/2, hole_displacements[1]+backup_stage_y, 0])
// rotate([0,0,45])
// translate([-kms_offset, 0, kms_v_offset])
// rotate([0,90,0])
// cylinder(6, r=inch/2);

// fmp mirror position
// color("silver", 0.5)
// translate([-hole_displacements[0]/2, backup_stage_y, 0])
// rotate([0,0,45])
// translate([0, fmp_offset, fmp_v_offset])
// rotate([90,0,0])
// cylinder(6, r=inch/2);
