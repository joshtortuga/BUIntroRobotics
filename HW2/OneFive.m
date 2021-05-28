format compact
format long
clc; clear;
close all

x1 =1; %declaration of variables
y1 =2;
theta1=30;

x2 =2;%declaration of variables
y2 =1;
theta2=60;

%translating functions
T1 = transl2(x1,y1)*trot2(theta1,"deg");
T2 = transl2(x2,y2)*trot2(theta2,"deg");

Twisting1 = Twist(T1)
Twisting1.v

Twisting2 = Twist(T2)
Twisting2.v

Twisting2 = Twist(T2)
Twisting2.v