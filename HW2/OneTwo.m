format compact
format long
clc; clear;
close all

x =2;%declaration of variables
y =1;
theta=60;

%translating function
T2 = transl2(x,y)*trot2(theta,"deg")