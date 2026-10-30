// units of mm
// todo: support front/back, pos/neg, db9, 15, 25, 37, 50

screw_hole_diameter = 3.05

// dimensions from NorComp
db9_front = [24.99, 20.70, 15.90, 12.50, 13.47, 11.68, 5.84, 6.88];
db25_front = [47.04, 42.80, 38.00, 23.52, 35.57, 11.68, 5.84, 6.88];

db9_back = [24.99, 20.47, 15.46, 12.5, 13.46, 10.67, 5.33, 5.66];
db25_back = [47.04, 42.52, 37.51, 23.52, 35.51, 10.67, 5.33, 5.66];

a = 24.99;  // screw hole spacing
b = 20.70;  // max width (after fillet)
c = 15.90;  // upper width (before fillet)
d = 12.50;  // d = a / 2
e = 13.47;  // lower width (before fillet)
f = 11.68;  // max height (after fillet)
g = 5.84;   // g = f / 2
h = 6.88;   // height (before fillet)


module dsub_neg(db, side, tol=0, pad=0){
    // negative db 2D primitive within a bounded box; pad specifies how much bigger the box is
    circle(0);
}

module dsub_pos(db, side, tol=0){
    // positive db 2D primitive
    circle(0);
}

module db9_front_neg(tol=0, boundary=0){
    // front-mounted dsub connector    
    // negative image
    difference(){
        offset(r=tol+boundary){square(size=[a+3.05+tol,f], center=true);}
        union(){
            // screw holes
            translate([-a/2, 0, 0])
            circle(r=3.05/2+tol);
            translate([a/2, 0, 0])
            circle(r=3.05/2+tol);        
            // the center piece
            offset(r=(b-c)/2+tol){
                polygon([[c/2, h/2], [-c/2, h/2], [-e/2, -h/2], [e/2, -h/2]]);
            };
        }

    }

}


// linear_extrude(5){db15_front_neg(0);}
