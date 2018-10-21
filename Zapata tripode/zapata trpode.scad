module grid() {

//------------parameters---------------------------
// overall size of X dimension
gridX=50;  
// overall size of Y dimension
gridY=50;  
// X border size
borderX=0;  
// Y border size
borderY=0;  
// width of solid part of grid
meshSolid=0.5;
// width of blank part of grid 
meshSpace=2;  
// thickness in Z direction
thickness=1;  

//-------------------------------------------------
meshX=gridX-(borderX*2);
meshY=gridY-(borderY*2);
nX=meshX/(meshSolid+meshSpace);
nY=meshY/(meshSolid+meshSpace);

//difference() {
//cube (size=[gridX,gridY,thickness],center=false);
//cube (size=[meshX,meshY,thickness],center=false);
//}

for (i=[0:nX]) {
	 	 translate([i*(meshSolid+meshSpace)-25,-25,9]) cube(size=[meshSolid,meshY,thickness],center=false);
}

for (i=[0:nY]) {
	 	translate([-25,i*(meshSolid+meshSpace)-25,9]) cube(size=[meshX,meshSolid,thickness],center=false);

}

}

module base(){

    difference(){
        union() {
            translate([0,0,1]) cube(size = [41.5,41.5,2], center = true);
            translate([0,0,2]) rotate(45) cylinder(h=8, r1=sqrt(41.5*41.5/4 + 41.5*41.5/4), r2= sqrt(33*33/4 + 33*33/4), $fn=4);
        }
    
        rotate(45) cylinder(h=8, r1=sqrt(33*33/4 + 33*33/4), r2= sqrt(29*29/4 + 29*29/4), $fn=4);
    }
}

difference(){
    difference(){
        base();
        rotate(45) grid();
    }
    cylinder(h=20, r=3, $fn=100);
}


 