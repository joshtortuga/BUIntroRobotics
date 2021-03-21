clear all; close all; clc;

Tranlation = transl(0,.5,0)*trotz(pi/3)*transl(1,0,0);
title("3D Plot")
trplot(Translation)
set(gcf, 'Name', '3D Plot')