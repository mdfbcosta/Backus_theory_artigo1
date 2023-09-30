close all
clear all
clc

%

load('z_c.txt');
load('z_a.txt');
load('pres_c.txt');
load('pres_a.txt');

zi = 1.4689;
nmax = 41;
x = [zi/1000:zi/1000:zi/1000*nmax];

yc =  3.7*x.^2 + 17*x + 0.36;
ya = 0.76*x.^2 + 16*x + 0.049;

figure(10)
hold
plot(z_c,pres_c)
plot(z_a,pres_a)
plot(x,yc)
plot(x,ya)
%set(gca,'YDir','reverse')
xlabel('Profundidade [cm]')
ylabel('Pressão [kPa]')

figure(11)
hold
plot(x,yc)
plot(x,ya)
%set(gca,'YDir','reverse')
xlabel('Profundidade [cm]')
ylabel('Pressão [kPa]')
