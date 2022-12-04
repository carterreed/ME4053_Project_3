function [g] = get_position(g, thetaS)
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
%  thetaS: angle from 0 x to S vector
%
%  OUTPUT
%  g: placeholder for the struct pp, or cr
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 12/3/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%  rod.theta3: angle from 0 x to the connecting rod
%  S: distance from ground to either power piston or displacer
%
%  FUNCTIONS CALLED
%  N/A
%  START OF EXECUTABLE CODE
%

g.rod.theta3 = thetaS + asin((-g.crank.length / g.rod.length) * sin(g.crank.angle - thetaS)); % equation to calculate angle from x axis to connecting rod

g.S = (g.crank.length * sin(g.crank.angle)) + (g.rod.length * cos(g.rod.theta3 - thetaS)); % equation to calculate distance from ground OA to displacer and power piston

end





