%close all
clear all
clc
   
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

% Effective density
load('dens_eff.txt');
load('dens_eff_r2.txt');
dens_eff = [dens_eff dens_eff_r2];
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Região 2: "Ensanduichada"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    vpz_500_r2   = vpz_500k(12:16);
    vpz_1000_r2  = vpz_1000k(11:13);
    vpx_500_r2   = vpx_500k(12:16);
    vpx_1000_r2  = vpx_1000k(11:13);    
    ncam_500_r2  = [49 53 57 61 73];
    ncam_1000_r2 = [49 53 73];
    
    % Densidade Região 2
    den_samp_r2  = [1.8517 1.9488 1.8978 1.9199 2.0058];
    nden_samp_r2 = [49 53 57 61 73];
    den_samp = [1.9503 1.7992 1.7994 1.8228 1.8384 1.9708 1.9192 1.9854 2.0126 2.0608...
            1.8167 1.8517 1.9488 1.8978 1.9199 2.0058];
    nden_samp = [5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 73];
    
    % Medidas na amostra-73 na DirZ desplacando-a (500 kHz)
    ncam73 = [15 19 23 27 31 35 39 43 47 51 71];
    vpz_73 = [3686.71 3441.15 3440.33 3246.38 3185.70 3125.15 3145.64 2950.44 2910.26 2867.51 3088.14];

    vp73 = load('vpz_500_a73.txt')
    vp73_500k = vp73(:,2);
    depth_73 = vp73(:,1);
    
    % Medidas na amostra-73 na DirX descendo o eixo-Z
    vpx73 = [3907.84 3841.21 3888.35 3728.82 3708.69];
    vpx73_2 = [3534.06 3523.92 3678.07 3697.90 3526.73];
    eixoZ = [9 20 38 53 71]/10;


%%%%%%%%%%%%%%
%% REGIÃO 2:
%%%%%%%%%%%%%%

figure1 = figure(3)


subplot(1,4,1)
        vpz = vpz_500k';
        vpx_top = load('vpx_500s1top.txt');
        vpx_med = load('vpx_500s2.txt');
        vsh_top = load('vsh_500s1top.txt');
        vsh_med = load('vsh_500s1.txt');
        vsv_top = load('vsv_500s2top.txt');
        vsv_med = load('vsv_500s2.txt');
        ncamTopMed = [5:4:57 73];

vsv_top(3) = vsv_top(3)*1.35;     % correção   
vsv_top(4) = vsv_top(4)*1.15;     % correção
        
hold on
plot(vpx_top(3:15),ncamTopMed(3:15),'-ob','LineWidth',2)
plot(vsh_top(3:15),ncamTopMed(3:15),'-or','LineWidth',2)
plot(vsv_top(3:15),ncamTopMed(3:15),'-ok','LineWidth',2)
plot(vpz(11:16),[45 49 53 57 61 73],'-oc','LineWidth',2)
ylim([13 77])
set(gca,'YTick',[13 17 21 25 29 33 37 41 45 49 53 57 61 73])
title('Top meas.')
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
legend1 = legend('V^{e}_{PX}','V^{e}_{SH}','V^{e}_{SV}','V^{e}_{PZ}')
title(legend,'500kHz')
set(legend1,...
    'Position',[0.24503497078601 0.65536723786063 0.0681470119341592 0.241140208966192]);
ylabel('Number of layers')
xlabel('Velocity [m/s]')
grid on; box on
annotation(figure1,'rectangle',...
    [0.137825421133231 0.104776579352851 0.345329249617152 0.436055469953775],...
    'Color',[1 0 0],...
    'LineWidth',2,...
    'LineStyle','--');

%

subplot(1,4,2)
hold on
plot(dens_eff(3:16)/1000,[13:4:61 73],'--k','LineWidth',1)            
plot(den_samp,nden_samp,'ok','LineWidth',2)
xlim([1.6 2.2]);
ylim([13 77])
set(gca,'YTick',[13 17 21 25 29 33 37 41 45 49 53 57 61 73])
title('\rho_{eff}')
%set(gca,'YTick',ncamTopMed)
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
%legend('Theoretical')
%ylabel('Number of layers')
xlabel('Density [g/cm3]') 
grid on; box on

%

opc2  = [vp73_500k(4:5); vp73_500k(7:10); vp73_500k(17)];
nopc2 = [depth_73(4:5); depth_73(7:10); depth_73(17)];

% Estimativa da veloc
est = load('estim_Press_Over_e_Cons.txt');
depth_est = est(:,1);
ncam_as = [5:4:73]; % Todas as amostras de 5 a 73, de 4 em 4
% Com Overburden: baseado no ExpCol
est_ov = est(:,2);
% Com Press. Tempo Construção: extrapolação do expCol
est_tc = load('dado_vpz73_500_estimat_PTC.txt');

subplot(1,4,3)
hold on
plot(vpz_73,ncam73,':ok','LineWidth',2)
plot(est_ov(3:18),ncam_as(3:18),'r','LineWidth',2)
plot(est_tc(3:18),ncam_as(3:18),'b','LineWidth',2)
plot(vpz(12:16),[49 53 57 61 73],'-oc','LineWidth',2)
xlim([1500 4500])
ylim([13 77])
set(gca,'YTick',[13 17 21 25 29 33 37 41 45 49 53 57 61 73])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
legend1 = legend('73 Lyrs','Backus 1','Backus 2','V^{e}_{PZ}')
set(legend1,...
    'Position',[0.631711840317552 0.186569086842053 0.106431850978098 0.21340523290524]);
title(legend1,'500kHz');
title('V^{e}_{PZ} 73 layers')
%ylabel('Depth [cm]')
xlabel('Velocity [m/s]') 
grid on; box on
annotation(figure1,'textarrow',[0.660030627871363 0.630168453292496],...
    [0.822804314329738 0.899845916795069],'Color',[0 0 1],...
    'String',{'Under P_{TC}'},...
    'FontSize',12);
annotation(figure1,'textarrow',[0.660030627871363 0.599540581929556],...
    [0.759630200308166 0.850539291217257],'Color',[1 0 0],...
    'String',{'Under P_{OB}'},...
    'FontSize',12);

%

nmed73 = [1.22 2.44 3.66 4.88 6.10 7.32 8.54 9.76];
vpx73_2020 = load('vpx_500s1a73.txt');
vsh73_2020 = load('vsh_500s1a73.txt');
vsv73_2020 = load('vsv_500s2a73.txt');
subplot(1,4,4)
hold on
plot(vpx73_2020,nmed73,'-ob','LineWidth',2)
plot(vsh73_2020,nmed73,'-or','LineWidth',2)
plot(vsv73_2020,nmed73,'-ok','LineWidth',2)           
xlim([1500 4500])
ylim([0.9 10.6])
title('73 layers')
%set(gca,'YTick',nmed73)
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
legend1 = legend('V^{e}_{PX}','V^{e}_{SH}','V^{e}_{SV}')
title(legend,'500kHz')
set(legend1,...
    'Position',[0.868582309407283 0.704593605713458 0.0681470119341592 0.192604000836565]);
ylabel('Depth [cm]')
xlabel('Velocity [m/s]') 
grid on; box on

set(gcf,'Position',[50 50 1500 1000]);
