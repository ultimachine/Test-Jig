include <Magpie/magpie.scad>;
include <relations.scad>;

module base_sketch(screw, stepper, bearing, linear_bearing, size){
	stepperObj = object(stepper);
	bearingObj = object(bearing);
	screwObj = object(screw);
	linearBearingObj = object(linear_bearing);
	difference(){
		union(){
			translate([size,size])circle(r=baseRadius);
			translate([size-baseRadius,30])square([baseRadius*2,45]);
			translate([size-baseRadius,10])square([baseRadius,50]);
			translate([-10,size-baseRadius])square([85,baseRadius*2]);
			translate([-30,size])square([100,baseRadius]);
		}
		translate([size,size])poly_circle(r=linearBearingObj[INNER_DIAMETER]/2);
		translate([size*2/3,size])poly_circle(r=3);
		translate([size/3,size])poly_circle(r=3);
		translate([size+4-3,size-baseRadius-screwObj[WASHER_OD]*2-5])square([3,baseRadius+screwObj[WASHER_OD]*2+5]);
		translate([size+4-3,size-baseRadius-screwObj[WASHER_OD]*2-8])square([baseRadius,3]);
		translate([bearingObj[OUTER_DIAMETER]/2+screwObj[DIAMETER]/2,size+baseRadius/2])poly_circle(r=screwObj[DIAMETER]/2);
		translate([-bearingObj[OUTER_DIAMETER]/2-screwObj[DIAMETER]/2,size+baseRadius/2])poly_circle(r=screwObj[DIAMETER]/2);
	}
}

module base_side(screw, stepper, bearing, linear_bearing, size, height){
	stepperObj = object(stepper);
	bearingObj = object(bearing);
	screwObj = object(screw);
	linearBearingObj = object(linear_bearing);
	difference(){
		linear_extrude(height=height,convexity=10)base_sketch(screw, stepper, bearing, linear_bearing, size);
		translate([size-baseRadius-eta,size-baseRadius-screwObj[WASHER_OD],height/2])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=baseRadius*2+eta*2);
		translate([size-baseRadius-eta,20,height/4])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=baseRadius*2+eta*2);
		translate([size-baseRadius-eta,20,height*3/4])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=baseRadius*2+eta*2);
		translate([-20,size-baseRadius-eta,height/4])rotate([-90,0,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=baseRadius*2+eta*2);
		translate([-20,size-baseRadius-eta,height*3/4])rotate([-90,0,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=baseRadius*2+eta*2);
		translate([0,size-bearingObj[LENGTH]/2+baseRadius/2,height])rotate([-90,0,0])poly_cylinder(r=bearingObj[OUTER_DIAMETER]/2, h=bearingObj[LENGTH]);
		translate([0,size-baseRadius-eta,height])rotate([-90,0,0])poly_cylinder(r=(bearingObj[INNER_DIAMETER]+bearingObj[OUTER_DIAMETER])/4, h=baseRadius*2+eta*2);
		translate([bearingObj[OUTER_DIAMETER]/2+screwObj[DIAMETER]/2,size+baseRadius/2,-eta])lock_nut_trap(screw);
		translate([-bearingObj[OUTER_DIAMETER]/2-screwObj[DIAMETER]/2,size+baseRadius/2,-eta])lock_nut_trap(screw);
	}
}

module base_asm(){
	for(i = [0:90:360])rotate([0,0,i])base_side();
}

base_side(screw, stepper, bearing, linear_bearing, size,stepperObj[WIDTH]/2);
