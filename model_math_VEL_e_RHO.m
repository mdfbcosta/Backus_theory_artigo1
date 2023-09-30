clc
clear all

z = linspace(1.46,67.5,45)/1000';
ncam(:,1) = [5:4:numel(z)]';
ncam(:,2) = z(5:4:numel(z))';
a73 = [1:numel(z)];
% plot(z,a73,'.-')
% set(gca,'YDir','reverse')
% set(gca,'YTick',ncam(:,1))
% set(gca,'XTick',z(5:8:73))
% xlabel('Depth [mm]')
% grid on; box on

%%
vp_1_ini = 3531.8;    % [m/s] cim
vp_1_fin = 4500;      % [m/s] cim

vp_2_ini = 1880.8;    % [m/s] arg
vp_2_fin = 3341.1;  % [m/s] arg

    
A0 = vp_1_ini;
A  = vp_1_fin/1;
B  = linspace(1,1,numel(z))/15000;
B  = (1*B - B.^(0.33));
%  Baseado no modelo de Einstein para variação do calor específico com a
%  temperatura
%y = A0*( 1 + (((B./x).^2).*exp(B./x))./(( exp(B./x)-1 )).^2 );
y1 = A0 + (A*((B./z).^2).*exp(B./z))./( exp(B./z.^(1.9))-1 ).^2;
y1 = y1';
save('vp_C1_ModelMath.txt','y1','-ascii')

figure(100)
hold on
plot(y1,z)
%plot(y2,x)
title('Velocity vs Depth')
xlabel('Velocity [u.m]')
ylabel('Depth [u.m]')
set(gca,'YDir','Reverse')
set(gca,'FontSize',15)
set(gca,'YTick',z(5:8:numel(z)))
%xlim([3300 4200])
legend('Vp','Vs')
box on; grid on
