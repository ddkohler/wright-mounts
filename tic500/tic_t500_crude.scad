// mount with m2 screws

$fn=50;
inch = 25.4;

// translate([-20, -20, 0])
// import("11HS20-0674S-PG27.stl");


// dimensions
mw = 38.1;  // pcb width
mh = 26.7;  // pcb height
mt = 1.57;  // pcb thickness

module through_hole(d, position) {
    translate(position)
    linear_extrude(height=2)
    circle(d=d);
}

difference(){
    union(){
        cube([mw, mh, mt], [0, 0, 0]);
        translate([3.6, 23.1, mt])
        cube([8, 5, 1.5]);
        translate([13, 13])
        linear_extrude(height=8.5)
        circle(d=7.9);
        
    };
    union(){
        through_hole(2.18, [35.6, 24.2, 0]);
        through_hole(2.18, [5.1, 2.5, 0]);
        for (i=[0:5]) {through_hole(1.52, [38.1-3.81, 1.75 + 3.5*i]);
        }
        for (i=[0:9]) {
            through_hole(1.02, [1.27, mh-1.27-2.54*i]);
        }
    };
};
