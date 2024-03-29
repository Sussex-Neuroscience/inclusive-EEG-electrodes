/*
inclusive electrode holders for eeg research
created by AM Chagas 20211006
CC BY SA 4.0
*/
//tolerance
tol = 0.1;

//number of facets in a cylinder
$fn=40;

//cable information
cableD = 3.5;
cableH  = 20;

//solid electrode information
electD = 8;
electH = 5;



//cup electrode information
//internal diameter of the cup
//large electrode
cupD_large = 8.80;
//small electrode
cupD = 4.7;
//border Diameter around the cup
//large electrode
//borderD_large  = 2;
borderD  = 2;
//the diameter of the entire electrode
//large electrode
electrodeOD_large = cupD_large+borderD;
//small electrode
electrodeOD = cupD+borderD;

//hole on top of cup
electrodeOpening = 1.6;

electrodeH = 0.8;

electrodeT = 0.85;



module solid_electrode(){
    cylinder(d=electD,h=electH);
    translate([0,0,electH/2]){
    rotate([0,90,0]){
        
        cylinder(d=cableD,h=cableH);
        }//end translate
        }//end rotate
        
}//end electrode


module electrode_positive_large(){
    cylinder(d=electrodeOD_large,h=electrodeT);
    sphere(d=cupD_large);
        
    translate([2,0,cableD/2-1]){
        rotate([0,90,0]){
            cylinder(d=cableD,h=cableH);
            }//end rotate
        }//end translate
    }//end module

module electrode_negative_large(){
    cylinder(d=electrodeOpening,h=electrodeH+5);
        translate([0,0,-electrodeT]){
            sphere(d=cupD_large-electrodeT);
            }//end translate
        translate([-electrodeOD_large/2-1,-electrodeOD_large/2-1,-electrodeOD_large+0.01]){
            cube([electrodeOD_large+2,electrodeOD_large+2 ,electrodeOD_large]);
            }//end translate
    }//end module


module electrode_positive_small(){
     cylinder(d=electrodeOD,h=electrodeT);
        sphere(d=cupD);
        
            translate([2,0,cableD/2-1]){
                 rotate([0,90,0]){
            cylinder(d=cableD,h=cableH);
                 }//end rotate
                //cube([cableX,cableY,electrodeT+1]);
        }//end translate
    }//end module

module electrode_negative_small(){
    cylinder(d=electrodeOpening,h=electrodeH+5);
        translate([0,0,-electrodeT]){
        
            sphere(d=cupD-electrodeT);
        }//end translate
        translate([-electrodeOD/2-1,-electrodeOD/2-1,-electrodeOD+0.01]){
            cube([electrodeOD+2,electrodeOD+2 ,electrodeOD]);
            }//end translate
    }//end module
    
module cup_electrode_small(){

difference(){    
    electrode_positive_small();
    electrode_negative_small();
    

    }//end difference
}//end electrode module

module cup_electrode_large(){

difference(){    
    electrode_positive_large();
    electrode_negative_large();
    

    }//end difference
}//end electrode module


//translate([0,30,0]){
//cup_electrode();
//}// end translate
//solid_electrode();

//cup_electrode_large();
//cup_electrode_small();
