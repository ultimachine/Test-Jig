include <Magpie/magpie.scad>;
include <relations.scad>;

module top(screw, stepper, bearing, linear_bearing, size, bearing_side){
	stepperObj = object(stepper);
	bearingObj = object(bearing);
	screwObj = object(screw);
	linearBearingObj = object(linear_bearing);
	bearingScrewObj = diameter_to_screw(bearingObj[INNER_DIAMETER]);
	radius = linearBearingObj[INNER_DIAMETER];
	clamp_slot_width = screwObj[DIAMETER];
	clamp_slot_length = radius + screwObj[WASHER_OD] + clamp_slot_width;
	clamp_height = bearingObj[OUTER_DIAMETER];

	difference(){
		union(){
			linear_extrude(height = clamp_height,convexity=10)difference(){
				union(){
					translate([size, size])circle(r = radius);
					translate([size - radius, 0])square([radius * 2, size]);
					translate([0, size - radius])square([size, radius * 2]);
				}
				translate([size, size])poly_circle(r = linearBearingObj[INNER_DIAMETER] / 2);
				translate([size + linearBearingObj[INNER_DIAMETER] / 2 - clamp_slot_width, size - clamp_slot_length])square([clamp_slot_width, clamp_slot_length]);
				translate([size + linearBearingObj[INNER_DIAMETER]/2 - clamp_slot_width, size - clamp_slot_length])square([radius, clamp_slot_width]);
			}

		}
		translate([size-radius-eta,size-radius-screwObj[NUT_WIDTH]/2,clamp_height/2])rotate([0,90,0])poly_cylinder(screwObj[DIAMETER]/2,h=radius*2+eta*2);
		translate([size-radius-eta,size-radius-screwObj[NUT_WIDTH]/2,clamp_height/2])rotate([0,90,0])lock_nut_trap(screw);
	}
}

module top_asm(){
	for(i = [0:90:360])rotate([0,0,i])top();
}

top(screw, stepper, bearing, linear_bearing, size);
