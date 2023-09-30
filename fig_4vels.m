%close all
clear all
clc

%% Leitura das velocidades teóricas: T. Backus e Média harmônica 

% São geradas em outro código e apenas lidas aqui.

% Thin Layers
load('vpz_bkus_500.txt');
load('vpx_bkus_500.txt');
load('vsh_bkus_500.txt');
load('vsz_bkus_500.txt');
%
load('vpz_bkus_1000.txt');
load('vpx_bkus_1000.txt');
load('vsh_bkus_1000.txt');
load('vsz_bkus_1000.txt');

% Coarse Layers
load('vpz_coar_500.txt');
load('vpx_coar_500.txt');
load('vsh_coar_500.txt');
load('vsz_coar_500.txt');
%
load('vpz_coar_1000.txt');
load('vpx_coar_1000.txt');
load('vsh_coar_1000.txt');
load('vsz_coar_1000.txt');

% Effective density
load('dens_eff.txt');
load('dens_eff_r2.txt');


%% Velocidades das amostras do artigo 1 do ano de 2020 - com correções 2022

% vel referencia C1 C2
vp_C2_C1 = load('vp_RefAC500.txt');
vs_C2_C1 = load('vs_RefAC500.txt');
% densid referencia C1 C2
den_arg  = 1.673; % g/cm3
den_cim  = 1.933; % g/cm3

vpz_500k  = load('vpz_500.txt');
vpz_1000k = load('vpz_1000.txt');

vpx_500k  = load('vpx_500.txt');
vpx_1000k = load('vpx_1000.txt');

vsh_500k  = load('vsh_500.txt');
vsh_1000k = load('vsh_1000.txt');

vsv_500k  = load('vsv_500.txt');
vsv_1000k = load('vsv_1000.txt');

vsz_500k  = load('vsz_500.txt');
vsz_1000k = load('vsz_1000.txt');

%% Densidade das amostras: medidas realizadas em 2019    
%densidade da amostra de 21 camadas retirada: 1.8384;
den_samp = [1.9503 1.7992 1.7994 1.8228 1.8384 1.9708 1.9192 1.9854 2.0126 2.0608...
            1.8167 1.8517 1.9488 1.8978 1.9199 2.0058];
% 21
nden_samp = [5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 73];
    

%% Região 1: Sob o efeito da pressão

% Todos os pontos da região 1
vpz_500_r1   = [vpz_500k(1:5); vpz_500k(6:11)];
vpz_1000_r1  = [vpz_1000k(1:4); vpz_1000k(5:10)];

vpx_500_r1   = [vpx_500k(1:5); vpx_500k(6:11)];
vpx_1000_r1  = [vpx_1000k(1:4); vpx_1000k(5:10)];

vsh_500_r1   = [vsh_500k(1:5); vsh_500k(6:11)];
vsh_1000_r1  = [vsh_1000k(1:4); vsh_1000k(5:10)];

vsv_500_r1   = [vsv_500k(1:5); vsv_500k(6:11)];
vsv_1000_r1  = [vsv_1000k(1:4); vsv_1000k(5:10)];

vsz_500_r1   = [vsz_500k(1:5); vsz_500k(6:11)];
vsz_1000_r1  = [vsz_1000k(1:4); vsz_1000k(5:10)];

ncam_500_r1  = [5 9 13 17 21 25 29 33 37 41 45];
ncam_1000_r1 = [9 13 17 21 25 29 33 37 41 45];
    

% Densidade na Região 1
den_samp_r1 = [1.9503 1.7992 1.7994 1.8228 1.8384 1.9708 1.9192 1.9854 2.0126 2.0608 1.8167];
nden_samp_r1 = [5 9 13 17 21 25 29 33 37 41 45];
    

% Região 1 sem outlies
vpz_500_r1_out   = [vpz_500k(2:5);vpz_500k(6:10);vpz_500k(10)];
vpz_1000_r1_out  = [vpz_1000k(1:4);vpz_1000k(5:9);vpz_1000k(9)];
nvpz_500_r1_out  = [9 13 17 21 25 29 33 37 41 41];
nvpz_1000_r1_out = [9 13 17 21 25 29 33 37 41 41];    

vpx_500_r1_out   = [vpx_500k(2:5);vpx_500k(6:10);vpx_500k(10)];
vpx_1000_r1_out  = [vpx_1000k(1:4);vpx_1000k(5:9);vpx_1000k(9)];
nvpx_500_r1_out  = [9 13 17 21 25 29 33 37 41 41];
nvpx_1000_r1_out = [9 13 17 21 25 29 33 37 41 41];

vsh_500_r1_out   = [vsh_500k(2:5);vsh_500k(6:10);vsh_500k(10)];
vsh_1000_r1_out  = [vsh_1000k(1:4);vsh_1000k(5:9);vsh_1000k(9)];
nvsh_500_r1_out  = [9 13 17 21 25 29 33 37 41 41];
nvsh_1000_r1_out = [9 13 17 21 25 29 33 37 41 41];

