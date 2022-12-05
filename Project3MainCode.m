%function = Project3MainCode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Project3MainCode
%
%  PURPOSE 
%  to establish known dimanetions and angle, call relevent functions to
%  solve the flywheel project, and plot the requeired deliverables 
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
%  pp: struct for the power piston
%  dp: struct for the displacer
%  pp.crank.length: power piston crank length[m] 
%  pp.rod.length: power piston connecting rod length[m]
%  bore: cylinder bore, diameter [m]
%  CR:  compression ratio, dimentionless
%  TH:  higher temperature [K]
%  TL: low temperature [K]
%  R: ideal gas constant for air [J/kgK]
%  P_min_BDC: gas pressure at bottom dead center[Pa]
%  Vregen: regenerator dead volume [m^3]
%  fly.width: width of flywheel[m]
%  fly.thick: thickness of flywheel [m]
%  Cf: coefficient of fluctuation, dimenstionless
%  w_avg: average rotational velocity [rad/s]
%  theta: crank angle array to plot with
%  thetaS: angle from 0 x to S vector
%  theta2: crank angle array converting degrees to radians using deg2rad command
%  pp.crank.angle: power piston crank angle
%  dp.crank.angle: diplacer crank angle accounting for 90 degree phase
%  total_volume: total volume within the engine
%  total_specific_volume: total specific volume within the engine
%  force: force due to pressure on the power piston
%
%  FUNCTIONS CALLED
%  get_position: To calculate the the distance from ground OA, to the power piston and the displacer. This function allows both structs to be sent in to calculate distance
%  get_Exp_Comp_volumes: get the pressure within the engine as a function of crank angle
%  get_total_volume: calculate the total volume within the engine as a function of crank angle
%  get_mass: Find the total mass of the fluid within the engine
%  get_pressure: get the pressure within the engine as a function of crank angle
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

fly.width = 0.05; % width of flywheel[m]
fly.thick = 0.07; % thickness of flywheel [m]
Cf = 0.002; % coefficient of fluctuation, dimenstionless 
w_avg = (2000 / 60) * 2 * pi; % average rotational velocity [rad/s]

% establish angles
theta = 0:1:360; % crank angle array to plot with 
theta2 = deg2rad(0): deg2rad(1):deg2rad(360); % converting from degrees to radian
pp.crank.angle = theta2; % power piston crank angle
dp.crank.angle = theta2+deg2rad(90); %  diplacer crank angle
thetaS = deg2rad(90); % angle from 0 x to S vector

% find the distance from ground OA to both power piston and displacer
pp = get_position(pp, thetaS);
dp = get_position(dp, thetaS);

% find volumes for both the power piston and the dispalcer, aka expansion
% and compression volumes
[dp,pp] = get_Exp_Comp_volumes(CR,pp,dp,Vregen,bore);

% find total volume of the engine
total_volume = get_total_volume(dp, pp, Vregen);

% get the total mass within the engine
totMass = get_mass(pp,dp, Vregen, TH, TL,R, P_min_BDC);

% find the total pressure within the engine 
total_pressure = get_pressure(pp,dp,totMass, Vregen, TH, TL,R);

% find the force on the power piston
force = (total_pressure - 101300) * (((bore^2) / 4) * pi);

% Find force act on the crank
Force = get_force(pp,dp,TH,TL,R,totMass,Vregen,bore);

% calculate torque based on total pressure on piston and plot results
Torque= get_Torque(pp,dp,TH,TL,R,totMass,Vregen,bore);
Torque_average= trapz(pp.crank.angle,Torque)/(max(pp.crank.angle)-min(pp.crank.angle));

% use the results from torque to calculate moment of intertia of flywheel
I = TorqueToInertia(theta2, Torque, Cf, w_avg);

% find the specific volume
total_specific_volume = total_volume/totMass;

% get variables for sterling cycle
v_r=min(total_volume);
v_l=max(total_volume);
volume_plot=linspace(v_l,v_r,1000);
p_b=totMass*R*TH./volume_plot;
p_t=totMass*R*TL./volume_plot;

%% plotting
% graph volume as a function of crankk angle
figure(1)
hold on
plot(theta ,total_volume, 'DisplayName', "Vtotal")
plot(theta ,pp.volume,'DisplayName', "Vcomp")
plot(theta ,dp.volume, 'DisplayName', "Vexp")
yline(Vregen, 'DisplayName', "Vregen")
hold off
title ('Volume versus Crank Angle')
legend('Vtotal', 'Vcomp', 'Vexp', 'Vregen', 'Location', 'Best')
xlabel('Crank Angle [deg]')
ylabel('Volume [m^3]')
xlim([0 360])

% graph pressure versus theta
figure(2)
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
legend('Torque on Flywheel','Average Torque', 'Location', 'Best')
xlim([0 360])

% graph Force versus theta at the piston connecting rod
figure(4)
plot (theta, Force)
xlabel('Crank Angle [deg]')
ylabel('Force [N] ')
title('Force at the Conmnecting Rod versus Crank Angle')
xlim([0 360])

% graph Force versus theta at the piston due to pressure
figure(5)
plot (theta, force)
xlabel('Crank Angle [deg]')
ylabel('Force [N] ')
title('Force versus Crank Angle due to Pressure')
xlim([0 360])

% graph pressure versus specific volume for sterling engine and sterling
% cycle
figure(6)
plot (total_specific_volume,total_pressure / 1000)
xlabel('specific volume [m^3/kg]')
ylabel('Pressure [kPa]')
title('Pressure Versus Specific Volume for a Stirling Engine and Sterling Cycle')
hold on
plot(volume_plot/totMass,p_b/1000,'g')
hold on
plot(volume_plot/totMass,p_t/1000,'g')
hold on
line([v_r./totMass,v_r./totMass],[max(p_t/1000),max(p_b/1000)],'color','g')
line([v_l./totMass,v_l./totMass],[min(p_t/1000),min(p_b/1000)],'color','g')
legend('Sterling Engine','Ideal Sterling Cycle')
