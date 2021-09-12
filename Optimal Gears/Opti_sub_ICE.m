function V_result1 = Opti_sub_ICE(x)

% Global variables

global t
global N_sim
global gear_result
global V_liter
global V_result
global first_gear second_gear third_gear fourth_gear fifth_gear sixth_gear diff_gear up_12 up_23 up_34 up_45 up_56 do_21 do_32 do_43 do_54 do_65
global working_gearset

% Set actual gear ratios
first_gear      = x(1);
second_gear     = x(2);
third_gear      = x(3);
fourth_gear     = x(4);
fifth_gear      = x(5);
sixth_gear      = x(6);
diff_gear       = x(7);

up_12 = x(8);
up_23 = x(9);
up_34 = x(10);
up_45 = x(11);
up_56 = x(12);

do_21 = x(13);
do_32 = x(14);
do_43 = x(15);
do_54 = x(16);
do_65 = x(17);


% Build matrix of gear ratio values
gear_result = [gear_result; x'];


% Checking if gear ratios make sense
if (first_gear > second_gear) && (second_gear > third_gear) && (third_gear > fourth_gear) && (fourth_gear > fifth_gear) && (fifth_gear > sixth_gear) ...
        && (up_12 > do_21) && (up_23 > do_32) && (up_34 > do_43) && (up_45 > do_54) && (up_56 > do_65) ...
        && (up_56 > up_45) && (up_45 > up_34) && (up_34 > up_23) && (up_23 > up_12)...
        && (do_65 > do_54) && (do_54 > do_43) && (do_43 > do_32) && (do_32 > do_21)
    
    sim('Optimal_Simulation_ICE');
    V_result1 = V_liter(max(size(t)));
else
    V_result1 = Inf;
end

% Check whether cycle could be finished exactly in N_sim computational steps

if (max(size(t)) < N_sim)
    V_result1 = Inf;
else
    working_gearset = x;
end

V_result=[V_result; V_result1];

disp(['V [liter/100 km] =       ',num2str(V_result1)]);

end