# HEADER #

scenario = "Tracking";
active_buttons = 3;
response_logging = log_active;
no_logfile = true; # default logfile not created
response_matching = simple_matching;
default_clear_active_stimuli = true;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 36;
default_text_color = 0, 0, 0;
default_formatted_text = true;

begin;

array {
		ellipse_graphic {
			ellipse_height = 200;
			ellipse_width = 200;
			color = 255, 255, 255;
			background_color = 255, 0, 0, 128;
		}disc1;
		ellipse_graphic {
			ellipse_height = 200;
			ellipse_width = 200;
			color = 255, 255, 255;
			background_color = 255, 0, 0, 128;
		}disc2;
		ellipse_graphic {
			ellipse_height = 200;
			ellipse_width = 200;
			color = 255, 255, 255;
			background_color = 255, 0, 0, 128;
		}disc3;
}disc_array;

trial{
	trial_type = specific_response;
	terminator_button = 1, 2, 3;
	trial_duration = forever;
	picture{

		ellipse_graphic disc1;
		x = 400; y = 400;

		ellipse_graphic disc2;
		x = 700; y = 400;

		ellipse_graphic disc3;
		x = -700; y = 400;

		box {
			width = 200;
			height = 200;
			color = 255, 255, 255;
			}shape_box;
		x = 0; y = 0;

		text {
			caption = "+";
			font_color = 0, 0, 255;
			font_size = 40;
			background_color = 0, 0, 0, 0;
		}cursor_object;
		x = 0; y = 0;
		on_top = true;

		text {
			caption = "DEBUG1:";
			font_color = 255, 255, 255;
			text_align = align_left;
			font_size = 40;
			background_color = 0, 0, 0, 0;
		}debug1;
		x = -500; y = 300;
		on_top = true;

		text {
			caption = "DEBUG2:";
			font_color = 128, 255, 255;
			text_align = align_left;
			font_size = 40;
			background_color = 0, 0, 0, 0;
		}debug2;
		x = -500; y = -300;
		on_top = true;

	}pic1;
	
	response_active = true;
	
}trial1;


begin_pcl;

double max_x = display_device.width() / 2  - (disc1.width()/2);
double min_x = -(max_x);
double max_y = display_device.height() / 2  - (disc1.height()/2);
double min_y = -(max_y);

mouse mse = response_manager.get_mouse( 1 );
mse.set_min_max( 1, min_x, max_x );
mse.set_min_max( 2, min_y, max_y );
mse.set_restricted( 1, false );
mse.set_restricted( 2, false );
mse.set_pos( 1, 0 ); 
mse.set_pos( 2, 0 );

int speed_x = 5;
int speed_y = 5;

array <double> array_closest_noncolliding_x [3][0];
array <double> array_closest_noncolliding_y [3][0];

array <string> array_edge_collision [3];

array <double> array_starting_coordinates [8][2] = { { -350.0, 350.0 }, { -0.0, 350.0 }, { 350.0, 350.0 }, { -350.0, 0.0 }, { 350.0, 0.0 }, { -350.0, -350.0 }, { -0.0, -350.0 }, { 350.0, -350.0 } };
array_starting_coordinates.shuffle();

array <double> array_starting_jitter [10] = { 0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0 };
array_starting_jitter.shuffle();

array <double> array_disc_current_xy [4][2] = { { -400.0, -400.0 }, { 00.0, 400.0 }, { 201.0, 400.0 }, { 0.0, 0.0 } };
array <double> array_disc_check_xy [4][2] = { { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 } };
array <double> array_disc_next_xy [4][2] = { { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 } };
array <double> array_disc_speed_xy [4][2];
array <bool> array_disc_collision[4][2];

loop int i = 1 until i > 3 begin
	array_disc_speed_xy[i][1] = speed_x;
	array_disc_speed_xy[i][2] = speed_y;
	i = i + 1;
end;

array_disc_current_xy[1][1] = array_starting_coordinates[1][1] + array_starting_jitter[1];
array_disc_current_xy[1][2] = array_starting_coordinates[1][2] + array_starting_jitter[2];
array_disc_current_xy[2][1] = array_starting_coordinates[2][1] + array_starting_jitter[3];
array_disc_current_xy[2][2] = array_starting_coordinates[2][2] + array_starting_jitter[4];
array_disc_current_xy[3][1] = array_starting_coordinates[3][1] + array_starting_jitter[5];
array_disc_current_xy[3][2] = array_starting_coordinates[3][2] + array_starting_jitter[6];

array <int> array_edges_aligned[3][4];


double last_mse_x = 0;
double last_ms_y = 0;


################

include "sub_collision_check.pcl";

################

loop
	int i = 1;
until
	i > 100000
