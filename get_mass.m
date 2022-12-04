function [totMass] = get_mass(pp,dp, Vregen, TH, TL,R, P_min_BDC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_mass
%
%  PURPOSE
%  Find the total mass of the fluid within the engine
%
%  INPUT
%  pp: struct for the power piston
%  dp: struct for the displacer
%  TH: higher temperature [K]
%  TL: low temperature [K]
%  R: ideal gas constant for air [J/kgK]
%  Vregen: regenerator dead volume [m^3]
%  P_min_BDC: gas pressure at bottom dead center[Pa]
%
%  OUTPUT
%  totMass: total mass of air in the engine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/3/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  ppvolumeBDC: compression volume at BDC
%  dpvolumeBDC: expansion volume when power piston is at bottom bead center
%
%  FUNCTIONS CALLED
%  N/A
%
%  START OF EXECUTABLE CODE
%

% run throough the crank angles of the power piston until the power piston
% is at BDC then extract that volume. Set that volume to a variable to get
% mass 
for g = 1: length(pp.crank.angle)
    if (pp.crank.angle(g) == deg2rad(270))
        ppvolumeBDC = pp.volume(g);
        dpvolumeBDC = dp.volume(g);
    end
end

totMass = (P_min_BDC / R ) * ((ppvolumeBDC/ TL) + (dpvolumeBDC / TH) + (2* Vregen / (TH+TL))); % equation to calculte the mass of the fluid within the engine

end