vsv_500_r1_out   = [vsv_500k(2:5);vsv_500k(6:10);vsv_500k(10)];
vsv_1000_r1_out  = [vsv_1000k(1:4);vsv_1000k(5:6);vsv_1000k(8:9);vsv_1000k(9);vsv_1000k(9)];
nvsv_500_r1_out  = [9 13 17 21 25 29 33 37 41 41];
nvsv_1000_r1_out = [9 13 17 21 25 29 37 41 41 41];

vsz_500_r1_out   = [vsz_500k(2:5);vsz_500k(6:10);vsz_500k(10)];
vsz_1000_r1_out  = [vsz_1000k(1:4);vsz_1000k(5:6);vsz_1000k(8:9);vsz_1000k(9);vsz_1000k(9)];
nvsz_500_r1_out  = [9 13 17 21 25 29 33 37 41 41];
nvsz_1000_r1_out = [9 13 17 21 25 29 37 41 41 41];


% Interpolação dos dados
n2 = 1

vpz_500_r1_out   = interp(vpz_500_r1_out,n2)
nvpz_500_r1_out  = interp(nvpz_500_r1_out,n2)
vpz_1000_r1_out  = interp(vpz_1000_r1_out,n2)
nvpz_1000_r1_out = interp(nvpz_1000_r1_out,n2)

vpx_500_r1_out   = interp(vpx_500_r1_out,n2)
nvpx_500_r1_out  = interp(nvpx_500_r1_out,n2)
vpx_1000_r1_out  = interp(vpx_1000_r1_out,n2)
nvpx_1000_r1_out = interp(nvpx_1000_r1_out,n2)

vsh_500_r1_out   = interp(vsh_500_r1_out,n2)
nvsh_500_r1_out  = interp(nvsh_500_r1_out,n2)
vsh_1000_r1_out  = interp(vsh_1000_r1_out,n2)
nvsh_1000_r1_out = interp(nvsh_1000_r1_out,n2)

vsv_500_r1_out   = interp(vsv_500_r1_out,n2)
nvsv_500_r1_out  = interp(nvsv_500_r1_out,n2)
vsv_1000_r1_out  = interp(vsv_1000_r1_out,n2)
nvsv_1000_r1_out = interp(nvsv_1000_r1_out,n2)

vsz_500_r1_out   = interp(vsz_500_r1_out,n2)
nvsz_500_r1_out  = interp(nvsz_500_r1_out,n2)
vsz_1000_r1_out  = interp(vsz_1000_r1_out,n2)
nvsz_1000_r1_out = interp(nvsz_1000_r1_out,n2)


%-------------------------------
%% GRÁFICOS
%-------------------------------

