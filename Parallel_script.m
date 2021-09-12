clear all
clc
warning off
close all

%Maps
%EM Map
load Ass2EMmap
% ICE Map
load ass2CEgas

% SUV

%Initialize battery
N_series = 35;          %Number of series cells
N_parallel = 5;         %Number  of parallel cells
Init_SoC = 45;          %Initial charge of battery [%]
min_SOC=0.35;           %Minimun SOC of the battery when sustainable mode in PHEV[%]
max_SOC=0.60;           %Maximun SOC of the battery when sustainable mode in PHEV[%]

%Initialize vehicle
V_Mass = 1920;                  %Curb weight of the vehicle [kg]
Parallel_add_Mass = 200;        %Additional mass due to parallel configuration
V_area = 3.087;                 %Vehicle cross section [m^2]
V_d = 0.35;                     %Drag coefficient [-]
V_RRC=0.02;                     %Rolling friction coefficient [-]
V_Rotating = 4;                 %Rotating mass [%]
V_wheel_dia = 0.739;            %Wheel diameter [m]


%Initialize Gear Box
Gears=6;                                                %Number of gears
gear_ratio=[3.6657 2.4933 1.7945 1.3201 0.9386 0.6875]; %Gear Ratios
diff_gear=4.51;                                         %Differential gear
gear_up=[9.6305 35.4860 46.8741 82.1634 150.9009];      %Up-shifting speeds
gear_down=[2.1238 16.0393 30.2609 60.0625 97.9696];     %Down-shifting speeds
gear_eff=0.95;                                          %Efficiency
gear_idling_loss=0;                                   %Idling losses

%Electric Motor Gear Box
EM_gear_ratio=4.51;                     %Electric Motor gear ratio
EM_gear_eta=0.98;                       %Electric Motor gear efficiency
EM_idling_loss=0;                       %Electric Motor gear idling losses

max_index=find(w_EM_max==round(2150*2*pi/60));              %Finds the index of 2150 RPM as max power occurs at that speed
max_EM_power_old=T_EM_max(max_index)*w_EM_max(max_index);   %Finding the maximum EM Power currenly in the map

%Electric Motor Specification
max_EM_power=65;                                            %Electric Motor Power[kW]

T_EM_col = T_EM_col * max_EM_power*1000/max_EM_power_old;   %Changing the torque vector 
T_EM_max = T_EM_max * max_EM_power*1000/max_EM_power_old;   %Changing the torque vector

%Engine Specification
max_CE_power= 85;                                           %Engine Power [kW]

V_d	= max_CE_power*2/((5000/60)*(p_me_max(18)/1000));       %Engine Volume

T_CE_max = p_me_max*V_d/(2*pi*2);                           %Max torque

open('Parallel_Hybrid')
parallel_sim=sim('Parallel_Hybrid');

% Plot the operating points
Eng_plot(max_CE_power, parallel_sim.T_CE, parallel_sim.w_CE)        %Engine operating point plot
motor_plot(max_EM_power,parallel_sim.T_EM, parallel_sim.w_EM)       %Motor operating point plot