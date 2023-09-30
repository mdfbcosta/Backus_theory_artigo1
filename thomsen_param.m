%close all
clear all
clc

% Parâmetros de Thomsen

fig1 = figure(6)

vpx_500 = load('vpx_500.txt');
vpz_500 = load('vpz_500.txt');
vsh_500 = load('vsh_500.txt');
vsv_500 = load('vsv_500.txt');
ncam = [5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 73];

epsil = (vpx_500 - vpz_500)./vpz_500;
gamma = (vsh_500 - vsv_500)./vsv_500;

subplot(1,2,2)
plot(epsil,ncam,'ob','LineWidth',2)
%ylabel('Number of layers')
%xlabel('\varepsilon')
%set(gca,'FontSize',16)
hold on
%subplot(1,2,2)
plot(gamma,ncam,'or','LineWidth',2)
plot(ones(1,numel(ncam))*0.2,ncam,'--k','LineWidth',2)
ylim([3 75]);
xlim([-0.1 0.45]);
set(gca,'XTick',[-0.1 0.0 0.1 0.2 0.3 0.4]);
ylabel('Number of layers')
xlabel('Effective anisotropy (%)')
leg1 = legend('$\epsilon \approx \frac{V^{e}_{PX}-V^{e}_{PZ}}{V^{e}_{PZ}}$'...
    ,'$\gamma \approx \frac{V^{e}_{SH}-V^{e}_{SV}}{V^{e}_{SV}}$', 'Weak anisotropy')
% % set(leg1,...
% %     'Position',[0.57970427100158 0.821175693159524 0.418629046346872 0.100755483008941],...
% %     'Interpreter','latex',...
% %     'FontSize',17);
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
set(gca,'YTick',ncam)
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
title('Thomsen''s parameters')
grid on
set(gcf,'Position',[50 50 1500 1000]);
% % annotation(fig1,'textbox',...
% %     [0.211 0.474576271186441 0.2615 0.0986132511556241],...
% %     'String',{'Weak','anisotropy limit'},...
% %     'FontSize',12,...
% %     'FitBoxToText','off');
% % annotation(fig1,'arrow',[0.475 0.5675],...
% %     [0.5115562403698 0.513097072419106]);
