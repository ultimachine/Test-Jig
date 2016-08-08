include <Magpie/magpie.scad>;
include <relations.scad>;

module rider_sketch(){
	difference(){
		union(){
			translate([size,size])circle(r=riderRadius);
			translate([size-riderRadius,30])square([riderRadius*2,size-30]);
			translate([size-riderRadius,10])square([riderRadius,50]);
			translate([-10,size-riderRadius])square([size+10,riderRadius*2]);
			translate([-30,size])square([100,riderRadius]);
			translate([-5.5,size+riderRadius])square([11,35]);
		}
		translate([size,size])poly_circle(r=linearBearingObj[OUTER_DIAMETER]/2);
		translate([50,size])poly_circle(r=screwObj[DIAMETER]/2);
		translate([25,size])poly_circle(r=screwObj[DIAMETER]/2);
		translate([0,size])poly_circle(screwObj[DIAMETER]/2);
		translate([size+linearBearingObj[OUTER_DIAMETER]/2-3,size-35])square([3,35]);
		translate([size+linearBearingObj[OUTER_DIAMETER]/2-3,size-35])square([riderRadius,3]);
	}
}

module rider_side(){
	difference(){
		linear_extrude(height=linearBearingObj[LENGTH],convexity=10)rider_sketch();
		translate([size-riderRadius-eta,size-riderRadius-screwObj[WASHER_OD],linearBearingObj[LENGTH]/2])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
		translate([size-riderRadius-eta,20,linearBearingObj[LENGTH]/4])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
		translate([size-riderRadius-eta,20,linearBearingObj[LENGTH]*3/4])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
		translate([-20,size-riderRadius-eta,linearBearingObj[LENGTH]/4])rotate([-90,0,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
		translate([-20,size-riderRadius-eta,linearBearingObj[LENGTH]*3/4])rotate([-90,0,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
		translate([-20,size+riderRadius+screwObj[WASHER_OD],linearBearingObj[LENGTH]/2])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
		translate([-20,size+riderRadius+20+screwObj[WASHER_OD],linearBearingObj[LENGTH]/2])rotate([0,90,0])poly_cylinder(r=screwObj[DIAMETER]/2, h=riderRadius*2+eta*2);
	}
}

module rider_asm(){
	for(i = [0:90:360])rotate([0,0,i])rider_side();
}

rider_side();
