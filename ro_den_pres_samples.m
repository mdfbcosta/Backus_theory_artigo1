

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% Densidade experimental das amostras do artigo
ro_samp = [1.9503 1.6888 1.7994 1.8228 1.8384 1.9708 1.9192 1.9854 2.0126 2.0608 1.8167];

% Correspondentes amostras
ncam_samp = [5 9 13 17 21 25 29 33 37 41 45];

% Espessuras das camadas
zi = 1.4689; % [mm] Espesssura média das amostras
z1 = (zi + 0.0485*(rand(1,ncam_samp(numel(ncam_samp)))-rand(1,ncam_samp(numel(ncam_samp)))))/1000; % [cm]

%% Vetor espessura das amostras
for i = 1:numel(ncam_samp)
   h(i) = sum(z1(1:ncam_samp(i)));
end
%%
% Vetor profundidade
  zz(1) = h(1);
for i = 2:numel(h)
  zz(i) = zz(i-1)+(h(i)-h(i-1));
end

% Pressão Litostática
g = 9.80665; %[m/s2] Aceleração da gravidade
presLito_2 = g*ro_samp.*(zz/100);

figure(20)
%subplot(1,4,4)
plot(presLito_2,zz,'-ob')
title('Pressure')
ylabel('Depth [cm]')
xlabel('Pressure [kPa]')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',zz')
%set(gca,'XTick',presH_2)
set(gca,'FontSize',15)
legend('P_H = \mu g h')
box on; grid on
%%

% Vel P e S experimental das amostras em Z
vpz_500k  = load('vpz_500.txt');
vsv_500k  = load('vsv_500.txt');
%vpz_1000k = load('vpz_1000.txt');
%vsv_1000k = load('vsv_1000.txt');

% Módulos de Bulk e Cisalhamento experimental das amostras
mi_samp = (vsv_500k(2:10).^2).*ro_samp(2:10)'/1000000;
ka_samp = (vpz_500k(2:10)).^2.*ro_samp(2:10)'/1000000 - 4*mi_samp/3;

figure(21)

subplot(1,3,1)
hold on
plot(vpz_500k(2:10),[9 13 17 21 25 29 33 37 41],'-om')
plot(vsv_500k(2:10),[9 13 17 21 25 29 33 37 41],'-og')
title('Exp. Vel')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',[9 13 17 21 25 29 33 37 41])
%set(gca,'XTick',presH_2)
set(gca,'FontSize',15)
legend('V_{PZ}','V_{SZ}')
box on; grid on

subplot(1,3,2)
hold on
plot(ro_samp(2:10),[9 13 17 21 25 29 33 37 41],'-ok')
title('\rho')
ylabel('Number of Layers')
xlabel('Density [g/cm3]')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',[9 13 17 21 25 29 33 37 41])
%set(gca,'XTick',presH_2)
set(gca,'FontSize',15)
%legend('Shear','Bulk')
box on; grid on

subplot(1,3,3)
hold on
plot(mi_samp,[9 13 17 21 25 29 33 37 41],'-og')
plot(ka_samp,[9 13 17 21 25 29 33 37 41],'-om')
title('Elastic Modules')
ylabel('Number of Layers')
xlabel('[GPa]')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',[9 13 17 21 25 29 33 37 41])
%set(gca,'XTick',presH_2)
set(gca,'FontSize',15)
legend('Shear','Bulk')
box on; grid on

