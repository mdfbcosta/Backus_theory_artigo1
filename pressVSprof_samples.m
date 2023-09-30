close all
clear all
clc

% Experimento da coluna de cimento: pressão versus densidade

% Densidade
den = [1.9503 1.6888 1.7994 1.8228 1.8384 1.9708...
       1.9192 1.9854 2.0126 2.0608 1.8167 1.8517...
       1.9488 1.8978 1.9199 2.0058];
    
% Altura dos plugs
alt = [ 6.76 13.23 19.36 24.18 32.19 39.94...
        42.19 49.79 55.63 62.41 66.5 70.97...
        74.04 84.93 95.01 109.8]/1000;

z = alt

g = 9.80665;
pressure = (den*1000).*z*g;

figure(1)
subplot(1,2,1)
title('\rho')
hold on
plot(den,z,'-ok','LineWidth',1);
ylabel('Depth [m]')
xlabel('Density [g/cm3]')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',z)
set(gca,'FontSize',15)
%legend('500 kHz','1 MHz')
box on; grid on

subplot(1,2,2)
title('Pressure')
hold on
plot(pressure/1000,z,'-ok','LineWidth',1);
ylabel('Depth [m]')
xlabel('Pressure [kPa]')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',z)
set(gca,'FontSize',15)
%legend('500 kHz','1 MHz')
box on; grid on