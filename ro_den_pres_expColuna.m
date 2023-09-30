clear all
%close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COLUNA DE CIMENTO E DE ARGAMASSA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Lendo os dados
cim = load('dados_expCol_cim.txt');
arg = load('dados_expCol_arg.txt');

%% Organizando os dados
h_plug_c  = cim(:,1)/1000;
ro_c = sort(cim(:,2));
vp_c = sort(cim(:,3));
vs_c = sort(cim(:,4));

h_plug_a  = arg(:,1)/1000;
ro_a = sort(arg(:,2));
vp_a = sort(arg(:,3))+674;
vs_a = sort(arg(:,4))+329;

%% Profundidade e Pressão Litostática relativa a essa profundidade

% Aceleração da gravidade
g = 9.80665; %[m/s2]

% ==== Do cimento:

% vetor prof
z(1) = h_plug_c(1);
for i = 2:numel(h_plug_c)
  z(i) = z(i-1)+h_plug_c(i)+0.0028;
end
z_c = z;
save('z_c.txt','z','-ascii')

% Pressão Lit
pres_c = g*ro_c'.*z;     % em [kPa]
save('pres_c.txt','pres_c','-ascii')


% ==== Da argamassa

% vetor prof
  z(1) = h_plug_a(1);
for i = 2:numel(h_plug_a)
  z(i) = z(i-1)+h_plug_a(i)+0.0028;
end
z_a = z;
save('z_a.txt','z','-ascii')

% Pressão Lit
pres_a = g*ro_a'.*z;     % em [kPa]
save('pres_a.txt','pres_a','-ascii')


%% Módulo de cisalhamento

% Para o cimento
mi_a = ((ro_a*1000).*vs_a.^2)/1000000000;

% Para a argamassa
mi_c = ((ro_c*1000).*vs_c.^2)/1000000000;

%% Modulo de bulk

% Para o cimento
k_c = ((ro_c*1000).*vp_c.^2 - 4*mi_c/3)/1000000000;

% Para a argamassa
k_a = ((ro_a*1000).*vp_a.^2 - 4*mi_a/3)/1000000000;


figure1 = figure(10)

subplot(2,2,2)
hold on
plot(vp_c,z_c,'.-k','LineWidth',2)
plot(vs_c(2:numel(z_c)),z_c(2:numel(z_c)),'.--k','LineWidth',2)
plot(vp_a,z_a,'.-r','LineWidth',2)
plot(vs_a,z_a,'.--r','LineWidth',2)
title('Reference sample velocities')
ylabel('Depth [m]')
xlabel('Velocity [m/s]')
% xlim([1000 4000])
% ylim([0 1.02])
set(gca,'YDir','Reverse')
set(gca,'FontSize',15)
legend1 = legend('C1: V_P','C1: V_S','C2: V_P','C2: V_S')
set(legend1,...
    'Position',[0.860898419579514 0.673857221373181 0.084226644901732 0.233436048949261]);
title(legend,'500 kHz')
box on; grid on

subplot(2,2,4)
hold on
plot(ro_c,z_c,'.-k','LineWidth',2)
plot(ro_a,z_a,'.-r','LineWidth',2)
title('Reference sample densities')
ylabel('Depth [m]')
xlabel('Density [g/cm3]')
%ylim([0 1.02])
set(gca,'YDir','Reverse')
set(gca,'FontSize',15)
legend('C1','C2')
box on; grid on

subplot(1,4,2)
hold on
plot(pres_c,z_c,'.-k','LineWidth',2)
plot(pres_a,z_a,'.-r','LineWidth',2)
title('Overburden Pressure')
ylabel('Depth [m]')
xlabel('Pressure [kPa]')
ylim([0 1.02])
set(gca,'YDir','Reverse')
set(gca,'FontSize',15)
legend('C1','C2')
annotation(figure1,'textbox',...
    [0.377722817764166 0.761171033229961 0.077335373114846 0.044684128557405],...
    'String',{'P = \rho g z'},...
    'LineStyle','none',...
    'FontSize',12,...
    'FitBoxToText','off');
box on; grid on

