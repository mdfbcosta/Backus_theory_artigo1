%close all
clear all
clc

%%
ncam = [5:4:73];
zi = 1.46; % mm
ecam = ncam*zi/1000;
z1 = ones(1,ncam(numel(ncam)));


vp_c = 4767.93;
vp_a = 2939.6904;
vs_c = 2775.195; 
vs_a = 1589.588;
ro_c = 2.135965;
ro_a = 1.825243;





vp = [vp_c vp_a];  % Ordem: [valor da camada-1    valor da camada-2]
vs = [vs_c vs_a];  % Ordem: [valor da camada-1    valor da camada-2]
    
% Vpz e Vsz (= Vsv)
[vpz_bkus, vsz_bkus, vpz_coar, vsz_coar] = bkus_vz (z1,ncam,vp,vs,ro_c,ro_a);
[vpx_bkus, vsh_bkus, vpx_coar, vsh_coar] = bkus_vx (z1,ncam,vp,vs,ro_c,ro_a,vpz_bkus,vsz_bkus);

vpz_bkus = vpz_bkus';
vpx_bkus = vpx_bkus';
vsh_bkus = vsh_bkus';
vsv_bkus = vsz_bkus';

figure(100)
save('dado_vpz33_500_estimat_PTC.txt','vpz_bkus','-ascii');
save('dado_vpx33_500_estimat_PTC.txt','vpx_bkus','-ascii');
save('dado_vsh33_500_estimat_PTC.txt','vsh_bkus','-ascii');
save('dado_vsv33_500_estimat_PTC.txt','vsv_bkus','-ascii');

hold on
plot(vpz_bkus)
plot(vpx_bkus)
plot(vsh_bkus)
plot(vsv_bkus)
legend('vpz','vpx','vsh','vsv')