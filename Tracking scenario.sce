# HEADER #

scenario = "Tracking";
active_buttons = 7;
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

$disc_size = 100;

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
			caption = " ";
			font_size = 36;
			font_color = 255, 255, 255, 255;
			background_color = 0, 0, 0, 0;
		}text_start_trial;
		x = 0; y = -200;

		text {
			caption = " ";
			font_size = 36;
			font_color = 255, 0, 0, 255;
			background_color = 0, 0, 0, 0;
		}text_shape_reminder;
		x = 0; y = 200;
		
		bitmap bitmap1;
		x = 9999; y = 9999;

		text {
			caption = "DEBUG1:";
			font_color = 255, 255, 255;
			text_align = align_left;
			font_size = 20;
			background_color = 0, 0, 0, 0;
		}debug1;
		left_x = -900; top_y = 500;
		on_top = true;

	}pic1;
	
	response_active = true;
	duration = next_picture;
	
}trial1;

begin_pcl;

bool debug_mode = true;
bool draw_other_discs = false;

double req_screen_x = 1920.0;
double req_screen_y = 1080.0;

# initialised mouse parameters and variables

mouse mse = response_manager.get_mouse( 1 );
mse.set_min_max( 1, -(display_device.width() / 2), display_device.width() / 2 );
mse.set_min_max( 2, -(display_device.height() / 2), display_device.height() / 2 );
mse.set_restricted( 1, true );
mse.set_restricted( 2, true );
mse.set_pos( 1, 0 ); 
mse.set_pos( 2, 0 );

# initialise general trial parameters and variables

int phase = 1;
string training_type = "single";
int section;
int max_sections;
array <int> array_section_trials [2][0];
array <int> array_trials_per_task [0];
array <int> array_tracking_trial_length [0];
array <int> array_shape_trial_length [0];
array <int> array_dual_trial_length [0];

if phase == 1 then

	max_sections = 2;
	array_trials_per_task.assign( { 9, 5 } );
	array_tracking_trial_length.assign( { 60, 180 } );
	array_shape_trial_length.assign( { 120, 180 } );
	array_dual_trial_length.assign( { 0, 180 } );

	loop
		int i = 1
	until
		i > array_trials_per_task[1]
	begin
		array_section_trials[1].add( 1 );
		array_section_trials[1].add( 2 );
		i = i + 1;
	end;

	loop
		int i = 1
	until
		i > array_trials_per_task[2]
	begin
		array_section_trials[2].add( 1 );
		array_section_trials[2].add( 2 );
		array_section_trials[2].add( 3 );
		i = i + 1;
	end;
	
elseif phase == 2 && training_type == "single" then

	max_sections = 1;
	array_trials_per_task.assign( { 6 } );
	array_tracking_trial_length.assign( { 180 } );
	array_shape_trial_length.assign( { 180 } );
	array_dual_trial_length.assign( { 0 } );

	loop
		int i = 1
	until
		i > array_trials_per_task[1]
	begin
		array_section_trials[1].add( 1 );
		array_section_trials[1].add( 2 );
		i = i + 1;
	end;

elseif phase == 2 && training_type == "dual" then

	max_sections = 1;
	array_trials_per_task.assign( { 12 } );
	array_tracking_trial_length.assign( { 0 } );
	array_shape_trial_length.assign( { 0 } );
	array_dual_trial_length.assign( { 180 } );

	loop
		int i = 1
	until
		i > array_trials_per_task[1]
	begin
		array_section_trials[1].add( 3 );
		i = i + 1;
	end;

elseif phase == 3 then

	max_sections = 1;
	array_trials_per_task.assign( { 5 } );
	array_tracking_trial_length.assign( { 180 } );
	array_shape_trial_length.assign( { 180 } );
	array_dual_trial_length.assign( { 180 } );

	loop
		int i = 1
	until
		i > array_trials_per_task[1]
	begin
		array_section_trials[1].add( 1 );
		array_section_trials[1].add( 2 );
		array_section_trials[1].add( 3 );
		i = i + 1;
	end;

else
	term.print_line( "INVALID EXPERIMENT SETUP" );

