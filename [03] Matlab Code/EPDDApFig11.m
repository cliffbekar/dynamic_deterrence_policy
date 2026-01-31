% EPDDApFig11.m 
% appendix Figure 11
% Kenneth I. Carlaw Jan. 2026
% The data in lamrho.xlsx are genereted using ASB3mainconv.m,
% ASB3RoptRCNZ.M and ASB3RoptCLR.M

clear
N=100;
NN=N+1;
X=500000;
F=1;
%lam=2;
PR=2;
PR2=0;
chi1=1;
dim=71;

opts = spreadsheetImportOptions("NumVariables", 10);
opts.Sheet = "lamrho";
opts.DataRange = "A2:J9";
opts.VariableNames = ["lrat", "DR1", "DR2", "DR3", "eff1b", "eff2b", "eff3b","RC1","RC2","RC3"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
tbl = readtable("lamrho.xlsx", opts, "UseExcel", false);
lrat = tbl.lrat;
DR1 = tbl.DR1;
DR2 = tbl.DR2;
DR3 = tbl.DR3;
eff1b = tbl.eff1b;
eff2b = tbl.eff2b;
eff3b = tbl.eff3b;
RC1 = tbl.RC1;
RC2 = tbl.RC2;
RC3 = tbl.RC3;
clear opts tbl


figure
tile=tiledlayout(1,2);
tile.Padding='none';
tile.TileSpacing='tight';
nexttile
hold on
box on
plot(lrat,RC1*100,'-*','Color','k')
plot(lrat,RC2*100,'-o','Color','k','LineStyle','--')
plot(lrat,RC3*100,'-s','Color','k','LineStyle',':')
%ylabel('% cost saving','FontSize',20)
%xlabel('RAT = $\frac{({\lambda}-1)}{\rho}$','Interpreter','latex','FontSize',20)
xlabel('RAT','FontSize', 20)
title('Panel 1: reserve capacity as a function of RAT','FontSize',20)
xlim([0 10])
ylim([-1.5 100])
ytickformat('percentage')
legend('DROP(0.6,0.2)=0.704','DROP(0.3,0.35)=0.517','DROP(0.75,0.3)=0.355', 'Location','NorthEast','FontSize',12)
legend boxoff
hold off
nexttile
hold on
box on
plot(lrat,DR1*100,'-*','Color','k')
plot(lrat,DR2*100,'-o','Color','k','LineStyle','--')
plot(lrat,DR3*100,'-s','Color','k','LineStyle',':')
%ylabel('% cost saving','FontSize',20)
%xlabel('RAT = $\frac{({\lambda}-1)}{\rho}$','Interpreter','latex','FontSize',20)
xlabel('RAT','FontSize', 20)
title('Panel 2: cost saving as a function of RAT','FontSize',20)
xlim([0 10])
ylim([-1.5 18])
ytickformat('percentage')
legend('DROP(0.6,0.2)=0.704','DROP(0.3,0.35)=0.517','DROP(0.75,0.3)=0.355', 'Location','NorthEast','FontSize',12)
legend boxoff
hold off





