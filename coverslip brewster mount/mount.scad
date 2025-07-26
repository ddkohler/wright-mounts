$fn=50;
inch = 25.4;
windows = 4;
ba = 55.5; // brewster angle
aperture = 0.625*inch;
ct = 6;  // center thickness
et = 5;  // end thickness
tube_length = 2 * inch - et - ct/2;

module brewster_holder(diameter=0.63*inch, offset=0.5, angle=ba){
    // individual carriage for coverslip
    rotate([0,angle,0])
    translate([0,0,-offset])
    union(){
         linear_extrude(2*inch, center=false){circle(d=diameter);};
    }
}


module embossed_endcap(d=0.75*inch, thickness=5){
    difference(){
        linear_extrude(thickness, center=false){circle(d=d, center=true);};
        translate([0, 0, thickness]) rotate([45, 0, 0]) cube([d, 1, 1], center=true);
    };
}

module brewster_tube(length=tube_length, diameter=0.75*inch){
    difference(){
        cylinder(length, d=diameter);
        for (step=[1:windows]){
            translate([0, 0, 0.05 * (tube_length-0.5*inch) + 1.1 * step*(tube_length-0.5*inch)/windows])
            brewster_holder(angle=ba);
        }
    };
}

module half_tube(){
    difference(){
        union(){
            // center mounting cylinder
            linear_extrude(ct/2, center=false){circle(d=1*inch, center=true);};
            // embossed endcaps
            translate([0, 0, tube_length+ct/2]) embossed_endcap();
            translate([0, 0, ct/2]) brewster_tube();
        };
        linear_extrude(4*inch+2, center=true){
            scale([sin(ba), 1, 1]) circle(d=aperture-4);
        }
        translate([0.375*inch, 0 , ct/2 + (tube_length)/2]) minkowski(){
            cube([0.75*inch-10, 1*inch, tube_length-10], center=true);
            rotate([90,0,0]) cylinder(r=5);
        };
    }
}

half_tube();
mirror([0,0,1]) half_tube();

