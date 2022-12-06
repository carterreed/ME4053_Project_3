function Torque=get_Torque(pp,dp,TH,TL,R,totMass,Vregen,bore, force)
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
Torque_empty=zeros(1,length(pp.crank.angle)); 
beta=asin(pp.crank.length*sin(pp.crank.angle)/pp.rod.length);

if length(pp.crank.angle)==1
   Torque=force*sin(beta)*pp.crank.length*cos(pp.crank.angle)+force*cos(beta)*pp.crank.length*sin(pp.crank.angle);
elseif length(pp.crank.angle)>1
   for i=1:361
       Torque_empty(i)=force(i)*sin(beta(i))*pp.crank.length*cos(pp.crank.angle(i))+force(i)*cos(beta(i))*pp.crank.length*sin(pp.crank.angle(i));
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



