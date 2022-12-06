function [pressure] = get_pressure(pp,dp,totMass, Vregen, TH, TL,R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_pressure
%
%  PURPOSE 
%  get the pressure within the engine as a function of crank angle
%
%  INPUT
%  pp: struct for the power piston
%  dp: struct for the displacer
%  TH: higher temperature [K]
%  TL: low temperature [K]
%  R: ideal gas constant for air [J/kgK]
%  totMass: total mass of air in the engine
%  Vregen: regenerator dead volume [m^3]
%  
%  OUTPUT
%  pressure: pressure within the engine as a function of crank angle
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/3/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  pressure: pressure within the engine as a function of crank angle
%
%  FUNCTIONS CALLED
%  N/A
%
%  START OF EXECUTABLE CODE
%

pressure = zeros; % establish an array to fill with pressure values calculated below

for g= 1:length(pp.crank.angle)

    pressure(g) = (totMass * R) / ((dp.volume(g) / TH) + (pp.volume(g) / TL)  + ((Vregen / (TH + TL) / 2))); % euqation to calculate pressure on the power piston. this is due to the pressure on the displacer happens on top and bottom so they cancel out

end 
end