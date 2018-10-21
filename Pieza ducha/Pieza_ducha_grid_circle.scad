module grid() {

//------------parameters---------------------------
// overall size of X dimension
gridX=200;  
// overall size of Y dimension
gridY=200;  
// X border size
borderX=0;  
// Y border size
borderY=0;  
// width of solid part of grid
meshSolid=0.5;
// width of blank part of grid 
meshSpace=2;  
// thickness in Z direction
thickness=2;  

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
	 	 translate([i*(meshSolid+meshSpace),0,0]) cube(size=[meshSolid,meshY,thickness],center=false);
}

for (i=[0:nY]) {
	 	translate([0,i*(meshSolid+meshSpace),0]) cube(size=[meshX,meshSolid,thickness],center=false);

}

}

module base() {
    p_ext = [[50, 0], [180, 0], [160,80], [126, 126], [80,160], [0, 180], [0, 50]];
    p_tri_ext = [[0,0], [50, 0], [0, 50]];
    p_int = [[60, 5], [175, 5], [156,78], [123, 123], [78,156], [5, 175], [5, 60]];
    p_tri_int = [[0,0], [65, 0], [0, 65]];
    
    difference() {
        linear_extrude(height = 35)
            difference() { 
                intersection(){square(180);circle(180, $fn=50);}
                polygon(points = p_tri_ext);
            }
             
        translate([0,0,-5]) linear_extrude(height = 45)
            difference() {
               difference() { 
                  intersection(){square(175);circle(175, $fn=50);}
                  polygon(points = p_tri_int);
               }
               union() {
                   square(size=[200,5],center=false);
                   square(size=[5,200],center=false);
               }
            } 
        }
}

union() {
    difference() {
        base();

        translate([28,28,-2]) rotate(-45) linear_extrude(height = 32)  union() {
        p4 = [[-14, -2], [14, -2], [14, 2], [-14, 2]];
        polygon(points = p4);
        p5 = [[-8.5, -6], [8.5, -6], [8.5, -2], [-8.5, -2]];
        polygon(points = p5);

        }

    }
 
    intersection() {
      
       
       grid(); 
        
        p_tri_int = [[0,0], [65, 0], [0, 65]];
        translate([0,0,-5]) linear_extrude(height = 45)
            difference() {
               difference() { 
                  intersection(){square(175);circle(175, $fn=50);}
                  polygon(points = p_tri_int);
               }
               union() {
                   square(size=[200,5],center=false);
                   square(size=[5,200],center=false);
               }
            } 
        
    }
    
}
