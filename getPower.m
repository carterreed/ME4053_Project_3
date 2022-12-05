function [Power_1, Power_2] = getPower(Torque_average, w_avg, total_pressure, total_specific_volume)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: 
%
%  PURPOSE 
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
%
%  START OF EXECUTABLE CODE
%

Power_1 = w_avg * Torque_average; % [W] calcualte power using average torque and average rotational velocity

Work = trapz(total_specific_volume, total_pressure); % calcualte area of the p-v diagram to get work

Power_2 = Work * w_avg; % [W] calculate power using the p-v diagram



