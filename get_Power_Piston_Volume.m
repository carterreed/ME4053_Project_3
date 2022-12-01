function [power_piston_volume] = get_Power_Piston_Volume(pp, dp, bore)
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

thetaS = (90 * pi / 180);

dp.theta3 = thetaS + asin(dp.crank.length / dp.rod.length*sin(dp.theta2 - thetaS));

pp.theta3 = thetaS + asin(pp.crank.length / pp.rod.length *sin(pp.theta2 - thetaS));

dp.S = imag(dp.crank.length * (cos(dp.theta2) + (1j*sin(dp.theta2)))) + imag(dp.rod.length*(cos(dp.theta3) + 1j*sin(dp.theta3)));

pp.S = imag(pp.crank.length * (cos(pp.theta2) + (1j*sin(dp.theta2)))) + imag(pp.rod.length*(cos(pp.theta3) + 1j*sin(pp.theta3)));

power_piston_volume = (dp.S - pp.S) * pi * (bore^2)/4;

plot(pp.theta2, power_piston_volume)

