
// CUSTOMIZER VARIABLES

// in mm
x_width=149;
y_width=87;

bottom_height=140;
// The height of both the bottom and lid is the total height of the box
lid_height = 85;

// Wall thickness in mm
thickness=1.6;

// Height of lip above box top, used for the friction fit
lip_height=8;
// Height of the lip going below box top.
lip_overlap_height = 2;
// Wall thickness of the attachment lip
lip_thickness=0.8;

// Lip outer dimension offset. The larger the number the looser the friction fit.
looseness_offset=0.25;

// Corner radius in mm (0 = sharp corner)
radius=5; 

// Generate the bottom
generate_box=1; // [0:no,1:yes]

// Generate a lid
generate_lid=1; // [0:no,1:yes]


//CUSTOMIZER VARIABLES END

// =============== calculated variables
//lid_height=min(height/4,lip_height);

corner_radius=min(radius,x_width/2,y_width/2);
xadj=x_width-(corner_radius*2);
yadj=y_width-(corner_radius*2);

// =============== program

// ---- The box
box_height_total = bottom_height+lip_height;
lip_overlap_cut_total = bottom_height - lip_overlap_height;

if(generate_box==1) translate([-((x_width/2+1)*generate_lid),0,bottom_height/4]) difference() {

union() {
minkowski() // main body
{
 cube([xadj,yadj,bottom_height/2],center=true);
 cylinder(r=corner_radius,h=bottom_height/2);
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
if(generate_lid==1) translate([(x_width/2+1)*generate_box,0,lid_height/4]) {

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

