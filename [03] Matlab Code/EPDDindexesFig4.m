% EPDDindexesFig4.m
% Produces Figure 4 
% Updated Jan., 2026, Kenneth I. Carlaw

clear
N=100;
NN=N+1;
RR=zeros(NN,1);

for i=1:NN
    RR(i)=i-1;
end
load mvbl
load RRC.mat
RRC(1)=0;
load NRRC.mat
load CMPL.mat

figure % Figure4.6
tile=tiledlayout(3,1);
tile.Padding='none';
tile.TileSpacing='tight';
nexttile ([1 1])
hold on
set(gca,'TickDir','out','TickLength',[0.005,0.005])
box off
plot(RR,CMPL,'Color','k');
plot(RR,mvbl,'Color','k','LineStyle','--')
%xlabel('R')
%ylabel('Reserve capacity')
title('Panel 1: Compliance rate for different levels of enforcement resources','FontSize',20,'FontWeight','normal')
%legend('compliance','violation','Location','best','FontSize',14)
%legend box off
ylim([-0.05 1]);
%legend('AutoUpdate','off')
xline(100)
yline(1)
hold off
nexttile([1 1])
hold on
set(gca,'TickDir','out','TickLength',[0.005,0.005])
box off
plot(RR,RRC,'Color','k')
title('Panel 2: Reserve capacity rate for different levels of enforcement resources','FontSize',20,'FontWeight','normal')
ylim([-0.05 1]);
xline(100)
yline(1)
hold off
nexttile([1 1])
hold on
set(gca,'TickDir','out','TickLength',[0.005,0.005])
box off
plot(RR,NRRC,'Color','k')
%ylabel('Reserve capacity')
title('Panel 3: Deficient capacity rate for different levels of enforcement resources','FontSize',20,'FontWeight','normal')
xlabel('Enforcement resources (R)','FontSize',20)
ylim([-0.05 1]);
yticks([0 0.2 0.4 0.6 0.8 1])
yticklabels({'0','-0.2','-0.4','-0.6','-0.8','-1'})
xline(100)
yline(1)
hold off
%ylim([0.5 2.5])


