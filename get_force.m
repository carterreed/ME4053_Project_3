function Force= get_force(pp,dp,TH,TL,R,totMass,Vregen,bore)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: get force function
%
%  PURPOSE this program is to calculate the force at the piston connecting
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
%  Force:the force at connecting rod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR:Yupeng Ye
%  DATE: 12/09/2022
%
%  DESCRIPTION OF LOCAL VARIABLES
%   Force:the force at connecting rod
%  FUNCTIONS CALLED
%  function [pressure] = get_pressure(pp,dp,totMass, Vregen, TH, TL,R)
%  START OF EXECUTABLE CODE
%
Force_empty=zeros(1,length(pp.crank.angle));
beta=asin(pp.crank.length*sin(pp.crank.angle)/pp.rod.length);
p_0=101*10^3;
area=pi*(bore^2)/4;
total_pressure = get_pressure(pp,dp,TH,TL,R,totMass,Vregen);
if length(pp.crank.angle)==1
   if pp.crank.angle< 180 
       Force=((total_pressure-p_0)*area)/(cos(beta)+sin(beta));
   else
        Force=((total_pressure-p_0)*area)/(cos(beta)-sin(beta));
   end
elseif length(pp.crank.angle)>1
   for i=1:361
       if pp.crank.angle< 180 
           Force_empty(i)=((total_pressure(i)-p_0)*area)/(cos(beta(i))+sin(beta(i)));
       else
           Force_empty(i)=((total_pressure(i)-p_0)*area)/(cos(beta(i))-sin(beta(i)));
       end
   end
   Force=Force_empty;
end
end
