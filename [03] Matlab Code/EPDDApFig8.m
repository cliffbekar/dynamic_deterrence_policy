% EPDD Appendix Figure 8 
% Uses data generated from baseline convergence sim: EPDDmainconvFig1.m, 
% Updated Jan., 2026, Kenneth I. Carlaw

clear

load mvbl;
load mvbld;
load mvblD1;

N=100;
NN=N+1;
Rcp=zeros(NN,1);
PRcp=zeros(NN,1);
PPRcp=zeros(51,1);
for rcp=1:NN
    Rcp(rcp)=rcp-1;
    PRcp(rcp)=Rcp(rcp)/N;
end
for rcp=1:51
    PPRcp(rcp)=(rcp-1)/51;
end

figure
hold on
plot(Rcp,mvbl,'Color','k')
plot(Rcp,mvbld,'Color','k','LineStyle','--')
plot(Rcp,mvblD1,'Color','k','LineStyle',':','LineWidth',2)
box on
xlabel('Enforcement resources (R)')
ylabel('Number of violations')
%title('Panel 1: DROP=0.35')
legend('\mu = 0.6, \sigma = 0.2','\mu = 0.6, \sigma = 0.4','\mu = 0.8, \sigma = 0.4','Location','southwest','FontSize',15)
legend boxoff
txt='DROP = 0.7';
text(70,14,txt,'FontSize',15);
txt1='DROP = 0.35';
text(70,28,txt1,'FontSize',15);
txt2='DROP = 0.1';
text(70,62,txt2,'FontSize',15);

ylim([0 N])
hold off

