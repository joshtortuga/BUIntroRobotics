function [qd,Verr] = PiControl(q,Tstar,Tstar_next,Ki,Kp,dt)

%Lengths of each arm of the robot
Length1 = .5; 
Length2 = .2;
Length3 = .4;
Length4 = .02;
Length5 = .08;
Length6 = .4;

%offset values
Offset1 = deg2rad(180);
Offset2 = deg2rad(90);
Offset3 = deg2rad(90);
Offset4 = deg2rad(180);
Offset5 = deg2rad(180);
Offset6 = deg2rad(0);

%alpha values
Alpha1 = deg2rad(90);
Alpha2 = deg2rad(0);
Alpha3 = deg2rad(90);
Alpha4 = deg2rad(90);
Alpha5 = deg2rad(90);
Alpha6 = deg2rad(0);

%Denavite-Hartenburg table
R1 = Revolute('d', Length1, 'a', 0, 'alpha', Alpha1, 'offset', Offset1);
R2 = Revolute('d', -Length2, 'a', Length3, 'alpha',Alpha2 , 'offset', Offset2);
R3 = Revolute('d', Length5, 'a', Length4, 'alpha', Alpha3, 'offset', Offset3);
R4 = Revolute('d', Length6, 'a', 0, 'alpha',Alpha4, 'offset',Offset4); 
R5 = Revolute('d', 0, 'a', 0, 'alpha',Alpha5 , 'offset', Offset5);
R6 = Revolute('d', 0, 'a', 0, 'alpha', Alpha6, 'offset', Offset6); 

%creation of the robot 
walle = SerialLink([R1; R2; R3; R4; R5; R6], 'name', 'robot');
Dd = 1/dt*trlog(inv(Tstar)*Tstar_next);
Vd = [Dd(1:3,4);Dd(3,2);Dd(1,3);Dd(2,1)];  % 6x1 desired spatial vel
Vd = Vd';   % 1x6 row vector (desired spatial vel)

T_SE3 = walle.fkine(q);   % current pose (object)
T = T_SE3.T;             % current pose (4x4)

invT_Tstar = inv(T)*Tstar;
R_tilde = invT_Tstar(1:3,1:3);
x_tilde = invT_Tstar(1:3,4);
x_x = [0 -x_tilde(3) x_tilde(2);x_tilde(3) 0 -x_tilde(1);-x_tilde(2) x_tilde(1) 0];
Ad = [R_tilde x_x*R_tilde;zeros(3,3) R_tilde];  % adjoint matrix

Serr = trlog(inv(T)*Tstar);
Verr = [Serr(1:3,4);Serr(3,2);Serr(1,3);Serr(2,1)];  % spatial vel error
Verr = Verr';    % 1x6 spatial vel error

V = (Ad*Vd')' + Kp*Verr + Ki*Verr*dt;  % control law
Je = walle.jacobe(q);   % Jacobian matrix corresponding to q (current joint angles)
qd = pinv(Je)*V';      % joint velocities (6x1)
qd = qd';              % convert to 1x6 row vector