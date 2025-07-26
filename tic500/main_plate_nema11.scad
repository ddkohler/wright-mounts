
$fn=50;
inch = 25.4;
default_color = "aqua";

d_shaft = 5; // shaft diameter

// dimensions
mw = 4*inch;  // board width
mh = 2.5*inch;  // board height
mt = 0.25*inch; // board thickness

motor_stl = "11HS20-0674S-PG27.stl";
window_stl = "window_mount_1in.stl";

stepper_positions = [
    [-1*inch, 0, 0],
    [1*inch, 0, 0]
];


module countersunk(diameter, pos){
    union(){
        through_hole(diameter, pos);
        translate([pos[0], pos[1], pos[2]+mt/2-6.5])
        cylinder(7, d1=0, d2=7);
    };
}

module through_hole(diameter, pos){
    translate(pos)
    linear_extrude(mt*1.2, center=true)
    circle(d=diameter);
}

module place_tic(pos){
    translate(pos)
    rotate([-90, 0,0])
    rotate([0, 0, -90])
    color("red", 0.2)
    import("tic_t500_crude.stl");
    }

module place_stepper(pos){
    translate([pos[0], pos[1], pos[2]-40])
    rotate([180,0,0])
    color("silver", 0.2)
    import(motor_stl);
}

module place_windows(pos, rot=0){
    translate(pos)
    color("green", 0.3)
    rotate([0, -90, rot])
    import(window_stl);
}

color(default_color, 0.5)
difference(){
    cube([mw, mh, mt], center=true);
    union(){
        for (center=stepper_positions) {
            // for shaft
            through_hole(5.5, center);
            translate([center[0], center[1], center[2]-mt/2-1])
            cylinder(3.1, d=18.5);
            translate(center)
            // for fasteners to steppers
            for (rot=[0,90,180,270]) {
                rotate([0, 0, rot])
                countersunk(3.4,[-11, 0, 0]);
            }
        }
    }
}

for (pos = stepper_positions){
    place_stepper(pos);
}

place_windows([1*inch, 0, mt/2], rot=-45);
place_windows([-1*inch, 0, mt/2], rot=45);

place_tic([0, 1*inch, -2*inch]);


