function [ I ]  = TorqueToInertia(x, y, Cf, w)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME:TorquetoInertia
%
%  PURPOSE
%   Use torque at each angle to find average torque, change in KE, and I
%  INPUT
%   x: crank angle
%   y: torque at each crank angle
%   Cf: Coefficient of fluctuation
%   w: average rotational velocity, in radians
%  OUTPUT
%   I: flywheel moment of inertia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Tian Huang
%  DATE: 12/3/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   Int: integral of torque data
%   T_avg: average torque
%   yZeroed: Torque data - average torque
%   xDome: angles where the dome is formed
%   yDome: positive section of yZeroed
%   KE: change in kinetic energy
%
%  FUNCTIONS CALLED
%   trapz, plot
%  START OF EXECUTABLE CODE
%
figure
hold on
plot(x,y);

Int = trapz(x,y);
T_avg = Int/(2*pi);

%this bit is for visualization of T average on the graph
AvgX = [0, 2*pi];
AvgY = [T_avg,T_avg];
figure(6)
plot(AvgX, AvgY);

yZeroed = zeros(1, length(x)); %shift the entire graph down so zeros can be found
for i = 1:length(x)
    yZeroed(i) = y(i)-T_avg;
end

for i=1:length(x)
    if (yZeroed(i)*yZeroed(i+1))<0
        %disp('made it into if')
        itheta0 = i; %beginning of "dome"
        break
    end
end

for i=itheta0+1:length(x)
    if yZeroed(i)*yZeroed(i+1)<0
        ithetaf = i+2; %end of "dome"
        break
    end
end

%the idea is to isolate the "dome" of the torque plot
xDome = linspace(x(itheta0),x(ithetaf),ithetaf-itheta0);
yDome = zeros(1, ithetaf-itheta0);

for i = 1:length(yDome)
    yDome(i) = yZeroed(i+itheta0-1);
end

figure(7)
plot(xDome,yDome); %feel free to check the plot to make sure this part was done correctly
KE = trapz(xDome,yDome); %note that the first and last terms of yDome are negative, but they *should* be negligible

I = KE/(Cf*w^2);
end