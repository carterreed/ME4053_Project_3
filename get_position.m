function [g] = get_position(g)
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


thetaS = deg2rad(90);

g.rod.angle = thetaS + asin((-g.crank.length/g.rod.length)*sin(g.crank.angle-thetaS)); 

g.S = g.crank.length*sin(g.crank.angle)+g.rod.length*cos(g.rod.angle-thetaS);

end





