clear all; close all; clc;

mdl_puma560
T1 = [.5 -.866 0 .5; 0.866 .5  0 .1; 0 0 1 0; 0 0 0 1];
T2 = [.866 -.5 0 .5; .5 .866 0 -.1; 0 0 1 0; 0 0 0 1];
t = [0:0.1:2]';

title("Trajectory")
q = p560.jtraj(T1,T2,t);
qplot(t,q)
set(gcf, 'Name', 'Trajectory')
