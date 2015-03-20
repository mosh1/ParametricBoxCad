// http://www.thingiverse.com/thing:213934

// ================ variables

//CUSTOMIZER VARIABLES

/* [Main] */

// in mm
x_width=149.5;
y_width=97;

height=140;
lid_height = 85;

// Wall thickness in mm
thickness=1.0; // [1:10]

// Box lip parameters
lip_height=5;
lip_overlap_height = 2;
lip_thickness=0.8;

looseness_offset=0.25;

// Corner roundover in mm (0=sharp corner)
radius=5; // [0:50]

// Generate the box
do_box=1; // [0:no,1:yes]

// Generate a lid
do_lid=1; // [0:no,1:yes]


//CUSTOMIZER VARIABLES END

// =============== calculated variables
//lid_height=min(height/4,lip_height);

corner_radius=min(radius,x_width/2,y_width/2);
xadj=x_width-(corner_radius*2);
yadj=y_width-(corner_radius*2);

// =============== program

// ---- The box
box_height_total = height+lip_height;
lip_overlap_cut_total = height - lip_overlap_height;

if(do_box==1) translate([-((x_width/2+1)*do_lid),0,height/4]) difference() {

union() {
minkowski() // main body
{
 cube([xadj,yadj,height/2],center=true);
 cylinder(r=corner_radius,h=height/2);
}

translate([0,0,lip_height/2]) minkowski() // inner body with lip
{
 cube([xadj-(thickness+looseness_offset)*2,yadj-(thickness+looseness_offset)*2,box_height_total/2],center=true);
 cylinder(r=corner_radius,h=box_height_total/2);
}
}

// Difference
union() {
translate([0,0,lip_height/2 + thickness]) minkowski() // inside area
{
 cube([xadj-((thickness+lip_thickness+looseness_offset)*2),yadj-((thickness+lip_thickness+looseness_offset)*2),box_height_total/2],center=true);
 cylinder(r=corner_radius,h=box_height_total/2);
}

translate([0,0,lip_overlap_height/2 *-1 + thickness]) minkowski() // cut out even more to make connector lip only go so deep
{
 cube([xadj-thickness*2,yadj-thickness*2, lip_overlap_cut_total/2],center=true);
 cylinder(r=corner_radius,h=lip_overlap_cut_total/2);
}
}

};

// ---- The lid
if(do_lid==1) translate([(x_width/2+1)*do_box,0,lid_height/4]) {

difference() {
minkowski() // main body
{
 cube([xadj,yadj,lid_height/2],center=true);
 cylinder(r=corner_radius,h=lid_height/2);
}


translate([0,0,thickness]) minkowski() // inside area
{
 cube([xadj-thickness*2,yadj-thickness*2,lid_height/2],center=true);
 cylinder(r=corner_radius,h=lid_height/2);
}
}

};

