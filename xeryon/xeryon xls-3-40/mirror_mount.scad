$fn=50;
inch = 25.4;

module mirror_mount(){
    linear_extrude(6.4){
        difference(){
            hull(){
                union(){
                    circle(r=inch/2+2.5); 
                    translate([-inch/2,0,0])
                    square([8,20], center=true); //base is inch/2+4 from mirror center
                    translate([inch/2, 0, 0])
                    square([8,5], center=true);
                    };
                };
            union(){
                circle(r=inch/2);
                translate([-1,0,0])
                circle(r=inch/2);
            };
            };
        };
    };
    
mirror_mount();