n1 = 5;
figure(3)
%%
subplot(1,5,1) % VPZ
hold on
plot(vpz_1000_r1(1:9),ncam_1000_r1(1:9),'or','LineWidth',2,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',n1)
plot(vpz_bkus_1000(1:10),ncam_500_r1(1:10),'r','LineWidth',1)
plot(vpz_coar_1000(1:10),ncam_500_r1(1:10),'--r','LineWidth',1)
plot(vpz_500_r1(1:10),ncam_500_r1(1:10),'ob','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',n1)
plot(vpz_bkus_500(1:10),ncam_500_r1(1:10),'b','LineWidth',1)
plot(vpz_coar_500(1:10),ncam_500_r1(1:10),'--b','LineWidth',1)
plot(vpz_500_r1_out,nvpz_500_r1_out,'b','LineWidth',1)
plot(vpz_1000_r1_out,nvpz_1000_r1_out,'r','LineWidth',1)
plot(vp_C2_C1(1),25,'*k','LineWidth',1) % Vel Ref C2
plot(vp_C2_C1(2),25,'>k','LineWidth',1) % Vel Ref C1
legend1 = legend('Real','Backus','Thick')
title(legend,'1 MHz');
set(legend1,...
    'Position',[0.00836062601004802 0.843348745878501 0.0918836125142724 0.155624032755295]);
xlim([1750 4150]);
title('V^{e}_{PZ}')
set(gca,'YTick',ncam_500_r1(1:10))
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
%legend('500 kHz', '1 MHz','Thin layers','Coarse layers','Mortar40','Cement')
ylabel('Number of layers')
xlabel('Velocity [m/s]') 
grid on; box on
%%
subplot(1,5,2) % VPX
hold on
plot(vpx_500_r1(1:10),ncam_500_r1(1:10),'ob','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',n1)
plot(vpx_bkus_500(1:10),ncam_500_r1(1:10),'b','LineWidth',1)
plot(vpx_coar_500(1:10),ncam_500_r1(1:10),'--b','LineWidth',1)
plot(vpx_1000_r1(1:9),ncam_1000_r1(1:9),'or','LineWidth',2,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',n1)
plot(vpx_bkus_1000(1:10),ncam_500_r1(1:10),'r','LineWidth',1)
plot(vpx_coar_1000(1:10),ncam_500_r1(1:10),'--r','LineWidth',1)
plot(vpx_500_r1_out,nvpx_500_r1_out,'b','LineWidth',1)            
plot(vpx_1000_r1_out,nvpx_1000_r1_out,'r','LineWidth',1)
plot(vp_C2_C1(1),25,'*k','LineWidth',1) % Vel Ref C2
plot(vp_C2_C1(2),25,'>k','LineWidth',1) % Vel Ref C1
xlim([1750 4150]);
title('V^{e}_{PX}')
set(gca,'YTick',ncam_500_r1(1:10))
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Velocity [m/s]') 
grid on; box on

subplot(1,5,3) %VSH
hold on
plot(vsh_500_r1(1:10),ncam_500_r1(1:10),'ob','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',n1)
plot(vsh_bkus_500(1:10),ncam_500_r1(1:10),'b','LineWidth',1)
plot(vsh_coar_500(1:10),ncam_500_r1(1:10),'--b','LineWidth',1)
plot(vsh_1000_r1(1:9),ncam_1000_r1(1:9),'or','LineWidth',2,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',n1)
plot(vsh_bkus_1000(1:10),ncam_500_r1(1:10),'r','LineWidth',1)
plot(vsh_coar_1000(1:10),ncam_500_r1(1:10),'--r','LineWidth',1)
plot(vsh_1000_r1_out,nvsh_1000_r1_out,'r','LineWidth',1)
plot(vsh_500_r1_out,nvsh_500_r1_out,'b','LineWidth',1)
plot(vs_C2_C1(1),25,'*k','LineWidth',1) % Vel Ref C2
plot(vs_C2_C1(2),25,'>k','LineWidth',1) % Vel Ref C1
xlim([1050 2600])
title('V^{e}_{SH}')
set(gca,'XTick',[1100 1800 2500])
set(gca,'YTick',ncam_500_r1(1:10))
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Velocity [m/s]') 
grid on; box on

subplot(1,5,4) %VSV
hold on
plot(vsv_500_r1(1:10),ncam_500_r1(1:10),'ob','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',n1)
plot(vsz_bkus_500(1:10),ncam_500_r1(1:10),'b','LineWidth',1)
plot(vsz_coar_500(1:10),ncam_500_r1(1:10),'--b','LineWidth',1)
plot(vsv_1000_r1(1:9),ncam_1000_r1(1:9),'or','LineWidth',2,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',n1)
plot(vsz_bkus_1000(1:10),ncam_500_r1(1:10),'r','LineWidth',1)
plot(vsz_coar_1000(1:10),ncam_500_r1(1:10),'--r','LineWidth',1)
plot(vsz_1000_r1_out,nvsv_1000_r1_out,'-.k','LineWidth',1)
plot(vsv_500_r1_out,nvsv_500_r1_out,'b','LineWidth',1)
plot(vsv_1000_r1_out,nvsv_1000_r1_out,'r','LineWidth',1)
plot(vs_C2_C1(1),25,'*k','LineWidth',1) % Vel Ref C2
plot(vs_C2_C1(2),25,'>k','LineWidth',1) % Vel Ref C1
legend1 = legend('Real','Backus','Thick')
title(legend,'500 MHz');
set(legend1,...
    'Position',[0.00805181645755283 0.68310221135004 0.0918836125142723 0.155624032755295]);
xlim([1050 2600])
title('V^{e}_{SV}(=V^{e}_{SZ})')
set(gca,'XTick',[1100 1800 2500])
set(gca,'YTick',ncam_500_r1(1:10))
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlabel('Velocity [m/s]')
%legend('V^{e}_{SZ}')
grid on; box on

subplot(1,5,5) % DENSID
hold on
plot(dens_eff(1:10)/1000,nden_samp_r1(1:10),'-.k','LineWidth',1)
plot(den_samp_r1(1:10),nden_samp_r1(1:10),'ok','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',4)
plot(den_arg,25,'*k','LineWidth',1) % Vel Ref C2
plot(den_cim,25,'>k','LineWidth',1) % Vel Ref C1
xlim([1.6 2.2]);
title('\rho_{eff}')
set(gca,'YTick',nden_samp_r1(1:10))
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
leg2 = legend('V^{e}_{SZ}')
set(leg2,...
    'Position',[0.665402514016479 0.835644583106347 0.0658499226316376 0.0631741123225178]);
xlabel('Density [g/cm3]') 
grid on; box on

set(gcf,'Position',[50 50 1500 1000]);




