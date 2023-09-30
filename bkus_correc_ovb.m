%__________________________________________________________________________
%
% **** Teoria de Backus com correção da pressão de OverBurden *************
% A correção é baseada na equação y = y0 + A*exp(p) para as velocidades P e
% S e para a densidade, em que crescem com o acréscimo da pressão de
% overburden (p).
%__________________________________________________________________________

clc
clear all
close all

% ====>>> Backus' formalism

% Vetor amostras
nmax = 41;         % Número máximo de camadas da maior amostra
ncam = [5:4:nmax]; % Vetor com a quantidade de camadas das amostras

% Valor médio da espessura das camadas - artigo 1
zi = 1.4689; % mm

% Vetor espessuras de cada camada da amostra: atribui erro de +-4.85% a zi
z1=(zi+0.0485*(rand(1,ncam(numel(ncam)))-rand(1,ncam(numel(ncam)))))/1000;

% Vetor com as espessuras de cada amostra
for i = 1:numel(ncam);
   h(i) = sum(z1(1:ncam(i)));
end

%% Lendo os dados do experimento das colunas de cimento e argamassa

cim = load('dados_expCol_cim.txt'); % h_plug, Vp, Vs, Rho
ro_c_expC = sort(cim(:,2));
vp_c_expC = sort(cim(:,3));
vs_c_expC = sort(cim(:,4));

arg = load('dados_expCol_arg.txt'); % h_plug, Vp, Vs, Rho
ro_a_expC = sort(arg(:,2));
vp_a_expC = sort(arg(:,3))+674;
vs_a_expC = sort(arg(:,4))+329;

load('z_c.txt');
load('z_a.txt');
pcol_c = load('pres_c.txt');
pcol_a = load('pres_a.txt');


%% PARÂMETROS DE C1 E C2 (AMOSTRAS REFERÊNCIAS) PARA:
%  (C1: cimento100% e C2: argamassa40%+a.media60%)

% == Valores iniciais ==

% Escolha feita para o Artigo 1
vp_c_art_i = 3531.8;    % [m/s] cim
vs_c_art_i = 2055.7;    % [m/s] cim
vp_a_art_i = 1880.8;    % [m/s] arg
vs_a_art_i = 1111.6;    % [m/s] arg
ro_c_art_i = 1.933;     % [kg/m3] cim
ro_a_art_i = 1.673;     % [kg/m3] arg

% Baseado no exp. das colunas
vp_c_pob_i = 3626.62;   % [m/s] cim
vs_c_pob_i = 2583.89;   % [m/s] cim
vp_a_pob_i = 1959.10;   % [m/s] arg
vs_a_pob_i = 1144.40;   % [m/s] arg
ro_c_pob_i = 2.001;     % [kg/m3] cim
ro_a_pob_i = 1.710;     % [kg/m3] arg

% == Valores finais ==

% Baseado no exp. das colunas
vp_c_pob_f = 4178.74;   % [m/s] cim
vs_c_pob_f = 3071.76;   % [m/s] cim
vp_a_pob_f = 2011.70;   % [m/s] arg
vs_a_pob_f = 1191.90;   % [m/s] arg
ro_c_pob_f = 2.181;    % [kg/m3] cim
ro_a_pob_f = 1.762;    % [kg/m3] arg

% Baseado na V_eff experimental amostra 33 camadas
vp_c_ptc_f = 4767.93;   % [m/s] cim
vs_c_ptc_f = 2775.76;   % [m/s] cim
vp_a_ptc_f = 2939.69;   % [m/s] arg
vs_a_ptc_f = 1589.58;   % [m/s] arg
ro_c_ptc_f = 2.13596;    % [kg/m3] cim
ro_a_ptc_f = 1.82524;    % [kg/m3] arg


%% Gerando valores de P_OB: u(p_ob) = u0 + du*exp[b*(1/p_ob - 1/p_máx)] )

% x: vetor espessuras das camadas individuais
% ---- Com zi = 1.468 mm   (tamanho real das amostras)
% x = [zi/1000:zi/1000:zi/1000*nmax];
% ---- Considerando razão: 6cm:1m ou 1.468mm : 2.43cm
zi = 2.439;   
x = [zi/100:zi/100:zi/100*nmax];    
                                 
% C1: P_OB baseado no expCol
pres_c =  3.7*x.^2 + 17*x + 0.36;

% C2: P_OB baseado no expCol
pres_a = 0.76*x.^2 + 16*x + 0.049;


%% Validação Modelo Mat. com o Exp da Coluna C1 e C2

% cimento
pcol_cs = pres_c;
pcol_as = pres_a;


