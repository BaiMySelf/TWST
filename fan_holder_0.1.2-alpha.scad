 /*
Title: Hair Dryer Fan Holder Base
Copyright: Jet Flener 2024
Author: Jet Flener - jetflener@ou.edu
License: GNU GPL v3
Encoding: UTF-8
Version: 0.1.0-alpha
Description: An adapter to hold a hair dryer fan, for use with a duct.

This code has units in cm. Rescale for printing. The original design for the mount is taken from OPENSCAD Library file by the DoomMeister Mounting surround for small DC fans (25 - 120mm).  Clamps require an M3 bolt.
*/

//render everything
render(){
    difference(){
        fan_mount(size=10,thick=4);
        
         translate([5, 10, 0])rotate([90, 0, 0])fanBaseCutOut();
            translate([0, 5, 0])rotate([90, 0, 90])fanBaseCutOut();
        
    }
    
    //use the translates to adjust viewing positions
    translate([0, 0, 5])fanDuctBasePlate();
    translate([0, 0, 7])fanDuct();
    translate([0, 0, 9])fanDuctRotate();
    
    //translate([8,5,25])rotate([0, -90, 90])curved_cylinder(5.8, 5.5);
    
}

module fanBaseCutOut(){
    cylinder(h=10, r = 3);
    $fn=20;
}
module fanDuctBasePlate(){
    
    difference(){
        roundedcube([10, 10, 1], radius = 0.35/2, apply_to = "z");
        translate([5, 5, 0])cylinder(h=1, d=7.25);
        translate([1, 1, 0.5])fanDuctBasePlateMountingHoles(); 
        fanDuctBasePlateClampHole();
    }
    
    
    $fn = 20; 
}

module fanDuctBasePlateMountingHoles(){
    translate([0, 0, 0])cylinder(h=1, d=0.35, center=true);
    translate([0, 8, 0])cylinder(h=1, d=0.35, center=true);
    translate([8, 0, 0])cylinder(h=1, d=0.35, center=true);
    translate([8, 8, 0])cylinder(h=1, d=0.35, center=true);
}
module fanDuctBasePlateClampHole(){
    //M6 screw
    translate([5, 5, 0.5])rotate([90,0,0])cylinder(h=10,d=0.6,center=true);

   
}
module fanDuct(){
    translate([5, 5, 0])difference(){
        cylinder(h=16, d1=7.8, d2=5.8);
        cylinder(h=16, d1=7.5, d2=5.5);
        
    }
   
    $fn = 20;
}

module fanDuctRotate(){
     //fitting for duct, interior diameter of 5.15 cm (slightly larger than 2 in)
    translate([5,5,16])difference(){
        cylinder(h=2, d=5.8, center=true);
        cylinder(h=2, d1=5.5, d2=5.15, center=true);
    }
    $fn = 20;
}
module curved_cylinder(outer_diameter, inner_diameter, angle=90) {

    height = 10;

    outer_radius = outer_diameter / 2;
    inner_radius = inner_diameter / 2;


    difference() {
        // Outer curved shape (this will be the outer part of the ring)
        rotate_extrude(angle=angle) {
            translate([outer_radius, 0, 0]) 
                circle(outer_radius);
        }
        
        // Inner curved shape (cutout for the hollow cylinder)
        rotate_extrude(angle=angle) {
            translate([inner_radius, 0, 0]) 
                circle(inner_radius);
        }
    }
    
    
    $fn = 20;
}

































//rounded cube for jet
// Higher definition curves
//$fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
    $fs = 0.1;
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}


//fan stuff
module fan_mount(size=40,thick = 4)
{
if(size == 18)
    {
	_fan_mount(
			fan_size = 18,
			fan_mounting_pitch = 15.22,
			fan_m_hole_dia = .35,
			holder_thickness = thick
		 );
	}
if(size == 10)
	{
	_fan_mount(
			fan_size = 10,
			fan_mounting_pitch = 8,
			fan_m_hole_dia = .35,
			holder_thickness = thick
		 );
	}
if(size == 30)
	{
	_fan_mount(
			fan_size = 30,
			fan_mounting_pitch = 24,
			fan_m_hole_dia = 3,
			holder_thickness = thick
		 );
	}

if(size == 40)
	{
	_fan_mount(
			fan_size = 40,
			fan_mounting_pitch = 32,
			fan_m_hole_dia = 3.5,
			holder_thickness = thick
		 );
	}
if(size == 45)
	{
	_fan_mount(
			fan_size = 45,
			fan_mounting_pitch = 37,
			fan_m_hole_dia = 4.3,
			holder_thickness = thick
		 );
	}
if(size == 60)
	{
	_fan_mount(
			fan_size = 60,
			fan_mounting_pitch = 50,
			fan_m_hole_dia = 4.4,
			holder_thickness = thick
		 );
	}
if(size == 80)
	{
	_fan_mount(
			fan_size = 80,
			fan_mounting_pitch = 71.5,
			fan_m_hole_dia = 4.4,
			holder_thickness = thick
		 );
	}

if(size == 120)
	{
	_fan_mount(
			fan_size = 120,
			fan_mounting_pitch = 105,
			fan_m_hole_dia = 4.4,
			holder_thickness = thick
		 );
	}
}


//inner module
module _fan_mount(
			fan_size, //nominsl size of fan
			fan_mounting_pitch, //pitch between mounting holes
			fan_m_hole_dia, //mounting hole diameter
			holder_thickness //user defined thickness
		 )
{

offset1 = (fan_size-(fan_mounting_pitch + fan_m_hole_dia))/2;
offset2 = (fan_size-(fan_mounting_pitch))/2;
offset3 = offset2 + fan_mounting_pitch;
thickness = (fan_size-fan_mounting_pitch)/2;	
			
			//difference()
			//{
			linear_extrude(height = holder_thickness)
			union()
			{	
			difference()
			{
				translate([fan_m_hole_dia/2,fan_m_hole_dia/2,0])
				minkowski()
				{	
					square([fan_size - fan_m_hole_dia,fan_size - fan_m_hole_dia]);
					circle(r= fan_m_hole_dia/2, $fn=20);
				}
			
					translate([offset1,offset1,0])
					square([fan_mounting_pitch + fan_m_hole_dia,fan_mounting_pitch + fan_m_hole_dia]);
				}
				translate([offset2,offset2,0])
				rotate([0,0,0])_corner_hole();
				translate([offset3,offset2,0])
				rotate([0,0,90])_corner_hole();
				translate([offset2,offset3,0])
				rotate([0,0,90])_corner_hole();
				translate([offset3,offset3,0])
				rotate([0,0,0])_corner_hole();
			}

module _corner_hole()
{
				difference(){
					union(){
							difference(){
							square([fan_m_hole_dia + thickness,fan_m_hole_dia + thickness],center=true);
							square([(fan_m_hole_dia + thickness)/2,(fan_m_hole_dia + thickness)/2],center=false);
							translate([-(fan_m_hole_dia + thickness)/2,-(fan_m_hole_dia + thickness)/2])
							square([(fan_m_hole_dia + thickness)/2,(fan_m_hole_dia + thickness)/2],center=false);
							}
					circle(r=(fan_m_hole_dia + thickness)/2, $fn=20);
					}
					circle(r=(fan_m_hole_dia)/2, $fn=20);
				}
}


echo(offset1,offset2,thickness);
}


