/******************************************************************************/
/*
  This file is part of the package helping-mic. It is subject to the
  license terms in the LICENSE file found in the top-level directory
  of this distribution and at:

    https://github.com/pjones/helping-mic

  No part of this package, including this file, may be copied, modified,
  propagated, or distributed except according to the terms contained in
  the LICENSE file.
*/

/******************************************************************************/
stand_id = 15.25;               /* Diameter of mic stand post.       */
stand_height = 12.0;            /* How tall to make the stand hole.  */
thickness = 5.75;               /* Thickness of all parts.           */
mount_hole_height = 2.0;        /* Depth of the mounting bump/peg.   */
mount_hole_id = 4.25;           /* Diameter of the HH mounting hole. */
mount_hole_offset = 5;          /* Max distance: bump to outside.    */

/******************************************************************************/
mount_height = stand_height;
base_od = stand_id * 4;
stand_od = stand_id + (thickness * 2);

/******************************************************************************/
$fa = 1.0;
$fs = 0.5;

/******************************************************************************/
module base() {
    cylinder(h=thickness, d=base_od);

    translate([0, 0, thickness])
    difference() {
        union() {
            cylinder(h=stand_height, d=stand_od);
        }
        cylinder(h=stand_height, d=stand_id);
    }
}

/******************************************************************************/
module support(angle) {
    translate([0, 0, stand_height/2 + thickness])
    rotate([0, 0, angle])
    hull() {
        translate([stand_od/2 - 0.5, 0, 0])
        cube([0.1, thickness, stand_height], center=true);

        translate([base_od/2, 0, -(stand_height/2)])
        cube([0.1, thickness, 0.1], center=true);
    }
}

/******************************************************************************/
module mount(angle) {
    length = (base_od - stand_od) / 2 + 0.5;
    move_bump = ((base_od - stand_od) / 4) - mount_hole_offset;

    rotate([0, 0, angle])
    translate([length/2 + stand_od/2 - 0.5, 0, mount_height/2 + thickness])
    union() {
        cube([length, thickness, mount_height], center=true);

        translate([move_bump, -(thickness/2), 0])
        rotate([90, 0, 0])
        cylinder(h=mount_hole_height, d=mount_hole_id);
    }
}

/******************************************************************************/
base();
for(i = [90, 270]) { support(i); }
for(i = [0,  180]) { mount(i);   }
