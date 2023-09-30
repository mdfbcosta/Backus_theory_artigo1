
% Código para verificar o efeito sob a média de Backus do contraste de
% velocidade entre as camadas C1 e C2, bem como do contraste entre as
% densidades. Verificar também o efeito causado na escolha de espessuras
% finas iguais ou com pequenas variações entre si, ou de espessuras grossas
% iguais ou com pequenas variações entre si.

%% Contraste de densidade

clc
clear all
close all

% ====>>> Backus' formalism

ncam = [5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73];

%% Produz espessura de cada camada

% Espessura médias das camadas
zi = 1.483;  % [mm] 
% Simula irregularidades aleatórias
z1 = ( zi + 0.0302*( rand(1,ncam(numel(ncam))) - rand(1,ncam(numel(ncam))) ) )'/1000; % [m]
% Simula camadas com espessuras iguais
z2 = (ones(73,1)*zi)/1000;


%% Densidade das camadas em alternâncias
    den1 = 2160;    % [kg/m3] 
    den2 = 1180;    % [kg/m3]
    
% -----------------------------------
    vp_1 = 4419;    % [m/s]
    vs_1 = 2443;    % [m/s]
    vp_2 = 2641.1;  % [m/s]
    vs_2 = 1321.63; % [m/s]
    
    vp = [vp_1 vp_2];  % Ordem: [valor da camada-1    valor da camada-2]
    vs = [vs_1 vs_2];  % Ordem: [valor da camada-1    valor da camada-2]
 %%
    
% Vpz e Vsz (= Vsv)
[vpz_bkus, vsz_bkus, vpz_coar, vsz_coar] = bkus_vz (z1,ncam,vp,vs,den1,den2);

figure(1)
suptitle('Acam-semfiss: Cement+AFina e Acrylic; Vib 5:00h')

subplot(2,2,1)
hold on
plot(vpz_bkus,ncam,'r','LineWidth',2)
plot(vpz_coar,ncam,'--r','LineWidth',2)
plot(vp_1*ones(1,length(ncam)),ncam,'--k','LineWidth',1)
plot(vp_2*ones(1,length(ncam)),ncam,'--b','LineWidth',1)
plot(2947.41,37,'--*g','LineWidth',1)
title('V_{PZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([1400 2200])
legend('Backus','Coarse','v_P^{Cem ref}','v_P^{Acry ref}','v_P^{exp}')
grid on
box on

subplot(2,2,2)
hold on
plot(vsz_bkus,ncam,'r','LineWidth',2)
plot(vsz_coar,ncam,'--r','LineWidth',2)
plot(vs_1*ones(1,length(ncam)),ncam,'--k','LineWidth',1)
plot(vs_2*ones(1,length(ncam)),ncam,'--b','LineWidth',1)
plot(1207.79,37,'--*g','LineWidth',1)
title('V_{SZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
%xlim([700 1400])
legend('Backus','Coarse','v_S^{Cem ref}','v_S^{Acry ref}','v_S^{exp}')
grid on
box on

subplot(2,2,3)
hold on
plot(abs(vpz_bkus - vpz_coar),ncam,'g','LineWidth',2)
title('|V_{Backus} - V_{Course}|')
ylabel('Number of Layers')
xlabel('Vel [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('V_{PZ}')
grid on
box on

subplot(2,2,4)
hold on
plot(abs(vsz_bkus - vsz_coar),ncam,'g','LineWidth',2)
title('|V_{Backus} - V_{Course}|')
ylabel('Number of Layers')
xlabel('Vel [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('V_{SZ}')
grid on
box on
