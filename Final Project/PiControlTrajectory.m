% End-effector tracking of heart-shaped trajectory
clear; clc; close all;

dt = 0.01; %time step size
tf = 20; %run time
N = tf/dt; %number of itereations
Kp = 50;    % P gain
Ki = 1;     % I gain

r = .3; %radius
t = 0:dt:tf;

% Initialization
Tstar = zeros(4,4,N);
q = zeros(N,6);
qd = zeros(N,6);

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

%% 1. Desired pose of the robot
for i = 1:N
    Tstar(:,:,i) = [1 0 0 .4*cos(2/3*(t(i))) ; ...
        0 1 0 .3*sin((t(i))) ; ...
        0 0 1 1; ...
        0 0 0 1];
end

%% 2. Define initial joint angles
q(1,:) = 1.4*walle.ikine(Tstar(:,:,1));   % no initial error

%% 3. Control law and propagation
for i = 1:N-1
    [qd(i,:),Verr(i,:)] = PiControl(q(i,:),Tstar(:,:,i),Tstar(:,:,i+1),...
        Ki,Kp,dt);
    q(i+1,:) = propagate(q(i,:),qd(i,:),dt);
end

%% 4. Plot errors and compare actual & desired trajectories

%for-loop for desired trajectory
for i = 1:N
    xdtemp = Tstar(1:3,4,:);
    xd(i,:) = xdtemp(:,:,i)';
    T(:,:,i) = walle.fkine(q(i,:));
end

Tactual = T.T;

%for-loop for actual trajectory
for i = 1:N
    xtemp = Tactual(1:3,4,:);
    x(i,:) = xtemp(:,:,i)';
end

figure(1);
plot(xd(:,1),xd(:,2))
hold on;
plot(x(:,1),x(:,2),'r--')
hold off;
xlabel('x');ylabel('y');
legend('Desired','Actual');

[m,~] = size(Verr);   % m is the number of the rows of Verr

figure(2);
plot(t(1:m),Verr(:,1:3));
xlabel('Time'),ylabel('Errors');
legend('x_e','y_e','z_e');