begin


	### Loop that determines the x/y coordinates of each disc's position on the next frame before collisions
	# are taken into account. Updates to disc's next positions implemented if collisions would occur.
	# Loop also resets collision state.

	loop
		int h = 1;
	until
		h > 3
	begin
		
		array_disc_check_xy[h][1] = array_disc_current_xy[h][1] + array_disc_speed_xy[h][1];
		array_disc_check_xy[h][2] = array_disc_current_xy[h][2] + array_disc_speed_xy[h][2];
		array_disc_collision[h][1] = false;
		array_disc_collision[h][2] = false;

		### loop that checks for collisions with the edge of the screen

		double check_x = array_disc_check_xy[h][1];
		double check_y = array_disc_check_xy[h][2];
		array_edge_collision[h] = "NONE";
		
		if check_x > max_x then
			array_edge_collision[h] = "RIGHT";
		elseif check_x < min_x then
			array_edge_collision[h] = "LEFT";
		else
		end;
		
		if check_y > max_y then
			array_edge_collision[h] = "TOP";
		elseif check_y < min_y then
			array_edge_collision[h] = "BOTTOM";
		else
		end;
		
		### Check for collisions with other discs and centre square
	
		array_closest_noncolliding_x[h].resize(0);
		array_closest_noncolliding_y[h].resize(0);
		
		collision_check( h, 1, 1 );
		collision_check( h, 2, 1 );
		collision_check( h, 3, 1 );
		collision_check( h, 4, 1 );

		### NEW COORDINATES IF NO COLLISION TAKES PLACE
		
		double next_x = array_disc_current_xy[h][1] + array_disc_speed_xy[h][1];
		double next_y = array_disc_current_xy[h][2] + array_disc_speed_xy[h][2];

		### SET COORDINATES BASED ON IMPENDING COLLISION WITH SCREEN EDGE
		
		if array_edge_collision[h] == "LEFT" then
			next_x = min_x;
			array_disc_speed_xy[h][1] = array_disc_speed_xy[h][1] * (-1.0);
		elseif array_edge_collision[h] == "RIGHT" then
			next_x = max_x;
			array_disc_speed_xy[h][1] = array_disc_speed_xy[h][1] * (-1.0);
		elseif array_edge_collision[h] == "TOP" then
			next_y = max_y;
			array_disc_speed_xy[h][2] = array_disc_speed_xy[h][2] * (-1.0);
		elseif array_edge_collision[h] == "BOTTOM" then
			next_y = min_y;
			array_disc_speed_xy[h][2] = array_disc_speed_xy[h][2] * (-1.0);
		else
		end;

		### SET COORDINATES BASED ON IMPENDING COLLISION WITH ANOTHER DISC OR CENTRE SQUARE

		if array_disc_collision[h][1] == true then
			
			# adjust x axis
			double x_smallest_distance;
			# obtain smallest distance to a collision on x axis
			loop int j = 1 until j > array_closest_noncolliding_x[h].count()
			begin
				if j == 1 then
					x_smallest_distance = array_closest_noncolliding_x[h][j]
				elseif array_closest_noncolliding_x[h][j] == 0 then
					# do nothing
				elseif array_closest_noncolliding_x[h][j] < x_smallest_distance then
					x_smallest_distance = array_closest_noncolliding_x[h][j]
				else
				end;
				j = j + 1;
			end;
			
			next_x = x_smallest_distance;
			array_disc_speed_xy[h][1] = array_disc_speed_xy[h][1] * (-1.0);
		else
		end;
		
		if array_disc_collision[h][2] == true then
			# adjust y axis

			double y_smallest_distance;
			# obtain smallest distance to a collision on y axis
			loop int j = 1 until j > array_closest_noncolliding_y[h].count()
			begin
				if j == 1 then
					y_smallest_distance = array_closest_noncolliding_y[h][j]
				elseif array_closest_noncolliding_y[h][j] == 0 then
					# do nothing
				elseif array_closest_noncolliding_y[h][j] < y_smallest_distance then
					y_smallest_distance = array_closest_noncolliding_y[h][j]
				else
				end;
				j = j + 1;
			end;
			
			next_y = y_smallest_distance;
			array_disc_speed_xy[h][2] = array_disc_speed_xy[h][2] * (-1.0);
		
		else
		end;
		
		array_disc_current_xy[h][1] = next_x;
		array_disc_current_xy[h][2] = next_y;
		pic1.set_part_x( h, array_disc_current_xy[h][1] );
		pic1.set_part_y( h, array_disc_current_xy[h][2] );
		h = h + 1;		
			
	end;

	### DISC LOCATIONS UPDATED, TRAJECTORIES UPDATED ###


	### UPDATE MOUSE LOCATION ###

	mse.poll();
	pic1.set_part_x( 5, mse.x() );
	pic1.set_part_y( 5, mse.y() );

	# check if mouse overlaps with disc
	
	double disc_distance_x = abs(mse.x_position() - pic1.get_part_x(1));
	double disc_distance_y = abs(mse.y_position() - pic1.get_part_y(1));
	
	double disc_distance_h = sqrt( ( disc_distance_x * disc_distance_x ) + ( disc_distance_y * disc_distance_y ) );
			
	if disc_distance_h > disc1.width()/2 then
		disc1.set_color( 255, 0, 0, 255 );
	else
		disc1.set_color( 0, 255, 0, 255 );
	end;
	
	disc1.redraw();

	# # # # # # #
	
	# Present trial/frame
	
	if response_manager.last_response() != 2 then
		trial1.set_duration( 1 );
	elseif response_manager.last_response() == 2 then
		trial1.set_duration( forever );
	end;
		trial1.present();

	# # # # # # #

end;