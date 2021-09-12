clc
run('init_Opti_ICE')         %Runs the initial condition

% Global variables
global t;
global N_sim;
global gear_result
global V_liter;
global V_result
global first_gear second_gear third_gear fourth_gear fifth_gear sixth_gear diff_gear up_12 up_23 up_34 up_45 up_56 do_21 do_32 do_43 do_54 do_65
global working_gearset

% Initialization of the optimization routine

gear_result = [];
V_result = [];
i_guess = [gear_ratio diff_gear_opti gear_up gear_down]';

% Optimization routine
disp('Optimization started...')
disp(' ')
tic
i_opt = fminsearch('Opti_sub_ICE', i_guess);
disp(' ')
disp('... optimization finished!')
toc

% Optimal Gears
gear_optimal = 6;
i_gear_optimal = [i_opt(1) i_opt(2) i_opt(3) i_opt(4) i_opt(5) i_opt(6)];
i_diff_optimal = i_opt(7);
up_opt_optimal = [i_opt(8) i_opt(9) i_opt(10) i_opt(11) i_opt(12)];
down_optimal = [i_opt(13) i_opt(14) i_opt(15) i_opt(16) i_opt(17)];
Fuel_Consumption_optimal = V_result(end);
save('opti_gear_box.mat','gear_optimal','i_gear_optimal','i_diff_optimal','up_opt_optimal','down_optimal','Fuel_Consumption_optimal')