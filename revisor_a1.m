close all
clear all
clc

% Parametros de referência:

% cimento
vp_c  = 3531.8;    % [m/s] cim
vs_c  = 2055.7;    % [m/s] cim
ro_c  = 1.933;     % [kg/m3] cim
fic_c =            % [%] porosidade crítica

% argamassa+areiagrossa
vp_a  = 1880.8;    % [m/s] arg
vs_a  = 1111.6;    % [m/s] arg
ro_a  = 1.673;     % [kg/m3] arg
fic_a =            % [%] porosidade crítica


% Cálculo do modulos de Bulk e Cisalhamento variando com a porosidade.

% ----> (1+phi) = rho_real/rho_eff




% Estimativa da velocidade efetiva para cada amostra criada:

vs = sqrt(mu./ro);

aux = (k+4*mu/3)./ro;
vp = sqrt(aux);

