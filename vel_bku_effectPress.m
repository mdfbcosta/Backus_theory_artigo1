close all
clear all
clc

d_medio = 1.47; % mm
ncam = [5:4:25];
z1 = ones(1,ncam(numel(ncam)))*d_medio;
depth = ncam*d_medio;

% Gerando Vels e densidades com modelos matemáticos

%[vp_c1 vs_c1] = v_c1modMat(depth,ncam,4850,2800);
%[vp_c2 vs_c2] = v_c2modMat(depth,ncam,3500,2000);
%den1 = ro_c1modMat();
%den2 = ro_c1modMat();
dado = load('dado_vp_C1_C2_modmath.txt')
vp_c1 = dado(:,4)';
vp_c2 = dado(:,3)';

vs_c1 = linspace(2056,3000,numel(z1));
vs_c2 = linspace(1112,3000,numel(z1));

den1 = dado(:,2);
den2 = dado(:,1);

vp = [vp_c1' vp_c2'];
vs = [vs_c1' vs_c2'];

[vpz_bk, vsz_bk, vpz_co, vsz_co] = bkus_vz_over (z1,ncam,vp,vs,den1,den2);

figure(1)
hold on
plot(vpz_bk,ncam,'-ob','LineWidth',2)
plot(vsz_bk,ncam,'-ob','LineWidth',2)
set(gca,'YDir','reverse')
set(gca,'YTick',ncam)
xlabel('Velocity [m/s]')
ylabel('Number of layers')
title('Backus media')
legend('V_PZ','V_SZ')
