// adapt camera to a post mount; camera mounts like thorlabs FM series
// 8-32 press fit threads for post adapter, camera lock (rubber tip)

$fn=100;
inch=25.4;

cd = 21.2; // hole diameter for camera
// smount has 21.0 mm diameter
// cmount has 27.8 mm diameter

csm1 = 1.2*inch; // hole diameter for sm1 mount

post_d = 0.2185*inch; // hole diameter for post mount
post_depth = 0.32*inch; 

thickness = 0.375*inch;

module SMountHolder(height, radius, post_radius, post_depth) {
  linear_extrude(height=height)
  hull() {
    offset(3){
      circle(radius);
    }
    for (fi=[-1,1]){  // put on both sides
      translate([fi*(radius+3),0,0])
      offset(5){
        polygon([
          [0, -post_radius],
          [0, post_radius],
          [fi*post_depth, post_radius],
          [fi*post_depth, -post_radius]
        ]);
      }
    }
  }
}

difference(){
  SMountHolder(thickness, cd/2, post_d/2, post_depth);
  cylinder(thickness, r=cd/2);
  translate([0,0,thickness/2])
  rotate([0,90,0])
  cylinder(100, r=post_d/2, center=true);


}