end;

string trial_state;
bool run_trial_initialisation;
bool run_tracking_initialisation;
bool run_shape_initialisation;
int frame_count;
int last_response;
double last_response_time = -1;
bool new_response = false;
int trial_count;
int trial_count_max;
double trial_duration;
bool skip_level_adjustment = false;

# initialise disc task parameters and variables

array <double> tracking_staircase_percentages [49] = {
10.87,15.22,19.57,23.91,28.26,32.61,36.96,41.30,45.65,50.00,54.35,58.70,63.04,67.39,71.74,76.09,
80.43,84.78,89.13,90.22,91.30,92.39,93.48,94.57,95.65,96.74,97.83,98.91,100.00,101.09,102.17,
103.26,104.35,105.43,106.52,107.61,108.70,109.78,110.87,111.96,113.04,114.13,115.22,116.30,
117.39,118.48,119.57,120.65,121.74 };

double tracking_target_min_accuracy = 77.5;
double tracking_target_max_accuracy = 82.5;
int baseline_tracking_speed = 5;
int baseline_tracking_level = 29;
int current_tracking_level = baseline_tracking_level;

double speed_x = baseline_tracking_speed;
double speed_y = baseline_tracking_speed;

array <double> array_starting_coordinates [7][2] = { { -350.0, 350.0 }, { 350.0, 350.0 }, { -350.0, 0.0 }, { 350.0, 0.0 }, { -350.0, -350.0 }, { -0.0, -350.0 }, { 350.0, -350.0 } };
array <double> array_starting_jitter [10] = { 0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0, 45.0 };

array <double> array_disc_current_xy [4][2] = { { 0.0, 350.0 }, { 0.0, 0.0 }, { 0.0, 0.0 }, { 0.0, 0.0 } };
array <double> array_disc_check_xy [4][2];
array <double> array_disc_next_xy [4][2];
array <double> array_disc_speed_xy [4][2];

loop int i = 1 until i > 3 begin
	array_disc_speed_xy[i][1] = speed_x;
	array_disc_speed_xy[i][2] = speed_y;
	i = i + 1;
end;

double max_x = display_device.width() / 2  - (disc1.width()/2);
double min_x = -(max_x);
double max_y = display_device.height() / 2  - (disc1.height()/2);
double min_y = -(max_y);

array <string> array_edge_collision [3];
array <bool> array_disc_collision[4][2];
array <int> array_edges_aligned[3][4];

array <double> array_closest_noncolliding_x [3][0];
array <double> array_closest_noncolliding_y [3][0];

double last_tracking_accuracy = 0.0;
string disc_speed_description;
int frames_inside_disc;
int frames_outside_disc;
double tracking_accuracy;
bool mouse_on_target_disc;

# initialised shape task parameters and variables

array <double> array_shape_threshold_intervals [0];
array <int> array_shape_target_present [0];
array <int> array_shape_pointers [12] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

array <double> array_shape_staircase_percentages [49] = { 222.22,216.67,211.11,205.56,200.00,194.44,188.89,183.33,177.78,172.22,166.67,
161.11,155.56,150.00,144.44,138.89,133.33,127.78,122.22,120.00,117.78,115.56,113.33,111.11,108.89,106.67,104.44,102.22,100.00,97.78,
95.56,93.33,91.11,88.89,86.67,84.44,82.22,80.00,77.78,75.56,73.33,71.11,68.89,66.67,64.44,62.22,60.00,57.78,55.56 };
double shape_target_min_accuracy = 77.5;
double shape_target_max_accuracy = 82.5;
string shape_speed_description;
int baseline_shape_duration = 450;
int baseline_shape_level = 29;
int current_shape_level = baseline_shape_level;
int final_shape_level;
double shape_mini_trials;
double shape_trial_accuracy;
double shape_trial_targets_hit;
double shape_trial_correct_rej;
bool shape_trial_response_recorded;
double shape_time_limit;

# # # #

################

include "sub_generate_prompt.pcl";
include "sub_collision_check.pcl";
include "sub_disc_task_pcl_part.pcl";

