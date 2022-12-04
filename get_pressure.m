function [pressure] = get_pressure(pp,dp,TH,TL,R,totMass,Vregen)
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
pressure = zeros;

for g= 1:length(pp.crank.angle)

    pressure(g) = (totMass * R) / ((dp.volume(g) / TH) + (pp.volume(g) / TL)  + (Vregen / ((TH + TL) / 2)));

end 
end