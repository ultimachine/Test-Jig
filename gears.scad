include <Magpie/shapes.scad>;
include <Magpie/magpie.scad>;
include <Magpie/demos.scad>;

module spur_gear(teeth,height,rod){
	screwObj = object(rod); 
	difference(){
		herringbone(teeth,6.3,45,0.5,-0.1,40,height);
		translate([0,0,height/2-screwObj[NUT_HEIGHT]+eta])nut_trap(rod);
		translate([0,0,-height/2-eta])poly_cylinder(r=screwObj[DIAMETER]/2, h=height+eta*2);
	}
}

module pinion_gear(teeth,height,shaft,screw){
	screwObj = object(screw); 
	difference(){
		union(){
			translate([0,0,-height/2])herringbone(teeth,6.3,45,0.5,-0.1,40,height);
			translate([0,0,-eta])cylinder(r=shaft+screwObj[NUT_HEIGHT]*2, h=screwObj[NUT_WIDTH]*2);
		}
		translate([0,0,-height-eta])poly_cylinder(r=shaft/2, h=height*2+eta*2);

		translate([0,0,screwObj[NUT_WIDTH]])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2,h=6.3*teeth);
		translate([shaft/2,-screwObj[NUT_WIDTH]/2,screwObj[NUT_WIDTH]])cube([screwObj[NUT_HEIGHT],screwObj[NUT_WIDTH],screwObj[NUT_WIDTH]+eta]);
		translate([shaft/2,0,screwObj[NUT_WIDTH]])rotate([0,90,0])nut_trap(screw);
	}
}

pinion_gear(9,15,5,"M3");