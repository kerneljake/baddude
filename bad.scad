/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2022 Jake Angerman
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS ``AS IS''
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

include <pattern.scad>;

// uncomment the next two lines if you are doing a mirrored panel
mirroring = true;
mirror = 2; // multiplicative factor
// uncomment the next two lines if you are NOT doing a mirrored panel
//mirroring = false;
//mirror = 1; // multiplicative factor

// board width in mm
board_width = 609.6; // 609.6mm = 24 inches
// board height in mm
board_height = board_width * mirror;

// hole radius
radius = 6.25; // 6.25mm = 1/4 inch
diameter = radius * 2;

// top and bottom margin
margin_rail = diameter;  // 25.6mm = 1 inch
// left and right margin
margin_stile = diameter;

// evenly spaced holes in both dimensions
spacing_horizontal = (board_width - 2*margin_stile - len(holes[0])*diameter)/(len(holes[0])-1);
spacing_vertical = (board_height - 2*margin_rail - len(holes)*mirror*diameter)/(len(holes)*mirror -1);
echo("h=", spacing_horizontal);
echo("v=", spacing_vertical);

// execute
main_module();

module main_module() {
    difference() {

        square([board_width, board_height]);
        
        for (y=[0:len(holes)-1]) {
            for (x=[0:len(holes[0])-1]) {    
                if (holes[y][x]) {
                    // draw the pattern
                    translate ([/*x*/ margin_stile + radius + x*(diameter + spacing_horizontal), /*y*/ margin_rail + radius + y*(diameter + spacing_vertical), 0]) circle(radius);
                    
                    if (mirroring) {
                        // mirror the pattern vertically
                        translate ([/*same x*/ margin_stile + radius + x*(diameter + spacing_horizontal), /*new y*/ board_height - margin_rail - radius - y*(diameter + spacing_vertical), 0]) circle(radius);
                    }
                }
            }
        }
        
    } // difference
}
