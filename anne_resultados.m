close all
clear all
clc

anne = load('anne_dados.txt');
vp1k = anne(:,1);
vp5k = anne(:,2);
vp1m = anne(:,3);

d =[2.960; 4.572; 5.754; 7.154; 8.579];

fd_1k = [110; 119; 110; 119; 120];
fd_5k = [109; 100; 169; 149; 149];
fd_1m = [121.07; 120; 173; 183.74; 592.3];


r_1k = vp1k./(fd_1k.*d);
r_5k = vp5k./(fd_5k.*d);
r_1m = vp1m./(fd_1m.*d);

figure(1)
subplot(1,2,1)
hold on
plot(vp1k,d,'-o','LineWidth',2)
plot(vp5k,d,'-o','LineWidth',2)
plot(vp1m,d,'-o','LineWidth',2)
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
legend('100 kHz','500 kHz','1 MHz')
title(legend,'V_{PZ}') 
title('Five Layer Packs with Equal Height')
xlabel('Velocity [m/s]')
ylabel('Individual layer thickness [mm]')
set(gca,'YTick',d)
%xlim([500 3000])
%ylim([3 67])
box on; grid on;

subplot(1,2,2)
hold on
plot(r_1k,d,'-o','LineWidth',2)
plot(r_5k,d,'-o','LineWidth',2)
plot(r_1m,d,'-o','LineWidth',2)
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
legend('100 kHz','500 kHz','1 MHz')
title('Backus Ratio')
xlabel('Ratio')
ylabel('Individual layer thickness [mm]')
set(gca,'YTick',d)
%xlim([500 3000])
%ylim([3 67])
box on; grid on;

set(gcf,'Position',[50 50 1500 1000])