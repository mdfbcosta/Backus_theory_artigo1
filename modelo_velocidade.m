%close all
clear all
clc
%%
ncam = [5:4:45];
zi = 1.46 % mm
ecam = ncam*zi/1000;

%%

p = [0.00146:0.00146:1];
x = linspace(0.001,2,numel(p));
vi = 3594;
vf = 4180;
Dv = vf - vi;
B = 0.001;
%B = 0.009;
%B = 0.09;
%B = 1;
A = 1; %(x(1))./((x)).^2;
%
v =  vi + A.*( Dv./exp(B./p - B/p(numel(p))) );

figure(1)
hold on
%plot(p,A.*( Dv./exp(B./p - B/p(numel(p))) ),'-*')
%plot(p,( Dv./exp(B./p - B/p(numel(p))) ),'-*')
%plot(p,A,'--')
plot(p,v,'--')
xlim([0.00146 0.00146*45]);
%ylim([v(1) max(v)]);
legend('resultado','função','assintota')
set(gca,'XTick',ecam)
xlabel('pressão')
ylabel('velocidade')


% figure(2)
% plot(ncam,ecam)
% set(gca,'YTick',ecam)
% xlabel('Numbre of layers')
% ylabel('espessura das camadas')
% grid on; box on
