function [g] = get_position(g)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_position
%
%  PURPOSE 
%  To calculate the the distance from ground OA, to the power piston and
%  the displacer. This function allows both structs to be sent in to
%  calculate distance
%
%  INPUT
%  g: placeholder for the struct pp, or cr
%
%  OUTPUT
%  g: placeholder for the struct pp, or cr
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/3/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  thetaS: 
%  rod.angle: 
%  S: distance from ground to either 
%
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%


thetaS = deg2rad(90);

g.rod.angle = thetaS + asin((-g.crank.length / g.rod.length) * sin(g.crank.angle - thetaS)); 

g.S = (g.crank.length * sin(g.crank.angle)) + (g.rod.length * cos(g.rod.angle - thetaS));

end





