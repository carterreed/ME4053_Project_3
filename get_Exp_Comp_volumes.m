function [dp,pp] = get_Exp_Comp_volumes(CR,pp,dp,Vregen,bore)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_Exp_Comp_volumes
%
%  PURPOSE 
%  To calcualte the expansion and compression volumes as a function of
%  crank angle
%
%  INPUT
%  CR: compression ratio, dimentionless
%  pp: struct for the power piston
%  dp: struct for the displacer
%  Vregen: regenerator dead volume [m^3]
%  bore: cylinder bore, diameter [m]
%
%  OUTPUT
%  pp: struct for the power piston
%  dp: struct for the displacer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/3/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  Area: cross-sectional area of the cylinder
%  H: % height from OA to top of engine
%  dp.volume: expansion volume
%  pp.volume: compression volume
%
%  FUNCTIONS CALLED
%  N/A
%
%  START OF EXECUTABLE CODE
%

Area = pi * (bore ^2) / 4; %  area of the cyclinder 

H = ((-Area * CR * max(pp.S)) + (Area * min(pp.S)) + (CR * Vregen) - Vregen) / (Area - (Area * CR));  % equation for the height from OA to top of engine

dp.volume = abs(H - dp.S) * pi * ((bore^2) / 4); % equation to calculate expansion volume

pp.volume = abs(dp.S - pp.S ) * pi * ((bore^2) / 4); % equation to calculate compression volume

end

