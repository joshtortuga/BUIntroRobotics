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

%plot of two functions
plotvol([0 5 0 5])
trplot2(T1,'frame','T1','color','b')
trplot2(T2,'frame','T2','color','r')