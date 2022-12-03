function [h] = get_max_height(CR,pp,Vregen,bore)
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

h = (CR * max(pp.S) - CR * (Vregen / A) - min(pp.S) + (Vregen / A)) / (CR-1); % 

end