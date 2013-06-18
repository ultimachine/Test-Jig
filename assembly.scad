use <rider.scad>;
use <base.scad>;
include <relations.scad>;

module assembly(){
	rider1_height = stepperObj[WIDTH];
	rider2_height = rider1_height + pogoLength*2;
	top_base_height = rider2_height;
	union(){
		base_asm();
		translate([0,0,250])base_asm();
		translate([0,0,stepperObj[WIDTH]])rider_asm();
		translate([0,0,150])rider_asm();
		for(i=[0:90:270])rotate([0,0,i])translate([size,size,0])rod(linearBearingObj[INNER_DIAMETER]/2, 200,"BZP");
	}
}

assembly();