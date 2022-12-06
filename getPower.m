function [Power_1, Power_2, Work] = getPower(Torque_average, w_avg, total_pressure, total_specific_volume)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: getPower
%
%  PURPOSE 
%  To calculate the power output of the stirling engine two different ways
%
%  INPUT
%
%  OUTPUT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/5/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  Power_1: 
%  Power_2: 
%  Work:
%
%  FUNCTIONS CALLED
%  N/A
%
%  START OF EXECUTABLE CODE
%

Power_1 = w_avg * Torque_average; % [W] calcualte power using average torque and average rotational velocity

Work = trapz(total_specific_volume, total_pressure); % calcualte area of the p-v diagram to get work

Power_2 = Work  / 0.03; % [W] calculate power using the p-v diagram then dividing by the time for one cycle



