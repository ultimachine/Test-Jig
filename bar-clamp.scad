
include<Magpie/magpie.scad>;
smoothroddia = 12;
frameroddia = 8;
wall = 5;

$fn = 31;

module barclamp(){

	difference() {

		union() {

			cylinder(r = smoothroddia/2+wall, h=frameroddia+frameroddia/2*2);
			translate([smoothroddia/2+frameroddia/2,smoothroddia/2+wall,frameroddia/2+frameroddia/2])rotate([90,0,0])cylinder(r = frameroddia/2+frameroddia/2, h=smoothroddia+wall*2);
			translate([0,-smoothroddia/2-wall,0])cube([frameroddia+smoothroddia/2+frameroddia/2/2, smoothroddia+ wall*2, frameroddia/2 + frameroddia/2]);
			translate([0,-smoothroddia/2-wall,0])cube([frameroddia/2+smoothroddia/2, smoothroddia+ wall*2, frameroddia + frameroddia/2*2]);		
		}

		translate([0,0,-1])poly_cylinder(r = smoothroddia/2, h=frameroddia+frameroddia/2*2+2);	
		translate([smoothroddia/2+frameroddia/2,smoothroddia/2+wall+1,frameroddia/2+frameroddia/2])rotate([90,0,0])poly_cylinder(r = frameroddia/2, h=smoothroddia+wall*2+2);
		translate([0,-smoothroddia/2,-1])cube([frameroddia+smoothroddia/2+frameroddia/2, smoothroddia, frameroddia + frameroddia/2*2+2]);

	}

}
barclamp();
