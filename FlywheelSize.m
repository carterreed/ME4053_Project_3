function [ m, Do, Di ]  = FlywheelSize(I,steel_d,fly)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: FlywheelSize
%
%  PURPOSE: Computes the size and mass of a flywheel based on the mass moment of
%  intertia
%
%  INPUT: I -mass moment of intertia [kg*m^2]
% 
%  OUTPUT: m - mass of flywheel [kg]
%   Do - outer diameter of flywheel [m]
%   Di - Inner diameter of flywheel [m]
% 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  AUTHOR: Project 3 Group 8 (Mike Fleming)
%  DATE: 12/4/22
%  FUNCTIONS CALLED
%   fzero - used to find the root of an equation
%
%  START OF EXECUTABLE CODE
%

%----------------------------------------------------------------------%
% EQUATIONS USED TO FIND THE OUTER DIAMETER OF THE FLYWHEEL
%----------------------------------------------------------------------%
% D_inner=Douter-2*thickness;
% Vol=(pi(1)/4)*(Douter^2-(Douter-2*thickness)^2)*width;
%mass=steel_dens*Vol 
%Rinner=(Douter-2*thickness)/2
%Router=(Douter/2)
%I=(1/2)*mass*(Rinner^2+Router^2)


%----------------------------------------------------------------------%
% SET UP FUNCTION TO SOLVE FOR OUTER DIAMETER USING FZERO
%----------------------------------------------------------------------%

%density of steel = 8000 [kg*m2]
%flywheel thickness= 0.07 [m]
%flywheel width = 0.05 [m]


% x is used as a dummy variable for Douter 
fcn=@(Do) ((1/2)*steel_d*(3.14159/4)*(Do^2-(Do-(2*fly.thick))^2)*fly.width*...
    (((Do-(2*fly.thick))/2)^2+(Do/2)^2))-I;

%solve function 'fcn' to find the outer diameter Do
Do=fzero(fcn,1);

%solve for outer 
Di=Do-(2*fly.thick);

%Calculate the volume of the flywheel
Vol=(3.14159/4)*(Do^2-(Di)^2)*fly.width;

%Using calculated volume of the flywheel, find the mass of the flywheel
m=steel_d*Vol;



end






