clc; clear; close all;

mdl_puma560 %call the puma560 robot
%Part a
q = [0 pi -pi 0 1 0];
RequiredJointTorques = p560.rne(q,qz,qz); 

%Part b
%inertia matrix
M = p560.inertia(q);

%Part c
[q1,q2] = meshgrid(-pi:0.1:pi, -pi:0.1:pi);
for x=1:numcols(q1)
    
    for z=1:numcols(q2)
    Mc = p560.inertia([q1(x,z) q2(x,z) 0 0 0 0]);
    M11(x,z) = Mc(1,1);
    end

end

surfl(q1,q2,M11)
maximum = max(M11(:));
minumum = min(M11(:));