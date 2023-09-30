function [vp,vs] = v_c1modMat (d,ncam,vpi,vsi)


A = 2;
vp = vpi + d*A;
vs = vsi + d*A;

figure(2)
hold on
plot(d,vp)
plot(d,vs)
legend('vp','vs')