
$fn=50;
inch = 25.4;

mt = 7;
d_s6 = .1065*inch;  // size 6 screw hole (before threading)

module circular_mirror() {
    linear_extrude(mt,center=true)
    hull(){
        circle(d=1.24*inch);
        translate([0.62*inch, 0,0])
        square([0.2*inch, 0.2*inch], center=true);        
        translate([-0.62*inch, 0,0])
        square([0.3*inch, 0.3*inch], center=true);        
    }
}

translate([(0.3 + 1.24)/2 * inch, 0])
difference(){
    circular_mirror();
    union(){
        // window lip
        cylinder(h=10, d=1*inch-1.5, center=true);
        // window clearance
        translate([0,0,-mt/2+1])
        cylinder(h=10, d=1*inch, center=false);
        // stepper shaft
        translate([-0.62*inch-1 - 0.15*inch,0,0])
        rotate([0,90,0])
        cylinder(h=0.25*inch, d=5.05);
        // shaft fastener hole (to be threaded)
        translate([-0.62*inch-1,0,0])
        cylinder(h=4.1, d=d_s6);
        //window fastener screw
        translate([12,0,0])
        rotate([0,90,0])
        cylinder(h=10, d=d_s6, center=true);
    }
}

