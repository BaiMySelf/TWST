/*
Title: Baffle Fan Attachment
Copyright: Jet Flener 2024
Author: Jet Flener - jetflener@ou.edu
License: GNU GPL v3
Encoding: UTF-8
Version: 0.1.0-alpha
Description: A concentrator attachment for the TWST Baffle.

This code has units in cm. Rescale for printing.
*/


module concentrator() {
    //fitting for duct, interior diameter of 5.15 cm (slightly larger than 2 in)
    
    rotate([180,0,0])difference(){
        cylinder(h=2, d=5.8, center=true);
        cylinder(h=2, d1=5.5, d2=5.15, center=true);
    }
    
    
    //dome thing
    difference(){
        //outer
        translate([0,0,1.25])sphere(d=5.8);
        translate([0,0,-0.5])cylinder(h=2.9, d=5.8, center=true);
        
        //inner
        translate([0,0,1.25])sphere(d=5.5);
        translate([0,0,-0.5])cylinder(h=2.75, d=5.5, center=true);
  
        translate([0,0,3])rotate([0,90,0])union(){
            translate([0, 0, 0])cube([4, 2.5, 5], center=true);
            translate([0, 0, 2.5]) rotate([90, 0, 90]) cylinder(h=4, r=1.25, center=true);
            translate([0, 0, -2.5]) rotate([90, 0, 90]) cylinder(h=4, r=1.25, center=true);
        }
        
    }
    
    //slice for extention
    difference(){
        
        //main part
        translate([0,0,3])rotate([0,90,0])union(){
            translate([0, 0, 0])cube([4, 2.75, 5], center=true);
    
            translate([0, 0, 2.5]) rotate([90, 0, 90]) cylinder(h=4, r=1.375, center=true);
            translate([0, 0, -2.5]) rotate([90, 0, 90]) cylinder(h=4, r=1.375, center=true);
        }
        
        translate([0,0,3])rotate([0,90,0])union(){
            translate([0, 0, 0])cube([4, 2.5, 5], center=true);
           translate([-.25, 0, 2.5]) rotate([90, 0, 90]) cylinder(h=4, r=1.25, center=true);
            translate([-0.25, 0, -2.5]) rotate([90, 0, 90]) cylinder(h=4, r=1.25, center=true);
        }
        
        //cut inside sphere
        translate([0,0,1.25])sphere(d=5.5);
        translate([0,0,-0.5])cylinder(h=2.75, d=5.5, center=true);
  
    }
    
    //cut excess(tbd)
     
    
    $fn = 20;
    
}

render() {
    concentrator();
}