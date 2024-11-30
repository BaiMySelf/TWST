
/*
Title: TWST Baffle
Copyright: Jet Flener 2024
Author: Jet Flener - jetflener@ou.edu
License: n/a
Encoding: UTF-8
Version: 0.1.0-alpha
Description: A modified baffle for the TWST machine, for use with the blow dryer fan attachment.
*/



module baffleBase(){
    cylinder(h = 30, r = 2.5, center = true);
    $fn = 20;
}
module baffleTop(){
    cylinder(h = 2.5, d1 = 2.5, d2 = 5, center = true); 
    $fn = 20;
}
module baffleBot(){
    cylinder(h = 2.5, d1 = 5, d2 = 2.5, center = true); 
    $fn = 20;
}
module baffleInner(){
    cylinder(30, 1.25, 1.75, true);
    $fn = 20;
}
module fanHole(){
    union(){
        translate([0, 0, 7.75])cube([2.5, 2.75, 5], center = true);
    
       translate([-1.25, 0, 10]) rotate([90, 0, 90]) cylinder(2.5, r = 1.375, true);
        translate([-1.25, 0, 5.26]) rotate([90, 0, 90]) cylinder(2.5, r = 1.375, true);
    }
    $fn = 20;

}
module ventHole(){
    translate([0, 0, -1])rotate([0, -45, 0])cube([10, 2.5, 8], center = true);
    $fn = 20;
}

module baffle(){
    difference(){
        baffleBase();
        baffleInner();
        //translate([0, 0, 15])baffleTop();
        translate([0, 0, -15])baffleBot();   
        
        // fan holes
        translate([-1.25,0,0])fanHole();
  
        //vent holes
        translate([3.5,0,7.5])ventHole();

    }
}


//need to add connection plate for duct, measure it out too

module ventSide(){
    translate([3.5, 0, 0])   rotate([0, 0, 90]) intersection() {
	baffle();
	translate([1.25, 0, 0]) cube ([2.5, 5, 30], center = true);
    }
}

module fanSide() {
    translate([-3.5, 0, 0])  rotate([0, 0, -90]) intersection() {
	baffle();
	translate([-1.25, 0, 0]) cube ([2.5, 5, 30], center = true);
    }
}




module dF() {
    render(){
       translate ([0, 0, 15]) fanSide();
    }
}

module dV() {
    render(){
        translate ([0, 0, 15]) ventSide();
    }
}

module dB() {
    render(){
       translate ([0, 0, 15]) baffle();
    }
}


//dF();
//dV();
dB();