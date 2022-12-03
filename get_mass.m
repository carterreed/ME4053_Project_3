function [m_total] = get_mass(dp, pp,R,TL,TH,P_min_BDC, Vregen)
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

%  AUTHOR:
%  DATE: 
%
%  DESCRIPTION OF LOCAL VARIABLES
%
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

for s = 1:length(dp.crank.angle)
    if (dp.crank.angle(s) == 0 || dp.crank.angle(s) == deg2rad(360))
        mass_exp = (P_min_BDC * dp.volume(s) / (R * TL));
    end
end

for t = 1:length(pp.crank.angle)

    if (pp.crank.angle(t) == deg2rad(270) || pp.crank.angle(t) == deg2rad(-90))
        mass_comp = (P_min_BDC * pp.volume(t) / (R * TH));
    end
end

massRegen = (P_min_BDC * Vregen) / (R * ((TH + TL) / 2));

m_total = mass_exp + mass_comp + massRegen;
end 