format compact
format long
clc; clear;
close all

x1 =1; %declaration of variables
y1 =2;
theta1=30;

%translating function
T1 = transl2(x1,y1)*trot2(theta1,"deg");

Twisting1 = Twist(T1);
Twisting1.v;
Twisting1.w;

R = (Twisting1.v)/(Twisting1.w)
C_X = R(1)*-1;
C_Y = R(2)*-1;

C = [C_X;C_Y]