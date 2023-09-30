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
    den1 = 1.93     % [g/cm3] cim
    den2 = 1.66;    % [g/cm3] arg
    
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
dens_eff = den_ncam (z1,ncam,den1,den2);

save('dens_eff.txt','dens_eff','-ascii')