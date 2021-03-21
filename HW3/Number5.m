clc; clear; close all;

%loads the given data
load  HW3_traj.mat
mdl_puma560

%Figure that shows the plot trajetory
figure(1)
plot3(traj(:,1),traj(:,2),traj(:,3)),grid;
title("Plot Trajectory")
set(gcf, 'Name', 'Plot Trajectory')
Tp = SE3(0.6,0,0) * SE3(traj) * SE3.oa([0 1 0], [0 0 -1]);
q = p560.ikine6s(Tp);

%Figure that shows the animation of the robot moving
figure(2)
title("Animation")
set(gcf, 'Name', 'Robot Animation')
p560.plot(q)
TE = p560.fkine(q);
p = TE.transl;

%figure that shows the trajectory of the robot using plot p
figure(3)
plot3(p(:,1),p(:,2),p(:,3)), grid;
title("Plot P")
set(gcf, 'Name', 'Plot P Trajectory')