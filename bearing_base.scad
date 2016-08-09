include <Magpie/magpie.scad>;
include <relations.scad>;

/* module bearing_base(bearing, screw, height)
bearing - Bearing string available in Magpie
screw - Screw string available in Magpie
height - Height from bottom to center of bearing
*/
module bearing_base(bearing, screw, height){

	//Make Vector Objects
	bearingObj = object(bearing);
	screwObj = object(screw);
	radius = bearingObj[LENGTH];
	difference(){
		union(){
			//Make shape for bearing and screws to go through
			hull(){
				cylinder(r=radius, h=height);
				translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER],0,0])
					cylinder(r=radius, h=height);
				translate([-screwObj[WASHER_OD],0,0])cylinder(r=radius, h=screwObj[LOCK_NUT_HEIGHT]);
				translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER]+screwObj[WASHER_OD],0,0])cylinder(r=radius, h=screwObj[LOCK_NUT_HEIGHT]);
			}
		}
		//Bearing cap screw holes
		translate([0,0,-eta])poly_cylinder(r=screwObj[DIAMETER]/2, h=height+eta*2);
		translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER],0,-eta])
			poly_cylinder(r=screwObj[DIAMETER]/2, h=height+eta*2);

		//washer cutouts on dogears
		translate([-screwObj[WASHER_OD],0,screwObj[LOCK_NUT_HEIGHT]])
			poly_cylinder(r=screwObj[WASHER_OD]/2, h=height);
		translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER]+screwObj[WASHER_OD],0,screwObj[LOCK_NUT_HEIGHT]])
			poly_cylinder(r=screwObj[WASHER_OD]/2, h=height);

		//Dog ear holes
		translate([-screwObj[WASHER_OD],0,-eta])
			poly_cylinder(r=screwObj[DIAMETER]/2, h=height);
		translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER]+screwObj[WASHER_OD],0,-eta])
			poly_cylinder(r=screwObj[DIAMETER]/2, h=height);

		//Nut Traps
		translate([0,0,-eta])nut_trap(screw);
		translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER],0,-eta])lock_nut_trap(screw);

		//bearing cutout
		translate([bearingObj[DIAMETER]/2+screwObj[DIAMETER]/2,-bearingObj[LENGTH]/2,height])
			rotate([-90,0,0])poly_cylinder(r=bearingObj[OUTER_DIAMETER]/2, h=bearingObj[LENGTH]);

		//Shaft cutout
		translate([bearingObj[DIAMETER]/2+screwObj[DIAMETER]/2,eta+bearingObj[LENGTH],height])
			rotate([90,0,0])poly_cylinder(r=(bearingObj[OUTER_DIAMETER]+bearingObj[INNER_DIAMETER])/4, h=bearingObj[LENGTH]*2+eta*2);

	}
}

bearing_base(bearing, screw,baseHeight );