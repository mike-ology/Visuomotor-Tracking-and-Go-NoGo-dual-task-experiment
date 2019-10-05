# HEADER #

scenario = "Tracking";
active_buttons = 4;
response_logging = log_active;
no_logfile = true; # default logfile not created
response_matching = legacy_matching;
default_clear_active_stimuli = true;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 36;
default_text_color = 255, 255, 255;
default_formatted_text = true;

begin;

$disc_size = 150;

array {
		ellipse_graphic {
			ellipse_height = $disc_size;
			ellipse_width = $disc_size;
			color = 255, 255, 255;
			background_color = 255, 0, 0, 0;
		}disc1;
		ellipse_graphic {
			ellipse_height = $disc_size;
			ellipse_width = $disc_size;
			color = 255, 255, 255, 0;
			background_color = 255, 0, 0, 0;
		}disc2;
		ellipse_graphic {
			ellipse_height = $disc_size;
			ellipse_width = $disc_size;
			color = 255, 255, 255, 0;
			background_color = 255, 0, 0, 0;
		}disc3;
}disc_array;

array {
	bitmap {
		filename = "hexagon_blue.png";
		height = 100;
		width = 100;
		preload = true;
	}bitmap1;

	bitmap {
		filename = "hexagon_green.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "hexagon_red.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "hexagon_yellow.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "square_blue.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "square_green.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "square_red.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "square_yellow.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "star_blue.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "star_green.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "star_red.png";
		height = 100;
		width = 100;
		preload = true;
	};
	bitmap {
		filename = "star_yellow.png";
		height = 100;
		width = 100;
		preload = true;
	};
}array_shapes;

trial {
	trial_type = specific_response;
	terminator_button = 1, 2, 3, 4;
	#trial_duration = fixed;
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
			caption = " ";
			font_size = 72;
			font_color = 0, 0, 0, 255;
			background_color = 255, 255, 255, 0;
		}text_countdown;
		x = 0; y = 0;

		text {
			caption = "DEBUG1:";
			font_color = 255, 255, 255;
			text_align = align_left;
			font_size = 40;
			background_color = 0, 0, 0, 0;
		}debug1;
		left_x = -900; y = 300;
		on_top = true;

		text {
			caption = "DEBUG2:";
			font_color = 128, 255, 255;
			text_align = align_left;
			font_size = 40;
			background_color = 0, 0, 0, 0;
		}debug2;
		left_x = -900; y = -300;
		on_top = true;

		text {
			caption = "DEBUG3:";
			font_color = 128, 255, 255;
			text_align = align_left;
			font_size = 40;
			background_color = 0, 0, 0, 0;
		}debug3;
		left_x = -900; y = 200;
		on_top = true;

	}pic1;
	
	response_active = true;
	duration = next_picture;
	
}trial1;

trial {
	trial_type = specific_response;
	terminator_button = 1;
	trial_duration = forever;
	all_responses = false;
	stimulus_event {
		picture {
			text {
				caption = "Last run accuracy: XX%";
			} text_accuracy;
			x = 0; y = 300;
			text {
				caption = "Current level: XX/49";
			} text_level;
			x = 0; y = 200;
			text {
				caption = "Target for next trial is:";
			} ;
			x = 0; y = 75;
			text {
				caption = "Press SPACEBAR to go to the next trial, and click the circle to initiate it";
			} text_proceed;
			x = 0; y = -300;
			bitmap bitmap1;
			x = 0; y = 0;
		}message_pic;
		response_active = true;
		target_button = 1;
	};
}message_trial;
	
begin_pcl;

double max_x = display_device.width() / 2  - (disc1.width()/2);
double min_x = -(max_x);
double max_y = display_device.height() / 2  - (disc1.height()/2);
double min_y = -(max_y);

mouse mse = response_manager.get_mouse( 1 );
mse.set_min_max( 1, -(display_device.width() / 2), display_device.width() / 2 );
mse.set_min_max( 2, -(display_device.height() / 2), display_device.height() / 2 );
mse.set_restricted( 1, true );
mse.set_restricted( 2, true );
mse.set_pos( 1, 0 ); 
mse.set_pos( 2, 0 );

