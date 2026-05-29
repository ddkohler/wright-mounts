// clamped top parts

$fn=50;
inch = 25.4;

// params
length = 60;
d_stepper = 10.1;
thickness = 2.5;
d_wire = 1.3;

sp = [0, d_stepper/2+thickness, length/2-5];

module screwhole(){
    union(){
        cylinder(20, r=1.5, center=true);  // fits 4-40
        translate([0,0, 3])
        cylinder(20, r=0.2*inch/2);
        translate([0,0,-3]) rotate([180,0,0])
        cylinder(20, r=0.2*inch/2);
    }
}

module clamp_cylinder(height, scale){
    difference(){
        linear_extrude(height=height)
        hull(){
            circle(r=d_stepper/2 + thickness);
            scale([1,scale]) circle(r=d_stepper/2);
        }
        for (pm=[1,-1]){
            translate([0, (d_stepper/2+thickness)*pm, height/2])
            rotate([0,90,0])
            screwhole();
        }
    }
}

module structure_cylinder(){
    translate([0,0,-15])
    rotate([0, 0, 135])
    rotate_extrude(angle=90)
    square([d_stepper/2 + thickness, 35]);
    //cylinder(h=length, r=d_stepper/2 + thickness, center=true);
}


difference(){
    translate([0,0,-length/2])
    clamp_cylinder(15, 2.25);
    // wire through hole
    cylinder(h=length+1, r=d_wire, center=true);
    translate([0,0,-15]) cylinder(51, r=d_stepper/2);
    translate([length,0,0]) cube(2*length + 0.1, center=true);
}

