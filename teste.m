%close all
clear all
clc

esp = 0.146; %cm
nca = 45;   % maior amostra

x = ([1:nca]*esp)';
z1 = ones(nca,1)*esp/10;
ncam2 = [5:4:nca]*esp;
ncam  = [5:4:nca];

%% VALORES ESCOLHIDOS UM A UM (no excell):

rove = load('ro_vel_excell.txt');
ro_a = rove(:,1);
ro_c = rove(:,2);
vp_a = rove(:,3); 
vp_c = rove(:,4);
vs_a = 1.8*vp_a./3; % USANDO A IDEIA DE QUE A ONDA S É ~2/3 DA ONDA P 
vs_c = 1.8*vp_c./3; % USANDO A IDEIA DE QUE A ONDA S É ~2/3 DA ONDA P 
figure(100)
hold on
% plot(vp_c(1:25),x(1:25),'-or')
% plot(vs_c(1:25),x(1:25),'-vr')
% plot(vp_a(1:25),x(1:25),'-ob')
% plot(vs_a(1:25),x(1:25),'-vb')
plot(x(1:25),vp_c(1:25),'-or')
plot(x(1:25),vs_c(1:25),'-vr')
plot(x(1:25),vp_a(1:25),'-ob')
plot(x(1:25),vs_a(1:25),'-vb')
%set(gca,'YDir','reverse')
legend('V_P cim','V_S cim','V_P arg','V_S arg')
%%
j = 1;
jj = 2;
vp_cc = ones(50,1);
ro_cc = ones(50,1);
vp_aa = ones(50,1);
ro_aa = ones(50,1);
for i = 1:25
    vp_cc(j,1)  = vp_c(i);
    ro_cc(j,1)  = ro_cc(i);
    vp_aa(jj,1) = vp_a(i);
    ro_aa(jj,1) = ro_aa(i);    
    j = j + 2;
    jj = jj + 2;
end
vs_cc = 1.8*vp_cc./3;
vs_aa = 1.8*vp_aa./3;

%%
vp = [vp_cc vp_aa];
vs = [vs_cc vs_aa];
[vpz_ef vsz_ef vpz_co vsz_co] = bkus_vz_over (z1,ncam,vp,vs,ro_cc,ro_aa);
[vpx_ef vsh_ef vpx_co vsh_co] = bkus_vx_over (z1,ncam,vp,vs,ro_cc,ro_aa,vpz_ef,vsz_ef);

% Velores experimentais
vpz_500  = load('vpz_500.txt');
vpz_1000 = load('vpz_1000.txt');

vpx_500  = load('vpx_500.txt');
vpx_1000 = load('vpx_1000.txt');

vsh_500  = load('vsh_500.txt');
vsh_1000 = load('vsh_1000.txt');

vsv_500  = load('vsv_500.txt');
vsv_1000 = load('vsv_1000.txt');

vsz_500  = load('vsz_500.txt');
vsz_1000 = load('vsz_1000.txt');
%%
figure(101)
subplot(1,4,1)
hold on
plot(vpz_ef,ncam)
plot(vpz_1000(1:11),ncam)
set(gca,'YDir','reverse')
legend('vpz_ef','vpz_re')

subplot(1,4,2)
hold on
plot(vpx_ef,ncam)
plot(vpx_1000(1:11),ncam)
set(gca,'YDir','reverse')
legend('vpx_ef','vpx_re')

subplot(1,4,3)
hold on
plot(vsh_ef,ncam)
plot(vsh_1000(1:11),ncam)
set(gca,'YDir','reverse')
legend('vsh_ef','vsh_re')

subplot(1,4,4)
hold on
plot(vsz_ef,ncam)
plot(vsv_1000(1:11),ncam)
set(gca,'YDir','reverse')
legend('vsv_ef','vsv_re')

%%

% %% Para o cimento:
% A  = 3.5;
% B  = 1.61;
% C  = 3;
% 
% x1 = A./x;
% x2 = A./x.^B;
% x3 = (A./x).^C;
% 
% y1 = exp(x1)./(exp(x2) - 1).^2;
% y2 = x3;
% 
% vp_C1 = 3594*(1 + y2.*y1/12);
% 
% % Densidade Cimento
% A  = 1;
% B  = 1.5;
% C  = 2;
% 
% x1 = A./x;
% x2 = A./x.^B;
% x3 = (A./x).^C;
% 
% y1 = exp(x1)./(exp(x2) - 1).^2;
% y2 = x3;
% 
% denC = 1.90*(1 + y2.*y1/50);
% 
% 
% 
% %% Para a argamassa+areiagrossa
% A  = 3.5;
% B  = 1.61;
% C  = 3;
% 
% x1 = A./x;
% x2 = A./x.^B;
% x3 = (A./x).^C;
% 
% y1 = exp(x1)./(exp(x2) - 1).^2;
% y2 = x3;
% 
% vp_C2 = 1850*(1 + y2.*y1/12);
% 
% 
% % Densidade Argamassa
% A  = 3.5;
% B  = 1.2;
% C  = 2;
% 
% x1 = A./x;
% x2 = A./x.^B;
% x3 = (A./x).^C;
% 
% y1 = exp(x1)./(exp(x2) - 1).^2;
% y2 = x3;
% 
% denA = 1.650*(1 + y2.*y1/80);
% 
% 
% %% Teoria de Backus
% 
% vp   = [vp_C1 vp_C2];
% vs   = [2*vp_C1/3 2*vp_C2/3];
% 
% [vpz_ef vsz_ef vpz_co vsz_co] = bkus_vz_over (z1,ncam,vp,vs,denC,denA)
% 
% 
% %% GRÁFICOS
% 
% 
% figure(1)
% hold on
% %plot(y1,x,'-o')
% plot(vp,x,'-o')
% plot(vs,x,'-o')
% set(gca,'YDir','reverse')
% set(gca,'YTick',ncam2)
% legend('v_P','v_S','y3','A')
% %ylim([y3(1) 12]);
% %xlim([x(1) x(numel(x))]);
% xlabel('Velocity [m/s]')
% ylabel('Depth [cm]')
% grid on; box on
% 
% set(gcf,'Position',[50 50 400 1000]);
% 
% 
% 
% figure(2)
% hold on
% %plot(y1,x,'-o')
% plot(denC,x,'-o')
% plot(denA,x,'-o')
% set(gca,'YDir','reverse')
% set(gca,'YTick',ncam2)
% legend('\rho_C','\rho_A','y3','A')
% %ylim([y3(1) 12]);
% %xlim([x(1) x(numel(x))]);
% xlabel('Density [g/cm3]')
% ylabel('Depth [cm]')
% grid on; box on
% 
% set(gcf,'Position',[500 50 400 1000]);
% 
% 
% 
% figure(3)
% hold on
% %plot(y1,x,'-o')
% plot(vpz_ef,ncam,'-o')
% plot(vsz_ef,ncam,'-o')
% set(gca,'YDir','reverse')
% set(gca,'YTick',ncam)
% legend('v^{ef}_P','v^{ef}_S')
% %ylim([y3(1) 12]);
% %xlim([x(1) x(numel(x))]);
% xlabel('Velocity [m/s]')
% ylabel('Depth [cm]')
% grid on; box on
% 
% set(gcf,'Position',[1500 50 400 1000]);