double last_mse_x = 0;
double last_ms_y = 0;

bool new_response = false;

array <string> array_edge_collision [3];
array <bool> array_disc_collision[4][2];
array <int> array_edges_aligned[3][4];

array <double> array_closest_noncolliding_x [3][0];
array <double> array_closest_noncolliding_y [3][0];

double tracking_target_min_accuracy = 77.5;
double tracking_target_max_accuracy = 82.5;
int baseline_tracking_speed = 5;
int baseline_tracking_level = 29;
int current_tracking_level = baseline_tracking_level;

array <double> tracking_staircase_percentages [49] = {
10.87,15.22,19.57,23.91,28.26,32.61,36.96,41.30,45.65,50.00,54.35,58.70,63.04,67.39,71.74,76.09,
80.43,84.78,89.13,90.22,91.30,92.39,93.48,94.57,95.65,96.74,97.83,98.91,100.00,101.09,102.17,
103.26,104.35,105.43,106.52,107.61,108.70,109.78,110.87,111.96,113.04,114.13,115.22,116.30,
117.39,118.48,119.57,120.65,121.74 };

array <double> array_disc_current_xy [4][2] = { { 0.0, 350.0 }, { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 } };
array <double> array_disc_check_xy [4][2] = { { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 } };
array <double> array_disc_next_xy [4][2] = { { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 } };
array <double> array_disc_speed_xy [4][2];

array <double> array_starting_coordinates [7][2] = { { -350.0, 350.0 }, { 350.0, 350.0 }, { -350.0, 0.0 }, { 350.0, 0.0 }, { -350.0, -350.0 }, { -0.0, -350.0 }, { 350.0, -350.0 } };
array <double> array_starting_jitter [10] = { 0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0, 45.0 };

double speed_x = baseline_tracking_speed;
double speed_y = baseline_tracking_speed;

loop int i = 1 until i > 3 begin
	array_disc_speed_xy[i][1] = speed_x;
	array_disc_speed_xy[i][2] = speed_y;
	i = i + 1;
end;

double last_accuracy = 0.0;

# # # #

array <double> array_shape_threshold_intervals [8] = { 2.0, 2.5, 3.0 };
array <int> array_shape_target_present [8] = { 1, 1, 1, 1, 0, 0, 0, 0 };
array <int> array_shape_pointers [12] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

array <double> shape_staircase_percentages [49] = { 222.22,216.67,211.11,205.56,200.00,194.44,188.89,183.33,177.78,172.22,166.67,
161.11,155.56,150.00,144.44,138.89,133.33,127.78,122.22,120.00,117.78,115.56,113.33,111.11,108.89,106.67,104.44,102.22,100.00,97.78,
95.56,93.33,91.11,88.89,86.67,84.44,82.22,80.00,77.78,75.56,73.33,71.11,68.89,66.67,64.44,62.22,60.00,57.78,55.56 };
double shape_target_min_accuracy = 77.5;
double shape_target_max_accuracy = 82.5;
int baseline_shape_duration = 450;
int baseline_shape_level = 29;
int current_shape_level = baseline_shape_level;

array <string> trial_type [5] = { "tracking threshold", "shape threshold", "tracking task", "shape task", "dual task" };

string trial_state;
bool run_trial_initialisation;
bool run_tracking_initialisation;
bool run_shape_initialisation;
int block;
int frame_count;
int frames_inside_disc;
int frames_outside_disc;
double tracking_accuracy;
int last_response;
bool mouse_on_target_disc;


# # # #

################

include "sub_collision_check.pcl";
include "sub_disc_task_pcl_part.pcl";

################

loop
	block = 2
until
	block > 5
