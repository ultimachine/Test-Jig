include <Magpie/magpie.scad>;
include <MCAD/2Dshapes.scad>;
include <configuration.scad>;

module opto_on_stepper_mount(screw, stepper, width, hole_spacing,offset,debug=0){
	if(debug ==1){
		echo(str("hole_spacing : ", hole_spacing));
	}
	screwObj = object(screw);
	stepperObj = object(stepper);
	difference(){
		union(){
			hull(){
				translate([stepperObj[HOLE_SPACING]/2,0,0])cylinder(r=screwObj[WASHER_OD], h=width);
				translate([-stepperObj[HOLE_SPACING]/2,0,0])cylinder(r=screwObj[WASHER_OD], h=width);
				translate([-screwObj[WASHER_OD],offset,0])cube([screwObj[WASHER_OD]*2,screwObj[WASHER_OD],width]);
			}
			translate([-screwObj[WASHER_OD],offset,0])cube([screwObj[WASHER_OD]*2,screwObj[WASHER_OD],screwObj[WASHER_OD]*3/2+width+hole_spacing]);
			//translate([6.25/2,offset,width])rotate([90,-90,0])opto();
						
		}
		translate([stepperObj[HOLE_SPACING]/2,0,-eta])poly_cylinder(r=screwObj[DIAMETER]/2, h=width+eta*2);
		translate([-stepperObj[HOLE_SPACING]/2,0,-eta])poly_cylinder(r=screwObj[DIAMETER]/2, h=width+eta*2);
		translate([0,-stepperObj[HOLE_SPACING]/2,-eta])poly_cylinder(r=stepperObj[FLANGE_DIAMETER]/2, h=width+eta*2);
		translate([0,offset-eta,width+screwObj[WASHER_OD]/2])rotate([-90,0,0])poly_cylinder(r=screwObj[DIAMETER]/2,h=screwObj[WASHER_OD]+eta*2);
		translate([0,offset-eta,width+screwObj[WASHER_OD]/2+hole_spacing])rotate([-90,0,0])poly_cylinder(r=screwObj[DIAMETER]/2,h=screwObj[WASHER_OD]+eta*2);
	}
}


module opto_on_stepper_assembly(screw, stepper){
	screwObj = object(screw);
	stepperObj = object(stepper);
	stepper_mount_asm(stepper,5,10,3);
	translate([5,0,stepperObj[WIDTH]/2+stepperObj[HOLE_SPACING]/2])rotate([90,0,90])opto_on_stepper_mount(screw, stepper, 4, 19,9+3.5);
	translate([22,0,stepperObj[WIDTH]/2])rotate([0,-90,0])flag(10,5,screw,20);

}
flag(10,5,screw,20);
//opto_on_stepper_assembly(screw, stepper);
//opto_on_stepper_mount(screw, stepper, 4, 19,9+3.5,1);


module opto(){
	union(){
		cube([25,6.25,3]);
		translate([6,0,0])cube([4.5,6.25,11]);	
		translate([14,0,0])cube([4.5,6.25,11]);	
	}
}

module flag(height,shaft,screw,radius){
	screwObj = object(screw); 
	difference(){
		union(){
			cylinder(r=shaft/2+screwObj[NUT_HEIGHT]*2, h=screwObj[NUT_WIDTH]*2);
			linear_extrude(height=2)pieSlice(radius, 0, 36);
			linear_extrude(height=2)pieSlice(radius, 36+72, 36+72+108);
		}
		translate([0,0,-eta])poly_cylinder(r=shaft/2, h=height*2+eta*2);
		translate([0,0,screwObj[NUT_WIDTH]])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2,h=10);
		translate([shaft/2,-screwObj[NUT_WIDTH]/2,screwObj[NUT_WIDTH]])cube([screwObj[NUT_HEIGHT],screwObj[NUT_WIDTH],screwObj[NUT_WIDTH]+eta]);
		translate([shaft/2,0,screwObj[NUT_WIDTH]])rotate([0,90,0])nut_trap(screw);

	}
}