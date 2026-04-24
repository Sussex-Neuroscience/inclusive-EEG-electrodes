//use <C:\Users\Andre Maia Chagas\Documents\OpenSCAD\libraries\threadlib\threadlib.scad>

include <electrodes.scad>

tipL = 20;
clipL = 60-2*tipL;//80;
clipW = 9;
clipH = 1.5;
clipHD = 26;


//information for the cup_electrode (some taken from the electrodes.scad file)

electrodOD1 = electrodeOD_large; 

//information for the original clip
//gel_thread_specs= thread_specs("M12-ext");
//P = gel_thread_specs[0];
//Dsupport = gel_thread_specs[2];
gelBD = electrodeOD+5;
//gelCD = Dsupport;
gelCHole = electrodeOD-cupD;
gelH = 12;

//information for the holder itself
holderH=5;
holderD=10;
//diameter of the holes to pass hair through
hairHD=4;


tol = 0.1;
$fn=40;





module ring(outerD=10,innerD=9,hei=10){
    difference(){
        cylinder(d=outerD,h=hei);
        translate([0,0,-1]){
            cylinder(d=innerD,h=hei+2);    
            }//end translate
        }// end difference
    }//end module

module ring_slits(nSlits=3,outerD=10,hei=10){
    difference(){
    ring(outerD=outerD,innerD=outerD-hairHD,hei=hei);
    for ( i = [0:360/nSlits:360] ){
        rotate([0,0,i]){
            translate([-0.75,0,-1]){
            cube([1.5,outerD+2,hei+2]);
            }//end translate
            }//end rotate
        }//end for
    }//end difference
    }//end module

//ring_slits();
/*
module quarter_ring(outerD=10,innerD=9,hei=10){
    difference(){
        ring(outerD=outerD,innerD=innerD,hei=hei);
        union(){
            translate([-outerD/2-1,0,-1])
                cube([(outerD+2),(outerD+1)/2,hei+2]);
            translate([0,-outerD/2-1,-1])
                cube([(outerD+2)/2,(outerD+2),hei+2]);
        }//end union
    }//end difference
    }//end module

quarter_ring();
    */
module simple_holder_flex(){
    difference(){
        cylinder(d=electrodOD1+2,h=5);
        translate([0,0,0.3]){
            cup_electrode_large();
            }//end translate
        translate([0,0,-1]){
            cylinder(d=electrodOD1-2,h=10);
            }//end translate
        translate([3,-2,0.4]){
            cube([4,4,10]);
            }//end translate
    }//end difference
}// end module

module simple_holder_rigid(){

    difference(){
        cylinder(d=electrodOD1+2,h=5);
//        translate([0,0,0.4]){
//            cup_electrode_large();
//            }//end translate
            translate([0,0,0.4]){
            cylinder(d=electrodOD1+0.1,h=20);
            }//end translate
        translate([0,0,-1]){
            cylinder(d=electrodOD1-4,h=10);
            }//end translate
        //translate([1.5,-3.5,0.4]){
            //%cube([7,7,10]);
            //}//end translate
        translate([3,-1.75,0.5]){
            cube([5,3.5,6]);
            }//end translate
    }//end difference
translate([0,15,0]){
difference(){
    cylinder(d=electrodOD1+0.2,h=6);
    translate([0,0,-0.5]){
    cylinder(d=electrodOD1+0.5-4,h=7);
}
     translate([1.5,-2,-.4]){
     cube([7,4,10]);
     }//end translate
}//end difference
}//end translate

}// end module

module attachment_arm(){    

   hull(){
        resize([clipL+2*tipL,clipW,clipH*2+1]){
        sphere(d=1);
        }  
     
    translate([clipL/2+tipL/3,0,-clipH/2]){
        resize([tipL,clipW-2.5,clipH]){
        cylinder(d=1,h=1,$fn=3);
        }//resize
    }//translate
     translate([-clipL/2-tipL/3,0,clipH/2]){
        resize([tipL,clipW-2.5,clipH]){
            rotate([0,180,0]){
            cylinder(d=1,h=1,$fn=3);
            
            }//rotate
        }//resize
    }//translate

}//end hull

}//module





module electrode_cap(){
    difference(){
    cylinder(d=gelCD+5,h=4.3);
        translate([0,0,0]){
    tap("M12",turns=3);
        }//end translate
    }//end difference
    
    }// end module electrode_cap
    
module gel_holder(){


    difference(){
        union(){
        cylinder(d=gelBD,h=2);
        cylinder(d=gelCD,h=gelH);
        }//end union
        translate([0,0,-1]){
    cylinder(d=gelCHole,h=gelH+2);
        }//end translate
        translate([0,0,-0.1]){
        electrode_positive();
        }//end translate
        }//end difference
    translate([0,0,3.9]){
    thread("M12-ext",turns=4);
    }//end translate
  
    }// end module gel_holder

