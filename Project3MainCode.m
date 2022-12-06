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
%  get_position:
%  get_Exp_Comp_volumes:
%  get_total_volume: 
%  get_mass: 
%  get_pressure: 
%  get_Torque: 
%  TorqueToInertia: Use torque at each angle to find average torque, change in KE, and I
%
%  START OF EXECUTABLE CODE
%

% Establish known variables
pp.crank.length = 0.0138; % power piston crank length[m] 
pp.rod.length = 0.046; % power piston connecting rod length[m]

dp.crank.length = 0.0138; % displacer crank length, [m]
dp.rod.length = 0.0705; % diplacer connecting rod length[m]

bore = 0.07; % cylinder bore, diameter [m]
CR = 1.58; % compression ratio, dimentionless 
TH = 900; % higher temperature [K]
TL = 300; % low temperature [K]
R = 287; % ideal gas constant for air [J/kgK]
P_min_BDC = 500000; % gas pressure at bottom dead center[Pa]
Vregen = 0.00001; % regenerator dead volume [m^3]
steel_d = 8000; % density of steel [kg/m^3]

fly.width = 0.05; % width of flywheel[m]
fly.thick = 0.07; % thickness of flywheel [m]
Cf = 0.002; % coefficient of fluctuation, dimenstionless 
w_avg = (2000 / 60) * 2 * pi; % average rotational velocity [rad/s]

% establish angles
theta = 0:1:360; % crank angle array to plot with 
theta2 = deg2rad(-90): deg2rad(1):deg2rad(270); % converting from degrees to radian
pp.crank.angle = theta2; % power piston crank angle
dp.crank.angle = theta2+deg2rad(90); %  diplacer crank angle

% find the positions of both the power piston and the displacer 
pp = get_position(pp);
dp = get_position(dp);

% find volumes for both the power piston and the dispalcer
[dp,pp] = get_Exp_Comp_volumes(CR,pp,dp,Vregen,bore);

% find total volume of the system
total_volume = get_total_volume(dp, pp, Vregen);

% find masses within the expansion volume, compression volume, and regen
% vulume, then get a total mass within the system
totMass = get_mass(dp,pp,R,TL,TH, P_min_BDC, Vregen);

% find the total pressure within the system
total_pressure = get_pressure(pp,dp,TH,TL,R,totMass,Vregen);

% find force on power piston 
force= total_pressure / (((bore^2) / 4) * pi);

% find torque on crank
Torque=get_Torque(pp,dp,TH,TL,R,totMass,Vregen,bore, force);

% calculate torque based on total pressure on piston and plot results
[Torque_average, Torque] = get_Torque(pp, total_pressure, bore, theta);

% use the results from torque to calculate moment of intertia of flywheel
I = TorqueToInertia(theta2, Torque, Cf, w_avg);

% find the specific volume
total_specific_volume = total_volume/totMass;

% caalculate size of flywheel
[ m, Do, Di ]  = FlywheelSize(I,steel_d,fly);

% calculate power using 2 different methods
[Power_1, Power_2, Work] = getPower(Torque_average, w_avg, total_pressure, total_specific_volume);

% get variables for sterling cycle
v_r=min(total_volume);
v_l=max(total_volume);
volume_plot=linspace(v_l,v_r,1000);
p_b=totMass*R*TH./volume_plot;
p_t=totMass*R*TL./volume_plot;

%% plotting
% graph volume as a function of crankk angle
figure(2)
hold on
plot(theta,total_volume, 'DisplayName', "Vtotal")
plot(theta,pp.volume,'DisplayName', "Vcomp")
plot(theta,dp.volume, 'DisplayName', "Vexp")
yline(Vregen, 'DisplayName', "Vregen")
hold off
title ('Volume versus Crank Angle')
legend('Vtotal', 'Vcomp', 'Vexp', 'Location', 'Best')
xlabel('Crank Angle [deg]')
ylabel('Volume [m^3]')
xlim([0 360])

% graph pressure versus theta
figure(3)
plot(theta, total_pressure / 1000)
xlabel('Crank Angle [deg]')
ylabel('Pressure [kPa] ')
title('Pressure versus Crank Angle')
xlim([0 360])

figure(3)
plot (theta, Torque)
yline(Torque_average)
xlabel('Crank Angle [deg]')
ylabel('Torque [Nm] ')
title('Torque versus Crank Angle')
legend('Torque on Flywheel','Average Torque')
xlim([0 360])

% graph Force versus theta at the piston due to pressure
figure(4)
plot (theta, force)
xlabel('Crank Angle [deg]')
ylabel('Force [N] ')
title('Force versus Crank Angle')
xlim([0 360])

% graph pressure versus specific volume for sterling engine and sterling
% cycle
figure(5)
plot (total_specific_volume,total_pressure / 1000)
xlabel('specific volume [m^3/kg]')
ylabel('Pressure [kPa]')
title('Pressure Versus Specific Volume for a Stirling Engine')
hold on
plot(volume_plot/totMass,p_b/1000,'g')
hold on
plot(volume_plot/totMass,p_t/1000,'b')
hold on
line([v_r./totMass,v_r./totMass],[max(p_t/1000),max(p_b/1000)],'color','c')
line([v_l./totMass,v_l./totMass],[min(p_t/1000),min(p_b/1000)],'color','m')

