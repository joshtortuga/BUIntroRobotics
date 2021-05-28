format compact
format long
clc; clear;
close all

x1 =1;%declaration of variables
y1 =2;
theta1=30;

x2 =2;%declaration of variables
y2 =1;
theta2=60;

%translating functions
T1 = transl2(x1,y1)*trot2(theta1,"deg");
T2 = transl2(x2,y2)*trot2(theta2,"deg");

P = [1;4];
plot_point(P,'label','P','solid','ko')

Point1 = inv(T1)*[P;1]
h2e(Point1)

Point2 = inv(T2)*[P;1]
h2e(Point2)