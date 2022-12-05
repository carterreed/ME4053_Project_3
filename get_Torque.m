function [Torque_average, Torque] = get_Torque(pp, total_pressure, bore, theta2)
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

Force_empty=zeros(1,length(pp.crank.angle));
beta=asin(pp.crank.length*sin(pp.crank.angle)/pp.rod.length);
p_0=101*10^3;
area=pi*(bore^2)/4;
if length(pp.crank.angle)==1
   if pp.crank.angle< deg2rad(180)
       Force=((total_pressure-p_0)*area)/(cos(beta)+sin(beta));
   else
        Force=((total_pressure-p_0)*area)/(cos(beta)-sin(beta));
   end
elseif length(pp.crank.angle)>1
   for i=1:361
       if pp.crank.angle< deg2rad(180)
           Force_empty(i)=((total_pressure(i)-p_0)*area)/(cos(beta(i))+sin(beta(i)));
       else
           Force_empty(i)=((total_pressure(i)-p_0)*area)/(cos(beta(i))-sin(beta(i)));
       end
   end
   Force=Force_empty;
end
Torque_empty=zeros(1,length(pp.crank.angle));
if length(pp.crank.angle)==1
   Torque=Force*sin(beta)*pp.crank.length*cos(pp.crank.angle)+Force*cos(beta)*pp.crank.length*sin(pp.crank.angle);
elseif length(pp.crank.angle)>1
   for i=1:361
       Torque_empty(i)=Force(i)*sin(beta(i))*pp.crank.length*cos(pp.crank.angle(i))+Force(i)*cos(beta(i))*pp.crank.length*sin(pp.crank.angle(i));
   end
   Torque=Torque_empty;
end
Torque_average= trapz(pp.crank.angle,Torque)/(max(pp.crank.angle)-min(pp.crank.angle));
figure(1)
plot (theta2, Torque)
yline(Torque_average)
xlabel('Crank Angle [deg]')
ylabel('Torque [Nm] ')
title('Torque versus Crank Angle')
legend('Torque on Flywheel','Average Torque')
xlim([0 360])



