function [totMass] = get_mass(dp,pp,R,TL,TH, P_min_BDC, Vregen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_mass
%
%  PURPOSE:
%
%  INPUT
%
%  OUTPUT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR:
%  DATE: 
%
%  DESCRIPTION OF LOCAL VARIABLES
%
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

for g = 1: length(pp.crank.angle)
    if (pp.crank.angle(g) == deg2rad(-90))
        ppvolumeBDC = pp.volume(g);
        dpvolumeBDC = dp.volume(g);
    end
end

totMass = (P_min_BDC / R ) * (((ppvolumeBDC)/ TL) + ((dpvolumeBDC) / TH) + (Vregen / (TH+TL) / 2));

