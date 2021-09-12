clc
clear all

load Ass2EMmap; %EM map
load ass2CEgas ; %ICE map

%Initialize battery
N_series = 40;         %Number of series cells
N_parallel = 3;         %Number  of parallel cells
Init_SoC = 85;          %Initial charge of battery [%]
min_SOC=0.35;             %Minimun SOC of the battery when sustainable mode in PHEV[%]
max_SOC=0.60;             %Maximun SOC of the battery when sustainable mode in PHEV[%]

%Initialize vehicle
V_Mass = 1920+200;          %Curb weight of the vehicle [kg]
V_area = 3.087;             %Vehicle cross section [m^2]
V_d = 0.35;                 %Drag coefficient [-]
V_RRC=0.02;                 %Rolling friction coefficient [-]
V_Rotating = 4;             %Rotating mass [%]
V_wheel_dia = 0.739;        %Wheel diameter [m]
rho_air = 1.2;              %Air Density [kg/m^3]

%Initialize GEARBOX
gears=6;                                        %Number of gears
gear_ratio = [3.7952 2.5 1.7 1.1 0.852 0.6];    %Gear box
diff_gear_opti = 4.50;                             %Final Drive Gear Ratio
gear_up = [10 35 60 90 120];                    %initial up shifts
gear_down = [2 15 30 70 95];                    %initial down shifts

gear_eff=0.95;                                  %Efficiency
gear_idling_loss=300;                           %Idling losses

%Electric Motor Gear Box
EM_gear_ratio=4.51;                     %Electric Motor gear ratio
EM_gear_eta=0.98;                       %Electric Motor gear efficiency
EM_idling_loss=0;                       %Electric Motor gear idling losses

max_index=find(w_EM_max==round(2150*2*pi/60));          %Finds the index of 2150 RPM as max power occurs at that
max_EM_power_old=T_EM_max(max_index)*w_EM_max(max_index);   %Finding the maximum EM Power currenly in the map

%Electric Motor Specification
max_EM_power=90;                        %Electric Motor Power[kW]

T_EM_col = T_EM_col * max_EM_power*1000/max_EM_power_old;    %Changing the torque vector 
T_EM_max = T_EM_max * max_EM_power*1000/max_EM_power_old;    %Changing the torque vector


%Engine Specification
max_CE_power= 60;                              %Engine Power [kW]

V_d	= max_CE_power*2/((5000/60)*(p_me_max(18)/1000));

T_CE_max = p_me_max*V_d/(2*pi*2);                           % Max torque

% Run Simulation
open('Opti_ICE_1_file');
sim('Opti_ICE_1_file');