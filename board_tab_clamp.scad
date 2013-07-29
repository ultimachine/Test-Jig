include <relations.scad>;
include <Magpie/magpie.scad>;
include <configuration.scad>;

module board_tab_clamp(screw,length,thickness, board_thickness){
	screwObj = object(screw);
	difference(){
		union(){
			hull(){
				cylinder(r=screwObj[WASHER_OD]*2/3, h=thickness-board_thickness);
				translate([length,0,0])cylinder(r=screwObj[WASHER_OD]*2/3, h=thickness-board_thickness);
			}
			hull(){
				cylinder(r=screwObj[WASHER_OD]*2/3, h=thickness);
				translate([screwObj[WASHER_OD]*2/3,0,0])cylinder(r=screwObj[WASHER_OD]*2/3, h=thickness);
			}
		}
		translate([0,0,-eta])cylinder(r=screwObj[DIAMETER]/2, h=thickness+eta*2);
	}
}

board_tab_clamp(screw,20,25,1.8);
