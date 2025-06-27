


//capfixer pin

baseD=8;
baseH=1;
neckD= 3.5;//thin value -> 2.85;
neckH=5;
neckDH= 2.75;//thin value -> 2.25;
$fn=60;

difference(){
union(){
cylinder(d=baseD,h=baseH);
cylinder(d=neckD,h=neckH);
}//union

translate([0,0,-1]){
cylinder(d=neckDH,h=10);
}//translate
}//difference
