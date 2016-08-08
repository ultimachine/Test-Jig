include <Magpie/magpie.scad>;
include <relations.scad>;

/* module bearing_cap(bearing, screw, backing)
bearing - Magpie compatible bearing string
screw- Magpie compatible screw string
backing - amount to add to the top of the clamp in addition to the bearing radius
*/
module bearing_cap(bearing, screw, backing){

	//Make Vector Objects
	bearingObj = object(bearing);
	screwObj = object(screw);

	difference(){
		union(){
			//Make a rounded shape for bearing and screws to go through
			hull(){
				cylinder(r=bearingObj[LENGTH], h=bearingObj[OUTER_DIAMETER]/2+backing);
				translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER],0,0])
					cylinder(r=bearingObj[LENGTH], h=bearingObj[OUTER_DIAMETER]/2+backing);
			}
		}
		//Screw holes
		translate([0,0,-eta])poly_cylinder(r=screwObj[DIAMETER]/2, h=bearingObj[OUTER_DIAMETER]/2+backing+eta*2);
		translate([bearingObj[OUTER_DIAMETER]+screwObj[DIAMETER],0,-eta])
			poly_cylinder(r=screwObj[DIAMETER]/2, h=bearingObj[OUTER_DIAMETER]/2+backing+eta*2);

		//bearing cutout
		translate([bearingObj[DIAMETER]/2+screwObj[DIAMETER]/2,-bearingObj[LENGTH]/2,bearingObj[DIAMETER]/2+backing])
			rotate([-90,0,0])poly_cylinder(r=bearingObj[OUTER_DIAMETER]/2, h=bearingObj[LENGTH]);

		//Shaft cutout
		translate([bearingObj[DIAMETER]/2+screwObj[DIAMETER]/2,eta+bearingObj[LENGTH],bearingObj[DIAMETER]/2+backing])
			rotate([90,0,0])poly_cylinder(r=(bearingObj[OUTER_DIAMETER]+bearingObj[INNER_DIAMETER])/4, h=bearingObj[LENGTH]*2+eta*2);
	}
}

bearing_cap(bearing, screw,3);
