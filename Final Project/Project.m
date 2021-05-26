clc; clear; close all; 

q0  = [0 0 0 0 0 0]; % position 0 coordinates 
q1 = [.1 .2 .3 .4 .5 .6]; %posiiton 1 coordinates

%Lengths of each arm of the robot
Length1 = .5; 
Length2 = .2;
Length3 = .4;
Length4 = .02;
Length5 = .08;
Length6 = .4;

%offset values - it was easier for me to think in degrees
Offset1 = deg2rad(180);
Offset2 = deg2rad(90);
Offset3 = deg2rad(90);
Offset4 = deg2rad(180);
Offset5 = deg2rad(180);
Offset6 = deg2rad(0);

%alpha values - it was easier for me to think in degrees
Alpha1 = deg2rad(90);
Alpha2 = deg2rad(0);
Alpha3 = deg2rad(90);
Alpha4 = deg2rad(90);
Alpha5 = deg2rad(90);
Alpha6 = deg2rad(0);

%Denavite-Hartenburg table - parameters for each arm of the robot
R1 = Revolute('d', Length1, 'a', 0, 'alpha', Alpha1, 'offset', Offset1);
R2 = Revolute('d', -Length2, 'a', Length3, 'alpha',Alpha2 , 'offset', Offset2);
R3 = Revolute('d', Length5, 'a', Length4, 'alpha', Alpha3, 'offset', Offset3);
R4 = Revolute('d', Length6, 'a', 0, 'alpha',Alpha4, 'offset',Offset4); 
R5 = Revolute('d', 0, 'a', 0, 'alpha',Alpha5 , 'offset', Offset5);
R6 = Revolute('d', 0, 'a', 0, 'alpha', Alpha6, 'offset', Offset6); 

%creation of the robot 
walle = SerialLink([R1; R2; R3; R4; R5; R6], 'name', 'robot');

%Forward Kinematic Method
T0 = walle.fkine(q0) %Position 0
T1 = walle.fkine(q1) %Position 1

walle.plot(q0); %plots the robot

%Inverse Kinematic Method
q0inverse= walle.ikine(T0); %Time 0 
q1inverse = walle.ikine(T1);%Time 1

%Jacobian Matricies

%Initial Frame (Frame (0))
Jq0 = walle.jacob0(q0); %position 0
Jq1 = walle.jacob0(q1); %position 1

%End Effector Pose
Jq0E = walle.jacobe(q0); % position 0 
Jq1E = walle.jacobe(q1); % position 1




