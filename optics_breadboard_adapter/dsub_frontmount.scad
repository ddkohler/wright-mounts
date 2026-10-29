// todo: support front/back, pos/neg, db9, 15, 25, 37, 50

// db9 dimension params
a = 24.99;  // screw hole spacing
b = 20.70;  // max width (after fillet)
c = 15.90;  // upper width (before fillet)
d = 12.50;  // d = a / 2
e = 13.47;  // lower width before fillet
f = 11.68;  // max height (after fillet)
g = 5.84;   // g = f / 2
h = 6.88;   // height (before fillet)

// screw hole diameter of 3.05

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
