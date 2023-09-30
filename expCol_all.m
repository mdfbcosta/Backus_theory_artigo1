clear all
close all
clc

%

load('expCol3m.txt');   % depth, rho, vp, vs
load('expCol13cm.txt'); % depth, rho, vp, vs
expColC11m = load('dados_expCol_cim.txt');
expColC21m = load('dados_expCol_arg.txt');

ajro = 1.09;
ajvp = 1.25;
ajvs = 1.66;
z3  = expCol3m(:,1)/100; % cm
ro3 = ajro*expCol3m(:,2);     % g/cm^3
vp3 = ajvp*expCol3m(:,3);     % m/s
vs3 = ajvs*expCol3m(:,4);     % m/s

ajro = 1.10;
ajvp = 1.12;
ajvs = 1.31;
z13  = expCol13cm(:,1)/100; % cm
ro13 = ajro*expCol13cm(:,2);     % g/cm^3
vp13 = ajvp*expCol13cm(:,3);     % m/s
vs13 = ajvs*expCol13cm(:,4);     % m/s

zC11  = load('z_c.txt')'; % cm
roC11 = sort(expColC11m(:,2));     % g/cm^3
vpC11 = sort(expColC11m(:,3));     % m/s
vsC11 = sort(expColC11m(:,4));     % m/s

zC21  = load('z_a.txt')'; % cm
roC21 = sort(expColC21m(:,2));     % g/cm^3
vpC21 = sort(expColC21m(:,3)+674);     % m/s
vsC21 = sort(expColC21m(:,4)+329);     % m/s


%

%% Figuras
figure(1)
subplot(1,4,1)
hold on
plot(vp3,z3,'o-b')
plot(vs3,z3,'o-r')
set(gca,'YDir','reverse')
set(gca,'FontSize',14)
xlabel('Velocity [m/s]')
ylabel('Depth [m]')
title('3m colunm of C1')
leg1 = legend('V_P','V_S')
title(leg1,'500 kHz')
ylim([0 3.3])
box on; grid on

subplot(1,4,2)
hold on
plot(vpC11,zC11,'o-b')
plot(vsC11,zC11,'o-r')
set(gca,'YDir','reverse')
set(gca,'FontSize',14)
xlabel('Velocity [m/s]')
title('1m colunm of C1')
leg1 = legend('V_P','V_S')
title(leg1,'500 kHz')
ylim([0 1.1])
box on; grid on

subplot(1,4,3)
hold on
plot(vp13,z13,'o-b')
plot(vs13,z13,'o-r')
set(gca,'YDir','reverse')
set(gca,'FontSize',14)
xlabel('Velocity [m/s]')
title('13cm colunm of C1')
leg1 = legend('V_P','V_S')
title(leg1,'500 kHz')
ylim([0 0.143])
box on; grid on

subplot(1,4,4)
hold on
plot(vpC21,zC21,'o-b')
plot(vsC21,zC21,'o-r')
set(gca,'YDir','reverse')
set(gca,'FontSize',14)
xlabel('Velocity [m/s]')
title('1m colunm of C2')
leg1 = legend('V_P','V_S')
title(leg1,'500 kHz')
ylim([0 1.1])
box on; grid on

set(gcf,'Position',[50 50 1500 1000]);

%% Densidades

figure(2)
subplot(1,4,1)
plot(ro3,z3,'o-k')
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Density [g/cm3]')
ylabel('Depth [m]')
title('3m colunm of C1')
leg1 = legend('\rho')
xlim([1.8 2.2])
ylim([0 3.3])
box on; grid on

subplot(1,4,2)
plot(roC11,zC11,'o-k')
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Density [g/cm3]')
title('1m colunm of C1')
leg1 = legend('\rho')
xlim([1.8 2.2])
ylim([0 1.1])
box on; grid on

subplot(1,4,3)
plot(ro13,z13,'o-k')
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Density [g/cm3]')
title('13cm colunm of C1')
leg1 = legend('\rho')
xlim([1.8 2.2])
ylim([0 0.143])
box on; grid on

subplot(1,4,4)
plot(roC21,zC21,'o-k')
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Density [g/cm3]')
title('1m colunm of C2')
leg1 = legend('\rho')
ylim([0 1.1])
box on; grid on

set(gcf,'Position',[50 50 1500 1000]);