b = 90*ones(1,numel(pcol_cs));
expo = exp(  b./pcol_cs - b./pcol_cs(numel(pcol_cs))  );
del = vp_c_pob_f - vp_c_pob_i;
vp_c_col = vp_c_pob_i + del./expo;
%
b = 70*ones(1,numel(pcol_cs));
expo = exp(  b./pcol_cs - b./pcol_cs(numel(pcol_cs))  );
del = vs_c_pob_f - vs_c_pob_i;
vs_c_col = vs_c_pob_i + del./expo;
%
b = 80*ones(1,numel(pcol_cs));
expo = exp(  b./pcol_cs - b./pcol_cs(numel(pcol_cs))  );
del = ro_c_pob_f - ro_c_pob_i;
ro_c_col = ro_c_pob_i + del./expo;


% argamassa

b = 15*ones(1,numel(pcol_cs));
expo = exp(  b./pcol_as - b./pcol_as(numel(pcol_as))  );
del = vp_a_pob_f - vp_a_pob_i;
vp_a_col = vp_a_pob_i + del./expo;
%
b = 20*ones(1,numel(pcol_cs));
expo = exp(  b./pcol_as - b./pcol_as(numel(pcol_as))  );
del = vs_a_pob_f - vs_a_pob_i;
vs_a_col = vs_a_pob_i + del./expo;
%
b = 80*ones(1,numel(pcol_cs));
expo = exp(  b./pcol_as - b./pcol_as(numel(pcol_as))  );
del = ro_a_pob_f - ro_a_pob_i;
ro_a_col = ro_a_pob_i + del./expo;

%

figure(3)
%suptitle('Pressure-Corrected Properties of C1 and C2 in Col. Exp. using Math. Model')

subplot(2,3,1)
title('V_P')
ylabel('Pressure [kPa]')
hold on
plot(vp_c_expC,pcol_c,'ok')
plot(vp_c_col,pcol_cs,'k','LineWidth',2)
plot(vp_a_expC,pcol_a,'or')
plot(vp_a_col,pcol_as,'r','LineWidth',2)
plot([1800 4770],pres_c(3)*ones(1,2),'k')
xlim([1800 4770])
set(gca,'YDir','reverse')
set(gca,'FontSize',15)
grid on; box on;

subplot(2,3,2)
title('V_S')
hold on
plot(vs_c_expC,pcol_c,'ok')
plot(vs_c_col,pcol_cs,'k','LineWidth',2)
plot(vs_a_expC,pcol_a,'or')
plot(vs_a_col,pcol_as,'r','LineWidth',2)
plot([1000 3100],pres_c(3)*ones(1,2),'k')
set(gca,'YDir','reverse')
set(gca,'FontSize',15)
grid on; box on;

subplot(2,3,3)
title('\rho')
hold on
plot(ro_c_expC,pcol_c,'ok')
plot(ro_c_col,pcol_cs,'k','LineWidth',2)
plot(ro_a_expC,pcol_a,'or')
plot(ro_a_col,pcol_as,'r','LineWidth',2)
plot([1.6 2.2],pres_c(3)*ones(1,2),'k')
set(gca,'YDir','reverse')
set(gca,'FontSize',15)
grid on; box on;
leg1 = legend('C1: Col. Exp.','C1: Math. Model','C2: Col. Exp.','C2: Math. Model')
set(leg1,...
    'Position',[0.834099050388767 0.745505910563849 0.151607959892082 0.144067792569177]);

set(gcf,'Position',[50 50 1500 1000]);


%% -------------------------------------------
%  P and S Wave Velocity and Rho vs P_OB:
%  -------------------------------------------
%  vp_c = vp_c_i + A.*del./expo; % coeficiente "A": no futuro

% Parâmetro de sensibilidade (b):
    b1 = [90 70 80 15 20 80];
    b2 = [90 70 80 15 20 80]/2;
    b3 = [90 70 80 15 20 80]/8; % Figura 12
    
bb = [b1;b2;b3];

pp   = [pres_c' pres_a'];
ui   = [vp_c_art_i vs_c_art_i ro_c_art_i vp_a_art_i vs_a_art_i ro_a_art_i];
%ui   = [vp_c_pob_i vs_c_pob_i ro_c_art_i vp_a_pob_i vs_a_pob_i ro_a_pob_i];
u_fi = [vp_c_pob_f vs_c_pob_f ro_c_pob_f vp_a_pob_f vs_a_pob_f ro_a_pob_f;
        vp_c_ptc_f vs_c_ptc_f ro_c_ptc_f vp_a_ptc_f vs_a_ptc_f ro_a_ptc_f];

