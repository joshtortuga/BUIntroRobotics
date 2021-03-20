clear all; clc; close all;

%part 1
mdl_puma560
q = [pi/2 0 0 1/2 pi -1];
TE = p560.fkine(q);

%part 2 
TEprime = [ 1 0 0 .6; 0 0 -1 -.2; 0 1 0 -.1; 0 0 0 1;];
qi = p560.ikine6s(TEprime);

%part 3
Qi = p560.ikine(TEprime, 'q0', [1 1 0 0 0 0]);