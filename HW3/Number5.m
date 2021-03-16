clc; clear; close all;

load  HW3_traj.mat
mdl_puma560
figure(1)
plot3(traj(:,1),traj(:,2),traj(:,3)),grid;
title("Plot Trajectory")
Tp = SE3(0.6,0,0) * SE3(traj) * SE3.oa([0 1 0], [0 0 -1]);
q = p560.ikine6s(Tp);
figure(2)
title("Animation")
p560.plot(q)
TE = p560.fkine(q);
p = TE.transl;
figure(3)
title("Plot P")
plot3(p(:,1),p(:,2),p(:,3)), grid;
