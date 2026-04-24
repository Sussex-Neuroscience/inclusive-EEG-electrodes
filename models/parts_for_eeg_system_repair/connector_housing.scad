// a connector housing for the EEG electrode harness
// CC BY SA 4.0 Andre M Chagas 04/04/2022

conThick = 5.6;
conLen = 48;
conHei = 5.1;



bodyThick = 3.5;
bodyLen = 53.25;
bodyHei = 7;

tol = 0.12;
$fn=30;

screwD = 3;
cableD=5.1;

module connector(){
    translate([0,conThick-2,0]){
    cube([conLen+2*tol,conThick+2*tol,conHei+2*tol],center=true);
    }//end translate
    cube([bodyLen+2*tol,bodyThick+2*tol,bodyHei+2*tol],center=true);
    
   
}//end module

module housing(){
difference(){
cube([bodyLen+2*tol+2*screwD+10,bodyThick+2*tol+25,bodyHei+2*tol+4],center =true);

translate([0,+12,0]){
    connector();
}//end translate
translate([0,0,0]){
    cube([bodyLen+2*tol-4,bodyThick+2*tol+18,bodyHei+2*tol-0.5],center=true);
}//end translate
//translate([2,2,3]){
//cube([bodyLen+2*tol,bodyThick+2*tol+10,bodyHei-2]);
//}//end translate
translate([bodyLen/2+4,0,-8]){
    cylinder(d=screwD+2*tol,h=bodyHei+10);
}//end translate

translate([-(bodyLen/2+4),0,-8]){
    cylinder(d=screwD+2*tol,h=bodyHei+10);
}//end translate

translate([0,-5,0]){
rotate([90,0,0]){
    cylinder(d=cableD+2*tol,h=10);
    }//end rotate
}//end translate
}//end difference
}//end module

difference(){
housing();
translate([0,0,(bodyHei+2*tol+4)/2]){
cube([bodyLen+2*tol+2*screwD+11,bodyThick+2*tol+26,bodyHei+2*tol+4],center =true);
}
}//end difference()