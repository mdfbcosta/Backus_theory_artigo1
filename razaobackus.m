%close all
clear all
clc

% Lendo dados necessários: dirZ

% Vel experimental Vpz
vpz_500  = load('vpz_500.txt');
vpz_1000 = load('vpz_1000.txt');

% Vel teórica Vpz com correção PTC
vpz_bk_ptc = load('vpz_bkus_ptc2.txt');
vpz_co_ptc = load('vpz_coar_ptc2.txt');

% Freq domin. relat. às Vels experimental
fd_500  = load('freqMax500z.txt');
fd_1000 = load('freqMax1000z.txt');

% Valor médio de espessura das camadas
zi = 1.4689/1000;  % em metros 

freq = [500 1000];

  
% Vetor quantidade de camadas em cada amostra
ncam500  = [5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 73];
ncam1000 = [9 13 17 21 25 29 33 37 41 45 49 53 73];

% Simula irregularidades aleatórias na espessura das camadas
d500  = ( zi + 0.0485*( rand(1,ncam500(numel(ncam500)))-rand(1,ncam500(numel(ncam500))) ) );     % [m]
d1000 = ( zi + 0.0485*( rand(1,ncam1000(numel(ncam1000)))-rand(1,ncam1000(numel(ncam1000))) ) ); % [m]
                                                
                                             
% Razão de Backus
r500  = vpz_500./(1000*fd_500'*zi);
r1000 = vpz_1000./(1000*fd_1000'*zi);


%==========================================================================
%% FIGURA
%==========================================================================

% % % linha3  = 3*ones(length(ncam500),1);
% % % linha10 = 10*ones(length(ncam500),1);
% % % 
% % % figure1 = figure(1)
% % % hold on
% % % plot(r500(:,1),ncam500,'o','MarkerEdgeColor','k',...
% % %                       'MarkerFaceColor','b',...
% % %                       'MarkerSize',9)
% % % plot(r1000(:,1),ncam1000,'v','MarkerEdgeColor','k',...
% % %                       'MarkerFaceColor','r',...
% % %                       'MarkerSize',9)
% % % plot(linha3,ncam500,'k','LineWidth',2)
% % % plot(linha10,ncam500,':k','LineWidth',2)
% % % set(gca,'YDir','reverse')
% % % set(gca,'FontSize',17)
% % % ylabel('Number of layers')
% % % xlabel('r_{b} = \lambda_{D}/d')
% % % title('Backus ratio')
% % % legend1 = legend('500 kHz','1 MHz',...
% % %     'Liner & Fei','Mavko')
% % % set(legend1,...
% % %     'Position',[0.566666674662412 0.748587575029825...
% % %     0.392682918833523 0.156394448596266]);
% % % 
% % % ylim([3 75]);
% % % %xlim([0 30])
% % % set(gca,'YTick',ncam500)
% % % set(gca,'XTick',[3 10 20 30 40 50 60])
% % % grid on; box on
% % % % annotation(figure1,'textbox',...
% % % %     [0.590196078431373 0.310975609756098 0.394117647058824 0.0975609756097568],...
% % % %     'String',['r_b=10',sprintf('\n'),'Mavko et al. (1998)'],...
% % % %     'LineWidth',1,...
% % % %     'FontSize',14,...
% % % %     'FitBoxToText','off');
% % % % annotation(figure1,'textbox',...
% % % %     [0.588235294117646 0.196646341463415 0.398039215686275 0.092987804878049],...
% % % %     'String',{'r_{b}=3','Liner and Fei (2006)'},...
% % % %     'LineWidth',1,...
% % % %     'FontSize',14,...
% % % %     'FitBoxToText','off');
% % % % annotation(figure1,'arrow',[0.590196078431373 0.272549019607843],...
% % % %     [0.355182926829268 0.315548780487805]);
% % % % annotation(figure1,'arrow',[0.588235294117647 0.184313725490196],...
% % % %     [0.24390243902439 0.228658536585366]);
% % % 
% % % set(gcf,'Position',[50 50 400 1000]);



%%


linha3  = 3*ones(2,1);
linha10 = 10*ones(2,1);
linha20 = 20*ones(2,1);


figure(6)
subplot(1,2,1)
hold on
plot(r500 (:,1),vpz_500 ,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',9)
plot(r1000(:,1),vpz_1000,'v','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',9)
plot(linspace(1,60,numel(vpz_bk_ptc(:,3))),vpz_bk_ptc(:,3),'b','LineWidth',1)
plot(linspace(1,60,numel(vpz_co_ptc(:,3))),vpz_co_ptc(:,3),'--b','LineWidth',1)
plot(linha3,[2000 3500],':k','LineWidth',2)
plot(linha10,[2000 3500],'--k','LineWidth',2)
plot(linha20,[2000 3500],'k','LineWidth',2)
set(gca,'FontSize',17)
ylabel('Velocity [m/s]')
xlabel('r = \lambda/d')
legend1 = legend('500 kHz','1 MHz','Backus P_{TC} 500 kHz','Thick P_{TC} 500 kHz','r_1 = 3','r_2 = 10','r_3 = 20')
title('Backus ratio vs V^{e}_{PZ}')
%set(legend1,'Position',[0.76 0.37 0.13 0.31]);
ylim([2000 3500]);
set(gca,'XTick',[3 10 20 30 40 50 60])
grid on; box on

set(gcf,'Position',[50 50 1500 1000]);