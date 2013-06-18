include <relations.scad>;
include <Magpie/magpie.scad>;
include <configuration.scad>;

module belt_clamp(screw,spacing, thickness){
	screwObj = object(screw);
	difference(){
		hull(){
			cylinder(r=screwObj[WASHER_OD]/2, h=thickness);
			translate([spacing,0,0])cylinder(r=screwObj[WASHER_OD]/2, h=thickness);
		}
		translate([0,0,-eta])cylinder(r=screwObj[DIAMETER]/2, h=thickness+eta*2);
		translate([spacing,0,-eta])cylinder(r=screwObj[DIAMETER]/2, h=thickness+eta*2);	
	}
}

belt_clamp(screw,20,5);
