function [dp,pp] = get_Exp_Comp_volumes(CR,pp,dp,Vregen,bore)
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

A = pi * (bore / 2) ^2; %  area of the cyclinder 

H = (CR * max(pp.S) - CR * (Vregen / A) - min(pp.S) + (Vregen / A)) / (CR-1); % height from OA to top of engine
dp.volume = abs(H - dp.S) * pi * ((bore^2)/4); % expansion volume
pp.volume = abs(dp.S - pp.S ) * pi * ((bore^2)/4); % compression volume

end