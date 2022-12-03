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

for n = 1:length(pp.crank.angle)

pressure(n) = (totMass * R) / ((pp.volume(n) / TL) + (dp.volume(n) / TH) + (Vregen / ((TH + TL) / 2)));

end 
