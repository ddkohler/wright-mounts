
$fn=50;
inch = 25.4;
default_color = "aqua";

d_shaft = 5; // shaft diameter

// dimensions
mw = 4*inch;  // board width
mh = 2.5*inch;  // board height
mt = 0.25*inch; // board thickness

motor_stl = "17HS13-0404S-PG27.stl";

stepper_positions = [
    [-1*inch, 0, 0],
    [1*inch, 0, 0]
];


module countersunk(diameter, pos){
    union(){
        through_hole(diamter, pos);
    };
}

module through_hole(diameter,pos){
    translate(pos)
    linear_extrude(mt*1.2, center=true)
    color("red", 0.2)
    circle(d=diameter);
}

module place_tic(pos){
    translate(pos)
    color("red", 0.2)
    import("tic_t500_crude.stl");
    }

module place_stepper(pos){
    translate([pos[0], pos[1], pos[2]-80])
    // rotate([180,0,0])
    color("silver", 0.2)
    import(motor_stl);
}

color(default_color)
difference(){
    cube([mw, mh, mt], center=true);
    union(){
        through_hole(5.5, [-1*inch,0,0]);
        through_hole(5.5, [1*inch,0,0]);
        for (center=stepper_positions) {
            translate(center)
            for (rot=[0,90,180,270]) {
                rotate([0, 0, rot])
                through_hole(3.4,[-14, 0, 0]);
            }
        }
    }
}

for (pos = stepper_positions){
    place_stepper(pos);
}

place_tic([1*inch, 0, 1*inch]);


