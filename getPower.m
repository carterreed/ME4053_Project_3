function [Power_1, Power_2, Work] = getPower(Torque_average, w_avg, total_pressure, total_specific_volume)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: getPower
%
%  PURPOSE 
%  To calculate the power output of the stirling engine two different ways
%
%  INPUT
%  Torque_average: average torque applied by the flywheel
%  w_avg: average rotational velocity [rad/s]
%  total_pressure: total pressure in the engine
%  total_specific_volume: total pressure divided by total mass in the
%  engine
%
%  OUTPUT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/5/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  Power_1: way one to calculate power
%  Power_2: way two to calculate power
%  Work: net work out of the stirling engine
%
%  FUNCTIONS CALLED
%  N/A
%
%  START OF EXECUTABLE CODE
%

Power_1 = w_avg * Torque_average; % [W] calcualte power using average torque and average rotational velocity

Work = trapz(total_specific_volume, total_pressure); % calcualte area of the p-v diagram to get work

Power_2 = Work  / 0.03; % [W] calculate power using the p-v diagram then dividing by the time for one cycle



