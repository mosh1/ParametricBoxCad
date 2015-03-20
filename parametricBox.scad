// http://www.thingiverse.com/thing:213934

// ================ variables

//CUSTOMIZER VARIABLES

/* [Main] */

// in mm
x_width=30;

// in mm
y_width=30;

// in mm
height=10;
top_height = 10;

// Wall thickness in mm
thickness=1.2; // [1:10]

lip_height=5;
lip_overlap_height = 5;
lip_thickness=0.8;

snugfit=0.0;

// Corner roundover in mm (0=sharp corner)
radius=5; // [0:50]

// Generate the box
do_box=1; // [0:no,1:yes]

// Generate a lid
do_lid=1; // [0:no,1:yes]


//CUSTOMIZER VARIABLES END

// Screw pilot hole size
screw_pilot=1.125*1;

// Screw hole size
screw_hole=2.5*1;

// Whether you want the screw countersunk
screw_countersink=0*1;

// =============== calculated variables
//lid_height=min(height/4,lip_height);

corner_radius=min(radius,x_width/2,y_width/2);
xadj=x_width-(corner_radius*2);
yadj=y_width-(corner_radius*2);

// =============== program

// ---- The box
box_height_total = height+lip_height;
lip_overlap_cut_total = height - lip_overlap_height;

if(do_box==1) translate([-((x_width/2+1)*do_lid),0,height/2]) difference() {

union() {
minkowski() // main body
{
 cube([xadj,yadj,height],center=true);
 cylinder(r=corner_radius,h=height);
}

translate([0,0,lip_height/2]) minkowski() // main body overlap
{
 cube([xadj-thickness,yadj-thickness,box_height_total],center=true);
 cylinder(r=corner_radius,h=box_height_total);
}
}

// Difference
union() {
translate([0,0,lip_height/2 + thickness]) minkowski() // inside area
{
 cube([xadj-((thickness+lip_thickness+snugfit)),yadj-((thickness+lip_thickness+snugfit)),box_height_total],center=true);
 cylinder(r=corner_radius,h=box_height_total);
}

translate([0,0,lip_overlap_height/2 *-1 - thickness]) minkowski() // inside area
{
 cube([xadj-thickness,yadj-thickness, lip_overlap_cut_total],center=true);
 cylinder(r=corner_radius,h=lip_overlap_cut_total);
}

}

};

// ---- The lid
lid_height_total = top_height;
if(do_lid==1) translate([(x_width/2+1)*do_box,0,lid_height_total/2]) {

difference() {
minkowski() // main body
{
 cube([xadj,yadj,lid_height_total],center=true);
 cylinder(r=corner_radius,h=lid_height_total);
}


translate([0,0,thickness]) minkowski() // inside area
{
 cube([xadj-(thickness-snugfit),yadj-(thickness-snugfit),lid_height_total],center=true);
 cylinder(r=corner_radius,h=lid_height_total);
}
}

};

