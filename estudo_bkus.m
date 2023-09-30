%__________________________________________________________________________
%
% **************************** Estudo Backus ******************************
% Dependência do resultados com alto contraste de densidade e/ou velocidade
%__________________________________________________________________________

clc
clear all
%close all


% ====>>> Backus' formalism

ncam = [5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73];

% Espessura das camadas das amostras
zi = 1.4689;  % (milímetro) Valor médio da espessura das camadas - artigo 1
z1 = (zi + 0.0485*(rand(1,ncam(numel(ncam)))-rand(1,ncam(numel(ncam)))))/1000; % Atribui variações
                                                                        % dentro da margem de erro

% Densidades amostras referências: Cimento100% + Argamassa40%AMedia60%
    den1 = 2.129     % [g/cm3] cim
    den2 = 1.973;    % [g/cm3] arg
    
% -----------------------------------
    vp_1 = 3800;    % [m/s] cim
    vs_1 = 2100;    % [m/s] cim
    vp_2 = 2641.1;  % [m/s] arg
    vs_2 = 1321.63; % [m/s] arg
    
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
