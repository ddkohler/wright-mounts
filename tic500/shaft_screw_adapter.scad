// attach 5 mm shaft to 8-32 threaded components
// also include hole for attaching spoke or similar
$fn=50;
inch = 25.4;

mt = 0.5*inch;
d = 0.5*inch;
d_s6 = 0.1065*inch;  // size 6 screw hole (before threading)
d_s8 = 0.1360*inch;  // size 8 screw hole (for mating with fasteners)
d_shaft = 5.05; // shaft hole diameter

module base() {
    linear_extrude(mt, center=true)
    circle(d=d, center=true);        
}

// translate([(0.3 + 1.24)/2 * inch, 0])
difference(){
    base();
    union(){
        // stepper shaft
        translate([0, 0, -mt/2])
        cylinder(h=0.25*inch, d=5.05);
        // stepper shaft fastener
        translate([0, 0, -mt/4])
        rotate([90, 0, 0])
        cylinder(h=0.5*inch, d=d_s6, center=true);
        // spoke hole
        // NOT NEEDED: just attach string to shaft fastener screw
        // 8-32 hole
        cylinder(h=0.5*inch, d=d_s8);
    }
}

