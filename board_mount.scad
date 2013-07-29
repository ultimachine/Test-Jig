include <Magpie/magpie.scad>;
include <relations.scad>;
use <middle_clamp.scad>;

//For boards with non-squarely-aligned holes a left and right side will need to be generated. I am being lazy for now. 

module board_mount(pcb, length, clampRadius, rodDia, height, holes, screw, truss_width, debug=0){
	pcbObj = object(pcb);
	screwObj = object(screw);
	difference(){
		union(){
			middle_clamp(length, clampRadius, rodDia, height, holes, screwObj[DIAMETER], debug);
			
			hull(){
				//First PCB hole
				translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES][X],length/2-pcbObj[BOARD_SIZE][Y]/2+pcbObj[BOARD_HOLES][Y],0])cylinder(r=truss_width/2, h=height);
				translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES][X],truss_width/2,0])cylinder(r=truss_width/2, h=height);

			}

			hull(){
				//Second PCB hole
				translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES+1][X],length/2-pcbObj[BOARD_SIZE][Y]/2+pcbObj[BOARD_HOLES+1][Y],0])cylinder(r=truss_width/2, h=height);
				translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES+1][X],truss_width/2,0])cylinder(r=truss_width/2, h=height);
			}
		}

		//board outline
		#translate([length/2-pcbObj[BOARD_SIZE][X]/2,length/2-pcbObj[BOARD_SIZE][Y]/2])square([pcbObj[BOARD_SIZE][X],pcbObj[BOARD_SIZE][Y]]);

		//First PCB hole
		translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES][X],length/2-pcbObj[BOARD_SIZE][Y]/2+pcbObj[BOARD_HOLES][Y],-eta])
			poly_cylinder(r=pcbObj[BOARD_HOLES][HOLE_DIAMETER]/2, h=height+eta*2);

		//Second PCB hole
		translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES+1][X],length/2-pcbObj[BOARD_SIZE][Y]/2+pcbObj[BOARD_HOLES+1][Y],-eta])
			poly_cylinder(r=pcbObj[BOARD_HOLES+1][HOLE_DIAMETER]/2, h=height+eta*2);

		//one tab hole
		translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES][X], clampRadius,-eta])
			poly_cylinder(r=pcbObj[BOARD_HOLES][HOLE_DIAMETER]/2, h=height+eta*2);

		//two tab hole
		translate([length/2-pcbObj[BOARD_SIZE][X]/2+pcbObj[BOARD_HOLES+1][X], clampRadius,-eta])
			poly_cylinder(r=pcbObj[BOARD_HOLES+1][HOLE_DIAMETER]/2, h=height+eta*2);

	}
}

translate([size*2,size*2,0])rotate([0,0,180])board_mount(pcb, size*2, baseRadius, linearBearingObj[INNER_DIAMETER], 10, 5, screw, 15);
board_mount(pcb, size*2, baseRadius, linearBearingObj[INNER_DIAMETER], 10, 5, screw, 15);