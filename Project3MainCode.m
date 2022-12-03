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
theta = deg2rad(-90): deg2rad(1):deg2rad(270); % convertting from degrees to radian, starting at BDC
theta2 = 0:1:360; % crank angle array
pp.crank.length = 0.0138; % power piston crank length[m] 
pp.rod.length = 0.046; % power piston connecting rod length[m]
pp.crank.angle = theta;

dp.crank.length = 0.0138; % displacer crank length, [m]
dp.rod.length = 0.0705; % diplacer connecting rod length[m]
dp.crank.angle = theta+deg2rad(90); %  diplacer crank angle

bore = 0.07; % cylinder bore, diameter [m]
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

% find the positions of both the power piston and the displacer 
pp = get_position(pp);
dp = get_position(dp);

% find maximum height from the ground to top of engine
H = get_max_height(CR,pp,Vregen,bore);

% find volumes for both the power piston and the dispalcer
dp.volume = abs(H - dp.S) * pi * ((bore^2)/4); % expansion volume
pp.volume = abs(dp.S - pp.S ) * pi * ((bore^2)/4); % compression volume

% find total volume of the system
total_volume = dp.volume + pp.volume + Vregen;

% find masses within the expansion volume, compression volume, and regen
% vulume, then get a total mass within the system
totMass = get_mass(dp,pp,R,TL,TH, P_min_BDC, Vregen);

% find the total pressure within the system
total_pressure = get_pressure(pp,dp,TH,TL,R,totMass,Vregen);

% find force on power piston 
force_piston = total_pressure / (((bore^2) / 4) * pi);

% find the specific volume
total_specific_volume = total_volume/totMass;

% get values for ideal engine cycle


%% plotting
% graph volume as a function of crankk angle
figure(1)
hold on
plot(theta2,total_volume, 'DisplayName', "Vtotal")
plot(theta2,pp.volume,'DisplayName', "Vcomp")
plot(theta2,dp.volume, 'DisplayName', "Vexp")
yline(Vregen, 'DisplayName', "Vregen")
hold off
title ('Volume versus Crank Agnle')
legend('location', 'best')
xlabel('Crank Angle [deg]')
ylabel('Volume [m^3]')
xlim([0 360])

% graph pressure versus theta
figure(2)
plot(theta2, total_pressure / 1000)
xlabel('Crank Angle [deg]')
ylabel('Pressure [kPa] ')
title('Pressure versus Crank Angle')

% graph force versus theta 
figure(3)
plot (theta2, force)
xlabel('Crank Angle [deg]')
ylabel('Force [N] ')
title('Force versus Crank Angle')

% graph specific volume vs. pressure
figure(4)
plot (total_specific_volume,(total_pressure)/1000)
xlabel('specific volume [m^3/kg]')
ylabel('Pressure [kPa]')
title('Pressure Versus Specific Volume for a Stirling Engine')