module clip_attachments(){
   difference(){
    union(){
    for ( y = [-0.5:0.5] ){
      translate([0,y*clipW+(y*0.5),0]){ 
        attachment_arm();
}//end translate
}//end for
centralBlock = 2*clipW-2;
translate([-(centralBlock+4)/2,-(centralBlock)/2,-clipH/2-0.5]){
cube([centralBlock+4,centralBlock,clipH+1]);

}//end translate
}//end union
        translate([-1,0,-2*clipH]){    
        //translate([0,0,-.5]){    
        cylinder(d=11+tol,h=4*clipH);
        //    tap("M12",turns=2);
        }//end translate
        translate([-(clipL+2*tipL)/2-1,-1.5*clipW,-6.8]){
            cube([clipL+2*tipL+2,clipW*3,6]);
}//end translate
translate([-2,-5,0]){
cube([11,10,10]);
}//end translate
    }//end difference

}//end module clip_attachments



module flex_electrode_holder_base(){
difference(){
    cylinder(d=electrodOD1+hairHD+holderD,h=0.8);
    translate([0,0,-0.2]){
        cylinder(d=electrodOD1-1,h=10);

        }//end translate
    translate([0,0,0.2]){
        cup_electrode_large();
    }//end translate
    for ( i = [45:45:360] ){
        translate([((holderD+hairHD)/2+2)*cos(i), ((holderD+hairHD)/2+2)*sin(i), -tol]){
            rotate([0, 0, 0]){
    
                cylinder(d = hairHD,h=holderH+2);
            }//end rotate
        }//end translate
    }//end for
    }//end difference
}//end module

module flex_holder_base_long_slit(){
difference(){
    cylinder(d=electrodOD1+hairHD+holderD,h=0.8);
    
    
    
    translate([0,0,-0.2]){
        rotate([0,0,45]){
        ring_slits(nSlits=5,outerD=electrodOD1+holderD,hei=5);
        }//end rotate
        cylinder(d=electrodOD1-1,h=10);

        }//end translate
    translate([0,0,0.2]){
        cup_electrode_large();
    }//end translate
    //for ( i = [45:45:360] ){
    //    translate([((holderD+hairHD)/2+2)*cos(i), ((holderD+hairHD)/2+2)*sin(i), -tol]){
    //        rotate([0, 0, 0]){
                
                //cylinder(d = hairHD,h=holderH+2);
    //        }//end rotate
    //    }//end translate
    //}//end for
    }//end difference
}//end module

/////// flex holder /////////////////

    
translate([-10,20,-0.8]){
simple_holder_flex();
flex_holder_base_long_slit();
       }


//////////////////////////

////////// original holder ////////////////
/*
clip_attachments();
    translate([-1,0,-0.8]){
simple_holder_rigid();
        //cup_electrode_large();
    }//end translate
*/

////////////////////////////////////////////
////////////////////////////////////////////
////////////////////////////////////////////





/*
module cup_electrode_holder_cap(){


difference(){
cylinder(d=electrodeOD+4,h=electrodeH+2);
    union(){
        translate([0,0,-tol])
cup_electrode();
    sphere(d=cupD);
cylinder(d=2,h=electrodeH+5);
    }//end union
}//end difference

}//end module
*/
/*
module cup_electrode_holder(){
difference(){
    union(){
    cylinder(d=holderD,h=holderH-2.3);
    cylinder(d=holderLargeD,h=1);    
    }//end union
    translate([0,0,-tol]){
        cup_electrode_large();
        sphere(d=cupD);
    }//end translate
for ( i = [65:45:360+25] ){
    translate([(holderD+hairHD)/2*cos(i), (holderD+hairHD)/2*sin(i), -tol]){
    rotate([0, 0, 0]){
    
    cylinder(d = hairHD,h=holderH+2);
    }//end rotate
    }//end translate
}//end for
}//end difference

}//end module
*/
/*
module solid_electrode_holder(){
difference(){
    union(){
    cylinder(d=holderD,h=holderH);
    cylinder(d=holderD+5,h=1);    
    }//end union
    translate([0,0,-tol]){
        solid_electrode();
    }//end translate
for ( i = [65:45:360+25] ){
    translate([((holderD+5)/2-hairHD)*cos(i), ((holderD+5)/2-hairHD)*sin(i), -tol]){
    rotate([0, 0, 0]){
    
    cylinder(d = hairHD,h=holderH+2);
    }//end rotate
    }//end translate
}//end for
}//end difference

}//end module
*/

/*
module initial_holder(){
    electrode_cap();
    translate([0,30,0]){
    gel_holder();
    //cup_electrode();
    }//end translate
    translate([-0,-30,2]){
    clip_attachments();
    }//end translate
    }//end module

//solid_electrode_holder();
//initial_holder();
*/


/*
difference(){
translate([0,0,-0.2])
cup_electrode_holder_base();
cup_electrode_holder_cap();
    }

    translate([20,10,0])
  cup_electrode_holder_cap();
    
*/    

/*
module attachment_arm_legacy(){    
    union(){
    hull(){
    cube([clipL,clipW,clipH],center=true);
        resize([clipL+1*tipL,clipW,clipH*2+2]){
        sphere(d=1);
        }  
     
    translate([clipL/2+tipL/3,0,-clipH/2]){
        resize([tipL,clipW,clipH]){
        cylinder(d=1,h=1,$fn=3);
        }//resize
    }//translate
     translate([-clipL/2-tipL/3,0,clipH/2]){
        resize([tipL,clipW,clipH]){
            rotate([0,180,0]){
            cylinder(d=1,h=1,$fn=3);
            
            }//rotate
        }//resize
    }//translate
}
}//end union
}//module
   */
   