for ii = 1:3

    i = ii;
    if ii > 1
        i = 2;
    end
    uf = u_fi(i,:);
    pc  = pp(:,1);
    pa  = pp(:,2);
    
    % =============================== For C1 layers

    b  = bb(ii,:);

    expo = exp(  b(1)./pc - b(1)./pc(numel(pc))  );
    del = uf(1) - ui(1);
    vp_c(:,ii) = ui(1) + del./expo;

    expo = exp(  b(2)./pc - b(2)./pc(numel(pc))  );
    del = uf(2) - ui(2);
    vs_c(:,ii) = ui(2) + del./expo;

    expo = exp(  b(3)./pc - b(3)./pc(numel(pc))  );
    del = uf(3) - ui(3);
    ro_c(:,ii) = ui(3) + del./expo;


    % =============================== For C2 layers


    expo = exp( b(4)./pa - b(4)./pa(numel(pa)) );
    del = uf(4) - ui(4);
    vp_a(:,ii) = ui(4) + del./expo;

    expo = exp( b(5)./pa - b(5)./pa(numel(pa)) );
    del = uf(5) - ui(5);
    vs_a(:,ii) = ui(5) + del./expo;

    expo = exp( b(6)./pa - b(6)./pa(numel(pa)) );
    del = uf(6) - ui(6);
    ro_a(:,ii) = ui(6) + del./expo;

end

% >>>> Figura das correções: vp, vs e rho

figure(3)
%xx = x*100;    % para valores de pressão
xx = [1:nmax];    % para numero de camadas
ncam = [5:4:nmax];

subplot(2,3,4)
hold on
plot(vp_c(:,1),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(1,1)));%,'%0.1f'));
    text(vp_c(33,1),xx(31), texto);
plot(vp_a(:,1),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(1,4)));%,'%0.1f'));
    text(vp_a(34,1),xx(31), texto);
plot(vp_c(:,2),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(2,1)));%,'%0.1f'));
    text(vp_c(23,2),xx(21), texto);
plot(vp_a(:,2),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(2,4)));%,'%0.1f'));
    text(vp_a(23,2),xx(21), texto);
plot(vp_c(:,3),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(3,1)));%,'%0.1f'));
    text(vp_c(13,3),xx(11), texto);
plot(vp_a(:,3),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(3,4)));%,'%0.1f'));
    text(vp_a(13,3),xx(11), texto);
xlabel('Velocity [m/s]')
ylabel('Number of layers')
xlim([1800 4770])
grid on; box on;
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
set(gca,'YTick',ncam)

subplot(2,3,5)
hold on
plot(vs_c(:,1),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(1,2)));%,'%0.1f'));
    text(vs_c(35,1),xx(34), texto);
plot(vs_a(:,1),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(1,5)));%,'%0.1f'));
    text(vs_a(37,1),xx(34), texto);
plot(vs_c(:,2),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(2,2)));%,'%0.1f'));
    text(vs_c(23,2),xx(21), texto);
plot(vs_a(:,2),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(2,5)));%,'%0.1f'));
    text(vs_a(23,2),xx(21), texto);
plot(vs_c(:,3),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(3,2)));%,'%0.1f'));
    text(vs_c(13,3),xx(11), texto);
plot(vs_a(:,3),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(3,5)));%,'%0.1f'));
    text(vs_a(13,3),xx(11), texto);
xlabel('Velocity [m/s]')
%ylim([0 1.5])
grid on; box on;
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
set(gca,'YTick',ncam)

subplot(2,3,6)
hold on
plot(ro_c(:,1),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(1,3)));%,'%0.1f'));
    text(ro_c(32,1),xx(31), texto);
plot(ro_a(:,1),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(1,6)));%,'%0.1f'));
    text(ro_a(32,1),xx(31), texto);
plot(ro_c(:,2),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(2,3)));%,'%0.1f'));
    text(ro_c(23,2),xx(21), texto);
plot(ro_a(:,2),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(2,6)));%,'%0.1f'));
    text(ro_a(23,2),xx(21), texto);
plot(ro_c(:,3),xx,'k','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(3,3)));%,'%0.1f'));
    text(ro_c(13,3),xx(11), texto);
plot(ro_a(:,3),xx,'r','lineWidth',2)
    texto = sprintf('b = %s', num2str(bb(3,6)));%,'%0.1f'));
    text(ro_a(13,3),xx(11), texto);
xlabel('Density [kg/m3]')
%ylim([0 1.5])
grid on; box on;
set(gca,'FontSize',15)
set(gca,'YDir','reverse')
set(gca,'YTick',ncam)
%leg1 = legend('C1','C2')
%set(leg1,'Position',[0.8739 0.3633 0.0581 0.0747]);

set(gcf,'Position',[50 50 1500 1000]);



%==========================================================================
%%      Backus com correção da pressão de overburden camada a camada
%==========================================================================

