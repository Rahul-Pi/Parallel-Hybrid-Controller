# Parallel-Hybrid-Controller

An ICE based Sports Utility Vehicle is converted to a mild-parallel hybrid to reduce the fuel consumption.

A simulation based on QSS Toolbox developed by ETH Zurich. The controller is programmed such that the SOC of the battery at the end of the cycle is the same as during the start!

The QSS model:

<p align="center">
<img src="https://rahulrpai.files.wordpress.com/2021/09/parallel_hybrid.jpg">
</p>


# Instructions for running the program
Run the Parallel_Script.m file. The simulation will open and also the engine, motor plot will be done automatically

(This uses the Eng_Plot and motor_plot script in the folder and the plots can be found under the figure folder within the same main folder)



The variation of SOC throughout the driving cycle:

<p align="center">
<img src="https://rahulrpai.files.wordpress.com/2021/09/parallel-soc.png">
</p>


The optimal gears for the engine connected gear box are calculated using the folder Optimal Gears.

To do this run the Gear_optimisation_main_file.m file.


!!! Caution: This optimisation can take around 30 minutes. !!!
The results of this is saved in the opti_gear_box.mat file
