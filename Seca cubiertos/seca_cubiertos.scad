// Longitud de cuerda
c = 193/2;
// Longitud de semi-cuerda
a = 97;
// Distancia entre cuerda y borde exterior
b = 24;
// ancho total
d = 68;

// grosor
g = 6;

// Calculo del radio
// La pendiente de la semicuerda es c/b
// r^2 = c^2 + (c * c/b)^2
r = sqrt(c*c + ((c*c/b)*(c*c/b)));

module base(rad,grueso){
    difference(){
        translate([0,-rad+d-grueso/2,0]) difference(){
            cylinder(h=12, r=rad, center=false, $fn=100);
            translate([-1.5*rad,-rad-d+grueso,-5]) cube([3*rad,2*rad,30]);
        }
        union(){
        translate([99-grueso/2,-5,-5]) cube([400,80,60]);
        translate([-400-(99-grueso/2),-5,-5]) cube([400,80,60]);
        }
    }
}

module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
       
       // preview unfolded (do not include in your function
       z = 0.08;
       separation = 2;
       border = .2;
       translate([0,w+separation,0])
           cube([l,w,z]);
       translate([0,w+separation+w+border,0])
           cube([l,h,z]);
       translate([0,w+separation+w+border+h+border,0])
           cube([l,sqrt(w*w+h*h),z]);
       translate([l+border,w+separation+w+border+h+border,0])
           polyhedron(
                   points=[[0,0,0],[h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[h,0,z],[0,sqrt(w*w+h*h),z]],
                   faces=[[0,1,2], [3,5,4], [0,3,4,1], [1,4,5,2], [2,5,3,0]]
                   );
       translate([0-border,w+separation+w+border+h+border,0])
           polyhedron(
                   points=[[0,0,0],[0-h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[0-h,0,z],[0,sqrt(w*w+h*h),z]],
                   faces=[[1,0,2],[5,3,4],[0,1,4,3],[1,2,5,4],[2,0,3,5]]
                   );
       }

difference(){
    base(round(r),0);
    union(){
        translate([0,0,2]) base(round(r)-g, g);
        //translate([0,0,-10]) base(round(r)-g, g);
        translate([90,20,-25]) cube([2,10,50]);
        translate([-92,20,-25]) cube([2,10,50]);
    }
}
translate([50,2,2]) cube([2,50,2]);
translate([-50,2,2]) cube([2,50,2]);
translate([0,2,2]) cube([2,55,2]);
translate([-85,25,2]) cube([170,2,2]);

//pestañas
translate([-10,d-7,9]) prism(20,6,3.5);
rotate(5) translate([-50,d-7,9]) prism(20,6,3.5);
rotate(-5) translate([30,d-7,9]) prism(20,6,3.5);
translate([10,7,9]) rotate(180) prism(20,5,3.5);
translate([70,7,9]) rotate(180) prism(20,5,3.5);
translate([-50,7,9]) rotate(180) prism(20,5,3.5);

//regla
//translate([-95,8,15]) cube ([190,2,2]);
//translate([0,4,15]) cube ([2,60,2]);
