include <Magpie/magpie.scad>;
include <relations.scad>;

module rider_plate(size,riderRadius,pcb){
	pcbObj = object(pcb);
	union(){
		difference(){
			for(i = [0:90:360])rotate([0,0,i])difference(){
				union(){
					//plate tesselation with cutout for rod
					square([size+riderRadius,size-riderRadius]);
					square([size-riderRadius,size+riderRadius]);
				}
				//holes
				translate([size*2/3,size])poly_circle(r=screwObj[DIAMETER]/2);
				translate([size/3,size])poly_circle(r=screwObj[DIAMETER]/2);
				translate([0,size])poly_circle(r= screwObj[DIAMETER]/2);
				translate([size,0])poly_circle(r= screwObj[DIAMETER]/2);
			}
			//subtract board shape from tesselation
			translate([-pcbObj[BOARD_SIZE][X]/2,-pcbObj[BOARD_SIZE][Y]/2])square([pcbObj[BOARD_SIZE][X],pcbObj[BOARD_SIZE][Y]]);
		}
		//add it back with the holes
		translate([-pcbObj[BOARD_SIZE][X]/2,-pcbObj[BOARD_SIZE][Y]/2])pcb_sketch(pcb);
	}
}

rider_plate(size, riderRadius,pcb);