for i = 1:3
    
    vp = [vp_c(:,i) vp_a(:,i)];  % Ordem: [valor da camada-1    valor da camada-2]
    vs = [vs_c(:,i) vs_a(:,i)];  % Ordem: [valor da camada-1    valor da camada-2]
    rc = ro_c(:,i);
    ra = ro_a(:,i);
    % Vpz e Vsz (= Vsv)
    %[vpz_bkus(:,i), vsz_bkus(:,i), vpz_coar, vsz_coar] = bkus_vz_ovb (z1,ncam,vp,vs,rc,ra);
    %[vpx_bkus(:,i), vsh_bkus(:,i), vpx_coar, vsh_coar] = bkus_vx_ovb (z1,ncam,vp,vs,rc,ra,vpz_bkus(:,i),vsz_bkus(:,i));
    [VV,VVc] = bkus_samples_ovb (z1,ncam,vp,vs,rc,ra) % para 500 kHz

    vpx_bkus(:,i) = VV(:,1);
    vpz_bkus(:,i) = VV(:,2);
    vsh_bkus(:,i) = VV(:,3);
    vsz_bkus(:,i) = VV(:,4);
    vpx_coar(:,i) = VVc(:,1);
    vpz_coar(:,i) = VVc(:,2);
    vsh_coar(:,i) = VVc(:,3);
    vsz_coar(:,i) = VVc(:,4);    
    
end
save('vpz_bkus_ptc2.txt','vpz_bkus','-ascii');
save('vpz_coar_ptc2.txt','vpz_coar','-ascii');

%==========================================================================
%%      Backus sem correção: com os valores definidos inicialmente
%==========================================================================
load('vpz_bkus_500.txt');
load('vpx_bkus_500.txt');
load('vsh_bkus_500.txt');
load('vsz_bkus_500.txt');

%==========================================================================
%%      Backus com valor de C1 e C2 estimado a partir da sample33
%==========================================================================

vpz_est33_tc = load('dado_vpz33_500_estimat_PTC.txt');
vpx_est33_tc = load('dado_vpx33_500_estimat_PTC.txt');
vsh_est33_tc = load('dado_vsh33_500_estimat_PTC.txt');
vsv_est33_tc = load('dado_vsv33_500_estimat_PTC.txt');

%==========================================================================
%%      Velores experimentais: amostras
%==========================================================================

vpz_500k  = load('vpz_500.txt');
vpx_500k  = load('vpx_500.txt');
vsh_500k  = load('vsh_500.txt');
vsv_500k  = load('vsv_500.txt');

figure(10)

subplot(1,4,1)
hold on
plot(vpz_bkus_500(1:10),ncam(1:10),'k','LineWidth',2) % sem correção
plot(vpz_bkus,ncam,'r','LineWidth',2)                 % com correção P_ob
plot(vpz_est33_tc(1:10),[5:4:41],'b','LineWidth',2)   % com estimativa P_tc
plot(vpz_500k(2:10),ncam(2:10),'--om','LineWidth',2)  % com correção P_ob
title('V^{e}_{PZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
%legend('Backus 1','Backus 2','Backus 3','Real')
grid on; box on

subplot(1,4,2)
hold on
plot(vpx_bkus_500(1:10),ncam(1:10),'k','LineWidth',2) % sem correção
plot(vpx_bkus,ncam,'r','LineWidth',2)                 % com correção P_ob
plot(vpx_est33_tc(1:10),[5:4:41],'b','LineWidth',2)       % com estimativa P_tc
plot(vpx_500k(2:10),ncam(2:10),'--om','LineWidth',2)  % com correção P_ob
title('V^{e}_{PX}')
%ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
%legend('Backus 1','Backus 2','Backus 3','Real')
grid on; box on

subplot(1,4,3)
hold on
plot(vsh_bkus_500(1:10),ncam(1:10),'k','LineWidth',2) % sem correção
plot(vsh_bkus,ncam,'r','LineWidth',2)                 % com correção P_ob
plot(vsh_est33_tc(1:10),[5:4:41],'b','LineWidth',2)       % com estimativa P_tc
plot(vsh_500k(2:10),ncam(2:10),'--om','LineWidth',2)  % com correção P_ob
title('V^{e}_{SH}')
%ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
%legend('Backus 1','Backus 2','Backus 3','Real')
grid on; box on

subplot(1,4,4)
hold on
plot(vsv_500k(2:10),ncam(2:10),'--om','LineWidth',2)  % com correção P_ob
plot(vsz_bkus_500(1:10),ncam(1:10),'k','LineWidth',2) % sem correção
plot(vsv_est33_tc(1:10),[5:4:41],'b','LineWidth',2)       % com estimativa P_tc
plot(vsz_bkus,ncam,'r','LineWidth',2)                 % com correção P_ob
title('V^{e}_{SV}')
%ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
leg1 = legend('Real','Backus 1','Backus 2','Backus 3')
title(leg1,'500 kHz')
set(leg1,...
    'Position',[0.864949763047399 0.703903445737694 0.101837670410574 0.184129424840901]);
grid on; box on

set(gcf,'Position',[50 50 1500 1000]);
