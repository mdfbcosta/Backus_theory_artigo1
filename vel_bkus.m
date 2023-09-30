%__________________________________________________________________________
%
% ***************************** NO PRESSION *******************************
%
%__________________________________________________________________________

clc
clear all
%close all

% Medidas 500 kHz
vp_arg_5k    = 1880.8;
vs_arg_5k    = 1111.6;
vp_cim_5k    = 3531.8;
vs_cim_5k    = 2055.7;

% Medidas 1 MHz
vp_arg_1M    = 1848.7;
vs_arg_1M    = 1042.2;
vp_cim_1M    = 3604.7;
vs_cim_1M    = 2133.2;

% ====>>> Backus' formalism

ncam = [5 9 13 17 21 25 29 33 37 41 45];
ncam_r2 = [49 53 57 61 73];

% Espessura médias das camadas que compõem cada amostra
zi = 1.4689;  % [mm]
z1 = ( zi + 0.0485*( rand(1,ncam(numel(ncam)))-rand(1,ncam(numel(ncam))) ) )/1000; % [m] % Simula camadas com irregularidades aleatórias
z1_r2 = ( zi + 0.0485*( rand(1,ncam_r2(numel(ncam_r2)))-rand(1,ncam_r2(numel(ncam_r2))) ) )/1000; % [m] % Simula camadas com irregularidades aleatórias

% Densidades das amostras de referências: ABS e CIMRES
den1 = 1933;    % cim100% [gramas] 
den2 = 1673;    % arg40%  [gramas] 

% -----------------------------------
%            Para 500 kHz
% -----------------------------------
    vp_5k = [vp_cim_5k vp_arg_5k];  % Ordem: [valor da camada-1    valor da camada-2]
    vs_5k = [vs_cim_5k vs_arg_5k];  % Ordem: [valor da camada-1    valor da camada-2]
% -----------------------------------
%            Para 1 MHz
% -----------------------------------
    vp_1M = [vp_cim_1M vp_arg_1M];  % Ordem: [valor da camada-1    valor da camada-2]
    vs_1M = [vs_cim_1M vs_arg_1M];  % Ordem: [valor da camada-1    valor da camada-2]

% Densidade teórica
% Região 1
dens_eff = den_eff_samp(z1,ncam,den1,den2)
save('dens_eff.txt','dens_eff','-ascii');
% Região 2
dens_eff_r2 = den_eff_samp(z1_r2,ncam_r2,den1,den2)
save('dens_eff_r2.txt','dens_eff_r2','-ascii');

% % % Vpz e Vsz (= Vsv)
% % [vpz_bkus_5k, vsz_bkus_5k, vpz_coar_5k, vsz_coar_5k] = bkus_vz (z1,ncam,vp_5k,vs_5k,den1,den2);
% % [vpz_bkus_1M, vsz_bkus_1M, vpz_coar_1M, vsz_coar_1M] = bkus_vz (z1,ncam,vp_1M,vs_1M,den1,den2);
% % 
% % % Vpx e Vsh
% % [vpx_bkus_5k, vsh_bkus_5k, vpx_coar_5k, vsh_coar_5k] = bkus_vx (z1,ncam,vp_5k,vs_5k,den1,den2,vpz_bkus_5k,vsz_bkus_5k);
% % [vpx_bkus_1M, vsh_bkus_1M, vpx_coar_1M, vsh_coar_1M] = bkus_vx (z1,ncam,vp_1M,vs_1M,den1,den2,vpz_bkus_5k,vsz_bkus_5k);

[VV,VVc] = bkus_samples (z1,ncam,vp_5k,vs_5k,den1,den2)

vpx_bkus_5k = VV(:,1);
vpz_bkus_5k = VV(:,2);
vsh_bkus_5k = VV(:,3);
vsz_bkus_5k = VV(:,4);
vpx_coar_5k = VVc(:,1);
vpz_coar_5k = VVc(:,2);
vsh_coar_5k = VVc(:,3);
vsz_coar_5k = VVc(:,4);

[VV,VVc] = bkus_samples (z1,ncam,vp_1M,vs_1M,den1,den2)

vpx_bkus_1M = VV(:,1);
vpz_bkus_1M = VV(:,2);
vsh_bkus_1M = VV(:,3);
vsz_bkus_1M = VV(:,4);
vpx_coar_1M = VVc(:,1);
vpz_coar_1M = VVc(:,2);
vsh_coar_1M = VVc(:,3);
vsz_coar_1M = VVc(:,4);


% Thin Layers
save('vpz_bkus_500.txt','vpz_bkus_5k','-ascii');
save('vpx_bkus_500.txt','vpx_bkus_5k','-ascii');
save('vsh_bkus_500.txt','vsh_bkus_5k','-ascii');
save('vsz_bkus_500.txt','vsz_bkus_5k','-ascii');
%
save('vpz_bkus_1000.txt','vpz_bkus_1M','-ascii');
save('vpx_bkus_1000.txt','vpx_bkus_1M','-ascii');
save('vsh_bkus_1000.txt','vsh_bkus_1M','-ascii');
save('vsz_bkus_1000.txt','vsz_bkus_1M','-ascii');

% Coarse Layers
save('vpz_coar_500.txt','vpz_coar_5k','-ascii');
save('vpx_coar_500.txt','vpx_coar_5k','-ascii');
save('vsh_coar_500.txt','vsh_coar_5k','-ascii');
save('vsz_coar_500.txt','vsz_coar_5k','-ascii');
%
save('vpz_coar_1000.txt','vpz_coar_1M','-ascii');
save('vpx_coar_1000.txt','vpx_coar_1M','-ascii');
save('vsh_coar_1000.txt','vsh_coar_1M','-ascii');
save('vsz_coar_1000.txt','vsz_coar_1M','-ascii');

figure(1)
suptitle('Cement100% + Mortar40%');

subplot(2,2,1)
hold on
plot(vpz_bkus_5k,ncam,'r','LineWidth',2)
plot(vpz_coar_5k,ncam,'--r','LineWidth',2)
plot(vpz_bkus_1M,ncam,'b','LineWidth',2)
plot(vpz_coar_1M,ncam,'--b','LineWidth',2)
title('V_{PZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
legend('Backus_{0.5 MHz}','Coarse_{0.5 MHz}','Backus_{1 MHz}','Coarse_{1 MHz}')
grid on
box on

subplot(2,2,2)
hold on
plot(vsz_bkus_5k,ncam,'r','LineWidth',2)
plot(vsz_coar_5k,ncam,'--r','LineWidth',2)
plot(vsz_bkus_1M,ncam,'b','LineWidth',2)
plot(vsz_coar_1M,ncam,'--b','LineWidth',2)
title('V_{SZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([700 1400])
%legend('Backus','Coarse')
grid on
box on

subplot(2,2,3)
hold on
plot(vpx_bkus_5k,ncam,'r','LineWidth',2)
plot(vpx_coar_5k,ncam,'--r','LineWidth',2)
plot(vpx_bkus_1M,ncam,'b','LineWidth',2)
plot(vpx_coar_1M,ncam,'--b','LineWidth',2)
title('V_{PX}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
%legend('Backus','Coarse')
grid on
box on

subplot(2,2,4)
hold on
plot(vsh_bkus_5k,ncam,'r','LineWidth',2)
plot(vsh_coar_5k,ncam,'--r','LineWidth',2)
plot(vsh_bkus_1M,ncam,'b','LineWidth',2)
plot(vsh_coar_1M,ncam,'--b','LineWidth',2)
title('V_{SH}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([700 1400])
%legend('Backus','Coarse')
grid on
box on