begin
	
	int trial_count_max;
	int shape_mini_trials;
	double trial_duration;
	
	if trial_type[block] == "tracking threshold" then
		trial_count_max = 9;
		trial_duration = 60000;
		shape_mini_trials = 0;
	elseif trial_type[block] == "shape threshold" then
		trial_count_max = 9;
		trial_duration = 120000;
		shape_mini_trials = 48;
	elseif trial_type[block] == "tracking task" || trial_type[block] == "shape task" || trial_type[block] == "dual task" then
		trial_count_max = 5;
		trial_duration = 180000;
		shape_mini_trials = 72;
	else
		term.print_line( "BLOCK ERROR" );
	end;

	loop
		int trial_count = 1
	until
		trial_count > trial_count_max
	begin

		double trial_initiated_time;
		double trial_start_time;
		double trial_end_time;
		trial_state = "STANDBY";
		run_trial_initialisation = false;
		run_tracking_initialisation = false;
		run_shape_initialisation = false;
		frame_count = 0;
		frames_inside_disc = 0;
		frames_outside_disc = 0;
		tracking_accuracy;
		last_response = 0;
		mouse_on_target_disc;		
		
		int shape_count = 1;
		double time_present_next_shape = 0;
		double time_shape_expires = 0;
		double time_shape_feedback_ends = 0;
		string shape_task_state;
		array_shape_threshold_intervals.shuffle();
		array_shape_target_present.shuffle();
		array_shape_pointers.shuffle();
		array <int> array_shape_trial_accuracy [0];
		double last_shape_RT;
		double time_current_shape;
		
		message_pic.remove_part(5);
		message_pic.add_part( array_shapes[array_shape_pointers[1]], 0.0, 0.0 );
		
		text_level.set_caption( "Current level: " + string( current_tracking_level ) + "/49", true );
		
		if last_accuracy == 0.0 then
			text_accuracy.set_caption( "Previous accuracy: NO DATA", true);
		else
			text_accuracy.set_caption( "Previous accuracy: " + string(round(( last_accuracy ),2)) + "%", true);
		end;
		
		message_trial.present();

		# Set secondary disc starting coordinates
		array_starting_coordinates.shuffle();
		array_starting_jitter.shuffle();
		array_disc_current_xy[1][1] = 0.0;
		array_disc_current_xy[1][2] = 350.0;
		array_disc_current_xy[2][1] = array_starting_coordinates[2][1] + array_starting_jitter[3];
		array_disc_current_xy[2][2] = array_starting_coordinates[2][2] + array_starting_jitter[4];
		array_disc_current_xy[3][1] = array_starting_coordinates[3][1] + array_starting_jitter[5];
		array_disc_current_xy[3][2] = array_starting_coordinates[3][2] + array_starting_jitter[6];

		### PRE-TRIAL SETUP TRIAL ###

		if trial_type[block] == "tracking threshold" || trial_type[block] == "tracking task"  then
			mse.set_pos( 1, 0.0 );
			mse.set_pos( 2, 0.0 );
			cursor_object.set_caption( "+", true );
		elseif trial_type[block] == "shape threshold" || trial_type[block] == "shape task" then
			mse.set_pos( 1, max_x );
			mse.set_pos( 2, max_y );
			cursor_object.set_caption( " ", true );
		elseif trial_type[block] == "dual task" then
			mse.set_pos( 1, 0.0 );
			mse.set_pos( 2, 0.0 );
			cursor_object.set_caption( "+", true );
		end;
		
		# Set current value for response count. Every registered response will manually increment this value immediatelly follow trial presentation.
		# Doing this manually is necessary as a response may be missed if it takes longer than a frame to record it. By the time it is recorded,
		# the inbuilt response counter has already registered a new frame with no response (thus 'missing' slow response recordings).

		#int registered_responses = response_manager.total_response_count();
		int response_count = response_manager.total_response_count();

		loop
			bool trial_end_flag = false;
		until
			trial_end_flag == true
		begin

			
			### INITIATE TRIAL ###

			if trial_type[block] == "tracking threshold" || trial_type[block] == "tracking task"  then
				if trial_state == "STANDBY" && mouse_on_target_disc == true && last_response == 2 then
					run_trial_initialisation = true;
					run_tracking_initialisation = true;
				else
				end;
			elseif trial_type[block] == "shape threshold" || trial_type[block] == "shape task" then
				if trial_state == "STANDBY" && last_response == 1 then
					run_trial_initialisation = true;
					run_shape_initialisation = true;
				else
				end;
			elseif trial_type[block] == "dual task" then
				if trial_state == "STANDBY" && mouse_on_target_disc == true && last_response == 2 then
					run_trial_initialisation = true;
					run_tracking_initialisation = true;
					run_shape_initialisation = true;
				else
				end;
			end;

			if trial_state == "STANDBY" && run_trial_initialisation == true then
				trial_state = "COUNTDOWN";
				trial_initiated_time = clock.time_double();
				trial_start_time = trial_initiated_time + 5000.0;
				trial_end_time = trial_start_time + trial_duration;
				run_trial_initialisation = false;
			elseif trial_state == "COUNTDOWN" then
				double countdown_value = trial_start_time - clock.time_double();
				text_countdown.set_caption( string(int(countdown_value/1000)+1), true );
				if clock.time_double() > trial_start_time then
					trial_state = "TRIAL ACTIVE";
					text_countdown.set_caption(" ", true );
				else
				end;
			else		
			end;
		
			### UPDATE MOUSE LOCATION ###

			mse.poll();
			pic1.set_part_x( 5, mse.x_position() );
			pic1.set_part_y( 5, mse.y_position() );

			# # # # # # # # # # #

			disc_task_pcl_part(); #subroutine
			run_tracking_initialisation = false;

			# # # # # # # # # # #
			
			#########################################################################################
			#########################################################################################
			# SHAPE TASK		

			# Set up initiation
			if trial_state == "COUNTDOWN" && run_shape_initialisation == true && 
				( trial_type[block] == "shape threshold" || trial_type[block] == "shape task" || trial_type[block] == "dual task" ) then
					time_present_next_shape = trial_start_time;
					array_shape_trial_accuracy.resize( 0 );
					array_shape_threshold_intervals.resize( 0 );
					array_shape_target_present.resize( 0 );

					loop int i = 1 until i > shape_mini_trials / 3 begin
						array_shape_threshold_intervals.add( 2.0 );
						array_shape_threshold_intervals.add( 2.5 );
						array_shape_threshold_intervals.add( 3.0 );
						i = i + 1;
					end;

					loop int i = 1 until i > shape_mini_trials / 2 begin
						array_shape_target_present.add( 1 );
						array_shape_target_present.add( 0 );
						i = i + 1;
					end;

					array_shape_threshold_intervals.shuffle();
					array_shape_target_present.shuffle();
					run_shape_initialisation = false;
			else
			end;

			if clock.time_double() >= time_present_next_shape && time_present_next_shape != 0 then
				# present new shape
				if array_shape_target_present[shape_count] == 1 then
					# target present
					pic1.add_part( array_shapes[array_shape_pointers[1]], 0.0, 0.0 );
				elseif array_shape_target_present[shape_count] == 0 then
					# target absent
					pic1.add_part( array_shapes[array_shape_pointers[random(2, 12)]], 0.0, 0.0 );
				else
					term.print_line( "Logic Error" );
				end;
				
				shape_task_state = "STIMULUS ACTIVE";
				
				time_current_shape = clock.time_double();
				time_shape_expires = clock.time_double() + 400.0;
				time_present_next_shape = clock.time_double() + ( array_shape_threshold_intervals[shape_count] * 1000 );
			end;


			if ( clock.time_double() >= time_shape_expires && time_shape_expires != 0 ) 
				|| ( last_response == 1 && shape_task_state == "STIMULUS ACTIVE" ) then

				# remove previous shape on response or time expiring
					pic1.remove_part( pic1.part_count() );
					last_shape_RT = clock.time() - time_current_shape;

					double time_remaining = time_shape_expires - clock.time_double();
					time_shape_expires = 0.0;
					shape_task_state = "STIMULUS INACTIVE";
					time_shape_feedback_ends = clock.time_double() + 200.0;
					
					if ( array_shape_target_present[shape_count] == 1 && last_response == 1 ) 
						|| ( array_shape_target_present[shape_count] != 1 && last_response != 1 ) then
							# correct (HIT or CORRECT REJECTION)
							array_shape_trial_accuracy.add( 1 );
							shape_box.set_color( 0, 225, 0 );
					else 
							# incorrect (MISS or FALSE ALARM)
							array_shape_trial_accuracy.add( 0 );
							shape_box.set_color( 255, 0, 0 );
					end;
										
					# increment shape counter
					shape_count = shape_count + 1;
			else
			end;
			
			
			if clock.time_double() >= time_shape_feedback_ends && time_shape_feedback_ends != 0 then
				shape_box.set_color( 255, 255, 255 );
				time_shape_feedback_ends = 0;
			else
			end;
			


			debug2.set_caption( "Frames inside: " + string(frames_inside_disc) +
				"\nTotal Frames: " + string(frame_count) +
				"\nAccuracy: " + string(round(tracking_accuracy,2)) +
				"\nLevel: " + string(current_tracking_level) +
				"\nTime Remaining: " + string( int((trial_end_time - clock.time_double() ))/1000 ) +
				"\nBL prop.speed: " + string(tracking_staircase_percentages [current_tracking_level]) +
				"\n" +
				"\nLast shape RT: " + string(int(round(last_shape_RT,1))), true );


			# # # # # # #


			# PRESENT FRAME

			trial1.present();

			# CHECK FOR RESPONSE

			if response_manager.total_response_count() > response_count then
				last_response = response_manager.last_response();
				response_count = response_count + 1;
				#debug1.set_caption("Response count: " + string(response_count), true);
			else
				last_response = 0;
				#debug1.set_caption("Response count: " + string(response_count), true);
			end;
				
			# CHECK IF TRIAL HAS EXPIRED

			if clock.time_double() > trial_end_time && trial_end_time != 0 then
				trial_end_flag = true;
			else
			end;

		end;

		#########################################################################################
		#########################################################################################
		
		# calculate how far accuracy differs from target band
		
		int tracking_level_change;
		int shape_level_change;
		double shape_accuracy = arithmetic_mean( array_shape_trial_accuracy );
		
		if tracking_accuracy < tracking_target_min_accuracy then
			# accuracy too low
			tracking_level_change = -(int(( tracking_target_min_accuracy - tracking_accuracy ) / 1.75) + 1);
		elseif tracking_accuracy > tracking_target_max_accuracy then
			# accuracy too high
			tracking_level_change = int( abs( tracking_target_max_accuracy - tracking_accuracy ) / 1.75) + 1;
		else
			# accuracy okay
			tracking_level_change = 0;
		end;

		if shape_accuracy < shape_target_min_accuracy then
			# accuracy too low
			shape_level_change = -(int(( shape_target_min_accuracy - shape_accuracy ) / 1.75) + 1);
		elseif shape_accuracy > shape_target_max_accuracy then
			# accuracy too high
			shape_level_change = int( abs( shape_target_max_accuracy - shape_accuracy ) / 1.75) + 1;
		else
			# accuracy okay
			shape_level_change = 0;
		end;


		# adjust difficulty level for next trial
			
		current_tracking_level = current_tracking_level + tracking_level_change;
		current_shape_level = current_shape_level + shape_level_change;

		# keep within level limits

		if current_tracking_level < 1 then
			current_tracking_level = 1
		elseif current_tracking_level > tracking_staircase_percentages.count() then
			current_tracking_level = tracking_staircase_percentages.count()
		else
		end;
		
		if current_shape_level < 1 then
			current_shape_level = 1
		elseif current_shape_level > shape_staircase_percentages.count() then
			current_shape_level = shape_staircase_percentages.count()
		else
		end;

		#last_accuracy = tracking_accuracy;
		
		# # # # #
		
		term.print_line( current_shape_level );

		trial_count = trial_count + 1;
	end;
	
	block = block + 1;
end;