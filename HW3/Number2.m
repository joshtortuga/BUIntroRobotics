clear all; close all; clc;

T = transl(0,.5,0)*trotz(pi/3)*transl(1,0,0);
title("3D Plot")
trplot(T)
set(gcf, 'Name', '3D Plot')