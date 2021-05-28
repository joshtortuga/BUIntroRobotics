clc; close all; clear

mdl_puma560 
q = [0 pi -pi 0 1 0];
%part a 
Ja = p560.jacob0(q);

%part b
Jb = p560.jacobe(q);

%part c
 TE = p560.fkine(q);
 TE.R;
 zeros = [0 0 0; 0 0 0; 0 0 0];
 A = [TE.R zeros; zeros TE.R ];

%part d
TE = p560.fkine(q);
 
%part e
qe = [0 pi -pi .001 0]
p560.vellipse(q,'trans');

%part f
force = 5; 

