function [total_volume] = get_total_volume(dp, pp, Vregen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_total_volume
%
%  PURPOSE 
%  calculate the total volume within the engine as a function of crank angle
%  
%  INPUT
%  dp: struct for the displacer
%  pp: struct for the power piston
%  Vregen: regenerator dead volume [m^3]
%  
%  OUTPUT
%  total_volume: total volume of the fluid in the engine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/3/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  total_volume: total volume of the fluid in the engine
%
%  FUNCTIONS CALLED
%  N/A
%
%  START OF EXECUTABLE CODE
%

total_volume = dp.volume + pp.volume + Vregen; % equation to calculate the total volume of fluid within the engine

end