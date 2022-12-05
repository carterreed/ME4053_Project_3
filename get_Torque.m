function [Torque] = get_Torque(pp,dp,TH,TL,R,totMass,Vregen,bore)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get_torque function
%
%  PURPOSE this program is to calculate the torque at the piston connecting
%  rod
%
%  INPUT
%  pp: struct for the power piston
%  dp: struct for the displacer
%  TH: higher temperature [K]
%  TL: low temperature [K]
%  R: ideal gas constant for air [J/kgK]
%  totMass: total mass of air in the engine
%  Vregen: regenerator dead volume [m^3]
%  bore: the diameter of the piston
%
%  OUTPUT
%  Torque:the Torque applied on the flywheel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR:Yupeng Ye
%  DATE: 12/09/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%   Torque:the Torque applied on the flywheel
%  FUNCTIONS CALLED
%  function Force= get_force(pp,dp,TH,TL,R,totMass,Vregen,bore)
%  START OF EXECUTABLE CODE
%

Torque_empty=zeros(1,length(pp.crank.angle));
beta=asin(pp.crank.length*sin(pp.crank.angle)/pp.rod.length);
Force= get_force(pp,dp,TH,TL,R,totMass,Vregen,bore);
if length(pp.crank.angle)==1
   Torque=Force*sin(beta)*pp.crank.length*cos(pp.crank.angle)+Force*cos(beta)*pp.crank.length*sin(pp.crank.angle);
elseif length(pp.crank.angle)>1
   for i=1:361
       Torque_empty(i)=Force(i)*sin(beta(i))*pp.crank.length*cos(pp.crank.angle(i))+Force(i)*cos(beta(i))*pp.crank.length*sin(pp.crank.angle(i));
   end
   Torque=Torque_empty;
end

end