sub shape_feedback ( int correct )
begin
	if phase == 1 && section == 1 then
		if correct == 1 then
			shape_box.set_color( 0, 225, 0 );
		elseif correct == 0 then
			shape_box.set_color( 255, 0, 0 );
		end;
	end;
end;

################

loop
	section = 1
until
	section > max_sections
begin
	
	trial_count_max = array_section_trials[section].count();

	loop
		trial_count = 2
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
		last_response = 0;
		
		int shape_count = 1;
		double time_present_next_shape = 0;
		double time_shape_expires = 0;
		double time_shape_feedback_ends = 0;
		string shape_task_state;
		array_shape_pointers.shuffle();
		array <double> array_shape_trial_accuracy [0];
		array <double> array_shape_trial_accuracy_t_present [0];
		array <double> array_shape_trial_accuracy_t_absent [0];
		array <double> array_shape_trial_all_RTs [0];
		double last_shape_RT = -1;
		double time_current_shape;
		
		# determine next trial
		if array_section_trials[section][trial_count] == 1 then # tracking
			trial_duration = array_tracking_trial_length[section] * 1000;
			shape_mini_trials = 0;
		elseif array_section_trials[section][trial_count] == 2  then # shape
			trial_duration = array_shape_trial_length[section] * 1000;
			shape_mini_trials = array_shape_trial_length[section] / 2.5;
		elseif ( array_section_trials[section][trial_count] == 3 ) then # dual
			trial_duration = array_dual_trial_length[section] * 1000;
			shape_mini_trials = array_dual_trial_length[section] / 2.5 ;
		else
			term.print_line( "BLOCK ERROR" );
		end;
		
		#########################################################################################
		#########################################################################################
		# PRE-TRIAL MESSAGE		
		
		create_new_prompt( 1 );
		
		if array_section_trials[section][trial_count] == 1 && trial_count < 3 then
			# first trial of this type
			prompt_message.set_caption( "<b>NEXT TRIAL: DISC TRACKING TASK</b>\n\n" +
				"A disc will bounce around the screen. Your task is to try and keep the mouse on the disc as much as possible.\n" +
				"The disc will occasionally change direction without warning, so try your best to follow it!", true );
				
				if phase == 1 && section == 1 then
					# additional instruction regarding difficulty adjustment and visual feedback
					mid_button_text.set_caption( "Press SPACEBAR to continue", true );
					prompt_trial.present();
					prompt_message.set_caption( "If your accuracy at the end of the trial is above 80%, the disc will move slightly faster on the next trial.\n" +
						"However, if your accuracy is below 80%, the disc will move slightly slower on the next trial.\n\n" +
						"For this part, the disc will change colour depending on whether the mouse is on the disc or not. This visual feedback will not be displayed in later trials.", true );
				else
				end;

		elseif array_section_trials[section][trial_count] == 1 && trial_count >= 3 then
			# subsequent trial of this type
			prompt_message.set_caption( "<b>NEXT TRIAL: DISC TRACKING TASK</b>", true );

		elseif array_section_trials[section][trial_count] == 2 && trial_count < 3 then
			# first trial of this type
			prompt_message.set_caption( "<b>NEXT TRIAL: SHAPE GO/NO-GO TASK</b>\n\n" +
				"A series of different shapes of different colours will appear in the centre of the screen, one after another.\n" +
				"Your task is to press the SPACEBAR as quickly as possible when the target shape appears on the screen.\n\n" +
				"<font color='255, 255, 0'>The target shape will be presented to you before each trial starts and will change with every new trial.</font>\n\n" + 
				"Make sure you only respond if it is the SAME SHAPE AND THE SAME COLOUR!\n" +
				"You will have to make sure your responses are fast as the shapes will quickly disappear.", true );

				if phase == 1 && section == 1 then
					# additional instruction regarding difficulty adjustment and visual feedback
					mid_button_text.set_caption( "Press SPACEBAR to continue", true );
					prompt_trial.present();
					prompt_message.set_caption( "If your accuracy at the end of the trial is above 80%, the shapes will disappear slightly faster on the next trial.\n" +
						"However, if your accuracy is below 80%, the shapes will disappear slightly slower on the next trial.\n\n" +
						"For this part, the white square that the shapes are presented on will flash green or red when each shape disappears, depending on whether you responded correctly AND responded fast enough." +
						"This visual feedback will not be displayed in later trials.", true );
				else
				end;

		elseif array_section_trials[section][trial_count] == 2 && trial_count >= 3 then
			# subsequent trial of this type
			prompt_message.set_caption( "<b>NEXT TRIAL: SHAPE GO/NO-GO TASK</b>", true );

		elseif array_section_trials[section][trial_count] == 3 then
			# same message for first and subsequent trials
			prompt_message.set_caption( "<b>NEXT TRIAL: DUAL TASK</b>\n\n" +
				"For this trial, you must complete both the disc tracking task and shape go/no-go task at the same time.", true );

		else
		end;
		
		mid_button_text.set_caption( "Press SPACEBAR to continue", true );
		prompt_trial.present();

		# Set disc starting coordinates
		array_starting_coordinates.shuffle();
		array_starting_jitter.shuffle();
		array_disc_current_xy[1][1] = 0.0;
		array_disc_current_xy[1][2] = 350.0;
		array_disc_current_xy[2][1] = array_starting_coordinates[2][1] + array_starting_jitter[3];
		array_disc_current_xy[2][2] = array_starting_coordinates[2][2] + array_starting_jitter[4];
		array_disc_current_xy[3][1] = array_starting_coordinates[3][1] + array_starting_jitter[5];
		array_disc_current_xy[3][2] = array_starting_coordinates[3][2] + array_starting_jitter[6];

		### PRE-TRIAL SETUP TRIAL ###

		if array_section_trials[section][trial_count] == 1 || array_section_trials[section][trial_count] == 3  then
			text_start_trial.set_caption( "Click on the disc to start the trial", true);
			mse.set_pos( 1, 0.0 );
			mse.set_pos( 2, 50.0 );
			cursor_object.set_caption( "+", true );
		elseif array_section_trials[section][trial_count] == 2 then
			text_start_trial.set_caption( "Press the SPACEBAR to start the trial", true);
			mse.set_pos( 1, max_x );
			mse.set_pos( 2, max_y );
			cursor_object.set_caption( " ", true );
		end;
		
		if array_section_trials[section][trial_count] == 2 || array_section_trials[section][trial_count] == 3  then
			text_shape_reminder.set_caption( "The target shape you must respond to on this trial is", true);
			pic1.set_part_x( 9, 0.0 );
			pic1.set_part_y( 9, 0.0 );
			pic1.set_part( 9, array_shapes[array_shape_pointers[1]] );
		else
			pic1.set_part_x( 9, 9999.0 );
			pic1.set_part_y( 9, 9999.0 );
		end;
		
		# Set current value for response count. Every registered response will manually increment this value immediatelly follow trial presentation.
		# Doing this manually is necessary as a response may be missed if it takes longer than a frame to record it. By the time it is recorded,
		# the inbuilt response counter has already registered a new frame with no response (thus 'missing' slow response recordings).

		#int registered_responses = response_manager.total_response_count();
		int response_count = response_manager.total_response_count();

		#########################################################################################
		#########################################################################################
		# START MAIN TRIAL LOOP		

		loop
			bool trial_end_flag = false;
		until
			trial_end_flag == true
		begin

			#########################################################################################
			#########################################################################################
			# INITIATE TRIAL - wait for trigger and then code here runs once per loop

			if array_section_trials[section][trial_count] == 1 then
				if trial_state == "STANDBY" && mouse_on_target_disc == true && last_response == 2 then
					run_trial_initialisation = true;
					run_tracking_initialisation = true;
				else
				end;
			elseif array_section_trials[section][trial_count] == 2 then
				if trial_state == "STANDBY" && last_response == 1 then
					run_trial_initialisation = true;
					run_shape_initialisation = true;
				else
				end;
			elseif array_section_trials[section][trial_count] == 3 then
				if trial_state == "STANDBY" && mouse_on_target_disc == true && last_response == 2 then
					run_trial_initialisation = true;
					run_tracking_initialisation = true;
					run_shape_initialisation = true;
				else
				end;
			end;

			if trial_state == "STANDBY" && run_trial_initialisation == true then
				trial_state = "COUNTDOWN";
				text_start_trial.set_caption( " ", true );
				text_shape_reminder.set_caption( " ", true );
				pic1.set_part_x( 9, 9999.0 );
				pic1.set_part_y( 9, 9999.0 );

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

			#########################################################################################
			#########################################################################################
			# DISC TASK		

			disc_task_pcl_part(); #subroutine
			run_tracking_initialisation = false;

			#########################################################################################
			#########################################################################################
			# SHAPE TASK		

			# Set up initiation
			if trial_state == "COUNTDOWN" && run_shape_initialisation == true && 
				( array_section_trials[section][trial_count] == 2 || array_section_trials[section][trial_count] == 3 ) then
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
				shape_trial_response_recorded = false;
				last_shape_RT = -1;
				
				time_current_shape = clock.time_double();
				shape_time_limit = baseline_shape_duration * array_shape_staircase_percentages[current_shape_level]/100.0;
				time_shape_expires = clock.time_double() + shape_time_limit;
				time_present_next_shape = clock.time_double() + ( array_shape_threshold_intervals[shape_count] * 1000 );
			end;

			if last_response == 1 && shape_trial_response_recorded == false then
				# first response to shape mini trial
				shape_trial_response_recorded = true;
				last_shape_RT = last_response_time - time_current_shape;
				array_shape_trial_all_RTs.add( last_shape_RT );
			end;

			if ( clock.time_double() >= time_shape_expires && time_shape_expires != 0.0 ) 
				|| ( last_response == 1 && shape_task_state == "STIMULUS ACTIVE" ) then

					# remove previous shape on response or time expiring
					pic1.remove_part( pic1.part_count() );

					double time_remaining = time_shape_expires - clock.time_double();
					time_shape_expires = 0.0;
					shape_task_state = "STIMULUS INACTIVE";
					time_shape_feedback_ends = clock.time_double() + 200.0;
					
					if array_shape_target_present[shape_count] == 1 && last_response == 1 then
							# HIT
							array_shape_trial_accuracy.add( 1 );
							array_shape_trial_accuracy_t_present.add( 1.0 );
							shape_feedback(1);
					elseif array_shape_target_present[shape_count] != 1 && last_response != 1 then
							# CORRECT REJECTION
							array_shape_trial_accuracy.add( 1 );
							array_shape_trial_accuracy_t_absent.add( 1.0 );
							shape_feedback(1);
					elseif array_shape_target_present[shape_count] == 1 && last_response != 1 then
							# MISS
							array_shape_trial_accuracy.add( 0 );
							array_shape_trial_accuracy_t_present.add( 0.0 );
							shape_feedback(0);
					elseif array_shape_target_present[shape_count] != 1 && last_response == 1 then
							# FALSE ALARM
							array_shape_trial_accuracy.add( 0 );
							array_shape_trial_accuracy_t_absent.add( 0.0 );
							shape_feedback(0);
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
			
			int debug_time_remaining = int((trial_end_time - clock.time_double() ))/1000;
			if debug_time_remaining < 0 then debug_time_remaining = 0; else end;
			
			double debug_last_shape_accurate;
			if array_shape_trial_accuracy.count() == 0 then
				debug_last_shape_accurate = -1
			else
				debug_last_shape_accurate = array_shape_trial_accuracy[array_shape_trial_accuracy.count()]
			end;
			
			if debug_mode == true then
				debug1.set_caption( "Phase: " + string(phase) + "\n" +
					"Section: " + string(section) + "/" + string(max_sections) + "\n" +
					"Current task: " + string(array_section_trials[section][trial_count]) + "\n" +
					"Trial: " + string(trial_count) + "/" + string(trial_count_max) + "\n" +
					"Time Remaining: " + string(debug_time_remaining) + "\n\n" +
					"Tracking task level: " + string(current_tracking_level) + "/49\n" + 
					"Shape task level: " + string(current_shape_level) + "/49\n\n" +
					"Frames inside: " + string(frames_inside_disc) + "\n" +
					"Total Frames: " + string(frame_count) + "\n\n" +
					"Last shape trial accurate: " + string(debug_last_shape_accurate) + "\n" +
					"Last shape reaction time: " + string(round(last_shape_RT,0)) + "\n" +
					"Last shape time limit: " + string(round(shape_time_limit,0)) + "\n\n" +
					"[T] Increment trial counter\n" + 
					"[R] Reset trial\n" + 
					"[N] End trial, go to next\n" +
					"[D] Show/Hide other discs", true );
				elseif debug_mode == false then
					debug1.set_caption(" ", true);
				end;

			#########################################################################################
			#########################################################################################
			# PRESENT FRAME		

			trial1.present();

			#########################################################################################
			#########################################################################################
			# CHECK FOR RESPONSE		

			response_data resp_data;

			if response_manager.total_response_count() > response_count then
				resp_data = response_manager.last_response_data();
				last_response_time = resp_data.time_double();
				last_response = response_manager.last_response();
				response_count = response_count + 1;
			else
				last_response = 0;
				last_response_time = 0;
			end;
			
			# DEBUG SETTINGS
			
			if last_response == 3 && debug_mode == true  then
				trial_count = trial_count + 1;
				last_response = 0;
			elseif last_response == 4 && debug_mode == true  then
				trial_end_time = clock.time_double();
				trial_count = trial_count - 1;
				skip_level_adjustment = true;
				last_response = 0;
			elseif last_response == 5 && debug_mode == true  then
				trial_end_time = clock.time_double();
				last_response = 0;
			elseif last_response == 6 && debug_mode == true then
				debug_mode = false;
				last_response = 0;
			elseif last_response == 6 && debug_mode == false then
				debug_mode = true;
				last_response = 0;
			elseif last_response == 7 && debug_mode == true && draw_other_discs == false then
				disc2.set_color( 128, 128, 128, 255 );
				disc2.redraw();
				disc3.set_color( 128, 128, 128, 255 );
				disc3.redraw();
				draw_other_discs = true;
				last_response = 0;
			elseif last_response == 7 && debug_mode == true && draw_other_discs == true then
				disc2.set_color( 0, 0, 0, 0 );
				disc2.redraw();
				disc3.set_color( 0, 0, 0, 0 );
				disc3.redraw();
				draw_other_discs = false;
				last_response = 0;
			end;
			
			# CHECK IF TRIAL HAS EXPIRED

			if clock.time_double() > trial_end_time && trial_end_time != 0 then
				trial_end_flag = true;
			else
			end;

		end;

		#########################################################################################
		#########################################################################################
		# ADJUST DIFFICULTY ON THRESHOLD TRIALS		
		
		bool show_reset_message = false;
		
		if skip_level_adjustment == true then
			# trial was reset, difficulty parameters are kept the same
			show_reset_message = true;
			skip_level_adjustment = false; # reset

		elseif phase == 1 && section == 1 then
		
			# calculate how far accuracy differs from target band

			if array_section_trials[section][trial_count] == 1 then
			
				int tracking_level_change = 0;

				if tracking_accuracy < tracking_target_min_accuracy then
					# accuracy too low
					disc_speed_description = "slower";
					tracking_level_change = -(int(( tracking_target_min_accuracy - tracking_accuracy ) / 1.75) + 1);
				elseif tracking_accuracy > tracking_target_max_accuracy then
					# accuracy too high
					disc_speed_description = "faster";
					tracking_level_change = int( abs( tracking_target_max_accuracy - tracking_accuracy ) / 1.75) + 1;
				else
					# accuracy okay
					disc_speed_description = "the same";
					tracking_level_change = 0;
				end;

				current_tracking_level = current_tracking_level + tracking_level_change;
			
				if current_tracking_level < 1 then
					current_tracking_level = 1
				elseif current_tracking_level > tracking_staircase_percentages.count() then
					current_tracking_level = tracking_staircase_percentages.count()
				else
				end;

			elseif array_section_trials[section][trial_count] == 2 then

				int shape_level_change = 0;
				shape_trial_accuracy = arithmetic_mean( array_shape_trial_accuracy ) * 100.0;
				shape_trial_targets_hit = arithmetic_mean( array_shape_trial_accuracy ) * 100.0;
				shape_trial_correct_rej = arithmetic_mean( array_shape_trial_accuracy ) * 100.0;
				
				if shape_trial_accuracy < shape_target_min_accuracy then
					# accuracy too low
					shape_speed_description = "slower";
					shape_level_change = -(int(( shape_target_min_accuracy - shape_trial_accuracy ) / 1.75) + 1);
				elseif shape_trial_accuracy > shape_target_max_accuracy then
					# accuracy too high
					shape_speed_description = "faster";
					shape_level_change = int( abs( shape_target_max_accuracy - shape_trial_accuracy ) / 1.75) + 1;
				else
					# accuracy okay
					shape_speed_description = "at the same speed";
					shape_level_change = 0;
				end;
				
				# adjust difficulty level

				current_shape_level = current_shape_level + shape_level_change;
			
				# keep within level limits
				
				if current_shape_level < 1 then
					current_shape_level = 1
				elseif current_shape_level > array_shape_staircase_percentages.count() then
					current_shape_level = array_shape_staircase_percentages.count()
				else
				end;

			end;
		
		end; # ENDIF
	
		#########################################################################################
		#########################################################################################
		# PRESENT END OF TRIAL SUMMARY
		
		int median_shape_RT = int(round(median_value( array_shape_trial_all_RTs ), 0 ));
		
		if show_reset_message == true then
			prompt_message.set_caption( "Trial was terminated early.\n\nTrial difficulty will not be adjusted and the trial counter will not increment.\n\nA trial of the same type as before will now begin.", true );
			show_reset_message = false;
		
		elseif array_section_trials[section][trial_count] == 1 && phase == 1 && section == 1 then # disc/threshold
			prompt_message.set_caption( "Accuracy (time mouse spent on disc) for the previous trial was: " + string(round(tracking_accuracy,2)) + "%\n" +
				"The disc's speed will be " + disc_speed_description + " on the next trial.", true );

		elseif array_section_trials[section][trial_count] == 1 && ( ( phase == 1 && section == 2 ) || ( phase == 2 || phase == 3 ) ) then # disc/ not threshold
			prompt_message.set_caption( "Accuracy (time mouse spent on disc) for the previous trial was: " + string(round(tracking_accuracy,2)) + "%", true );

		elseif array_section_trials[section][trial_count] == 2 && phase == 1 && section == 1 then # shape/threshold
			prompt_message.set_caption( "Accuracy (correct response and correct rejections) for the previous trial was: " + string(round(shape_trial_accuracy,2)) + "%\n" +
				"Median reaction time (for trials where a response occurred) was: " + string(median_shape_RT) + "ms\n" +
				"Shapes will disappear " + shape_speed_description + " on the next trial.", true );

		elseif array_section_trials[section][trial_count] == 2 && ( ( phase == 1 && section == 2 ) || ( phase == 2 || phase == 3 ) ) then # shape
			prompt_message.set_caption( "Accuracy (correct response and correct rejections) for the previous trial was: " + string(round(shape_trial_accuracy,2)) + "%\n" +
				"Median reaction time (for trials where a response occurred) was: " + string(median_shape_RT) + "ms", true );

		elseif array_section_trials[section][trial_count] == 3 then # dual
			prompt_message.set_caption( "Accuracy (time mouse spent on disc) for the previous trial was: " + string(round(tracking_accuracy,2)) + "%\n" +
				"Accuracy (correct response and correct rejections) for the previous trial was: " + string(round(shape_trial_accuracy,2)) + "%\n" +
				"Median reaction time (for trials where a response occurred) was: " + string(median_shape_RT) + "ms\n", true );

		end;
		
		prompt_trial.present();
		
		trial_count = trial_count + 1;
	end;
	
	section = section + 1;
	
end;