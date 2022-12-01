%function [] = Project3MainCode()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Project3MainCode
%
%  PURPOSE 
%
%  INPUT
%  N/A
%
%  OUTPUT
%  N/A
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Carter Reed
%  DATE: 11/30/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

% known variables
pp.crank.length = 0.0138; % power piston crank length[m] 
pp.rod.length = 0.046; % power piston connecting rod length[m]

dp.crank.length = 0.0138; % displacer crank length, [m]
dp.rod.length = 0.0705; % diplacer connecting rod length[m]
d_volume = 0; % displacer volume[m^3]

bore = 0.07; % cylinder bore [m]

phase = 90; % phase shift [m]
CR = 1.58; % compression ratio, dimentionless 
TH = 900; % higher temperature [K]
TL = 300; % low temperature [K]
R = 287; % ideal gas constant for air [J/kgK]
P_min_BDC = 500000; % gas pressure at bottom dead center[Pa]
Vregen = 0.00001; % regenerator dead volume [m^3]

fly.width = 0.05; % width of flywheel[m]
fly.thick = 0.07; % thickness of flywheel [m]
Cf = 0.002; % coefficient of fluctuation dimenstionless 
w_avg = (200 / 60) * 2 * pi; % average rotational velocity [rad/s]

dp.theta2 = 0: 1 * pi / 180 : 360 * pi / 180;
pp.theta2 = (90 * pi / 180)  + dp.theta2;


% change in power piston volume 
V1 = get_Power_Piston_Volume(pp, dp, bore);












