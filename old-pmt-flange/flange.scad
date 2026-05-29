// adapt camera to a post mount or 30 mm cage mount
// for post mount, requires threaded press insert

$fn=100;
inch=25.4;
// holes form equilateral of approximately 1 13/16"
// tube OD should be ~29 mm
// triangle_sides = (1 + 13/16) * inch;
triangle_sides = 46.2 - 3.5;
r_screw = triangle_sides / sqrt(3);  // centroid of equilateral


module tube(od, id, height) {
    difference() {
        cylinder(h=height, r=od/2);
        cylinder(h=2.1*height, r=id/2, center=true);
    }
}


union(){
    tube(29.9, 27, 25);
    difference(){
        tube(58, 27, 4);
        union(){
            translate([r_screw, 0, 0]) cylinder(h=11, r=3, center=true);
            rotate(120) translate([r_screw, 0, 0]) cylinder(h=11, r=2.5, center=true);
            rotate(240) translate([r_screw, 0, 0]) cylinder(h=11, r=2.5, center=true);
        }
    }
}

