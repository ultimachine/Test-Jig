include <Magpie/magpie.scad>;
include <relations.scad>;

module middle_clamp(length, clampRadius, rodDia, height, holes, holeDia){
	difference(){
		union(){
			hull(){
				translate([0,0,0])cylinder(r=clampRadius, h = height);
				translate([length,0,0])cylinder(r=clampRadius, h = height);
			}
		}
		
		//utility holes
		for(i = [1:holes]){
			translate([length*(i/holes-1/(holes*2)),-eta,height/2])rotate([-90,0,0])poly_cylinder(r=holeDia/2, h=clampRadius+eta*2);
		}
		
		//rods
		translate([0,0,-eta])poly_cylinder(r=rodDia/2, h = height+eta*2);
		translate([length,0,-eta])poly_cylinder(r=rodDia/2, h = height+eta*2);
		
		//subtract opposite side
		translate([-clampRadius-eta,-clampRadius-eta,-eta])cube([length+clampRadius*2+eta*2,clampRadius+eta,height+eta*2]);
	}
}

middle_clamp(size*2, baseRadius, linearBearingObj[INNER_DIAMETER], 10, 5, screwObj[DIAMETER]);