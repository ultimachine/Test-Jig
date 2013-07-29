include <Magpie/magpie.scad>;

difference(){
	cylinder(r=5, h=21);
	translate([0,0,-eta])poly_cylinder(r=M3[DIAMETER]/2,h=21+eta*2);
}