format compact
format long
clc; clear;
close all

x =1; %declaration of variables
y =2;
theta=30;

%translating function
T1 = transl2(x,y)*trot2(theta,"deg")