
// board width in mm
board_width = 200;
// board height in mm
board_height = 400;
// board thickness in mm
board_thick = 3;

// top and bottom margin
margin_rail = 25.6;
// left and right margin
margin_stile = 25.6;

// hole offset (1 inch or 25.6mm is standard
//hole_offset = 25.60;
// hole radius (1/4" = 6.25mm)
radius = 6.25;
diameter = radius * 2;
// hole height
hole_height = 3;

holes = [[1,1,1], [1,1,1]];

// evenly spaced holes in both dimensions
spacing_horizontal = (board_width - 2*margin_stile - len(holes[0])*diameter)/(len(holes[0])-1);
spacing_vertical = (board_height - 2*margin_rail - len(holes)*diameter)/(len(holes)-1);

// execute
main_module();

module main_module() { // create module
    difference() {

        square([board_width, board_height]);
        
        for (y=[0:len(holes)-1]) {
            for (x=[0:len(holes[0])-1]) {    
                if (holes[y][x]) {
                    translate ([margin_stile + radius + x*(diameter + spacing_horizontal), margin_rail + radius + y*(diameter + spacing_vertical), 0]) rotate ([0,0,0]) cylinder(hole_height, radius, radius, $fn=60, true);
                }
            }
        }
        
    } // difference
}
