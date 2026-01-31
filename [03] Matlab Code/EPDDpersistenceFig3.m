%EPDDpersistenceFig3.m
% Produces Figure 3, The BE vector (line 30) is found using EPDDattFig2 for the
% various 1 bin Policies in the R vector (line 31) 
% Updated, Jan., 2026, Kenneth I. Carlaw


clear

%parameters 

N=100;      %population of agents
NN=N+1;
MM=200;

Block=600000; % Number of periods in each of the 25 covergence loops. 
                % Each convergence loop is run MC = 300 times.
                % THIS CODE BASE TAKE A LONG TIME TO RUN.

    %baseline parameterization
F=1;        %sanction for ASB
gam=0.8;    % max objective apprehension prob.
aa=1;       %shape parameter 1 for Beta distribution (Bayesian) 
bb=0.25;    %shape parameter 2 for Beta distribution (Bayesian)
mu=0.6;     %mean value of g, individual benefit from ASA
sig=0.2;    %varance of g 
lam=5;      %social cost parameter for ASB 
rho=2;      %unit cost of enforcement resources
Z=2;        %z-history length
MC=300; % number of times each of the 25 passive policies is run to convergence

BE=[21 22 23 24 26 27 29 30 32 33 35 37 39 40 42 44 46 48 51 53 56 59 62 67 73]; % Bin edges 
RR=[20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44]; % 25 passive policies

eps=8;      %parameter for exponenetial, objective apprehension function
EDgb=zeros(MC,1);EDbb=zeros(MC,1);GBper=zeros(MC,1);
BBper=zeros(MC,1);TGB=zeros(MC,1);TBB=zeros(MC,1);TGB2=zeros(MC,1);TBB2=zeros(MC,1);
mGBper=zeros(NN,1);
mBBper=zeros(NN,1);
mTGB=zeros(NN,1);mTGB2=zeros(NN,1);
mTBB=zeros(NN,1);mTBB2=zeros(NN,1);
mvGA=zeros(NN,1);mvBA=zeros(NN,1);
moGA=zeros(NN,1);moBA=zeros(NN,1);
for r=1:length(RR)
    mcvGA=zeros(MC,1);mcvBA=zeros(MC,1);movGA=zeros(MC,1);movBA=zeros(MC,1);
    for m=1:MC
        gbar=zeros(Block,1);v=zeros(Block,1);a=zeros(Block,1);A=zeros(Block,1);
        q=zeros(Block,1);g=normrnd(mu,sig,Block,N);
        vz=zeros(Block,1);az=zeros(Block,1);R=zeros(Block,1);
        vp=zeros(Block,1);
        vGA=NaN(Block,1); vBA=NaN(Block,1);
        for t=1:Block            
            R(t)=RR(r);
             if (t<Z+1)
                for z=1:Z
                    vz(z)=Z*unifrnd(0,N);
                    az(z)=Z*unifrnd(0,vz(z));
                end
            else
                vz(t)=sum(v(t-Z:t-1));
                az(t)=sum(a(t-Z:t-1));
            end
            q(t)=(aa+az(t))/(aa+bb+vz(t));
            for n=1:N
                if q(t)*F<=g(t,n) 
                    v(t)=v(t)+1;
                    gbar(t)=gbar(t)+g(t,n);
                end
            end
            A(t)=gam*min(1,R(t)/v(t));
            %A(t)=gam*(1-1/(eps^(R(t)/vw(t))));
            a(t)=binornd(v(t),A(t));
        end
        TMBC=zeros(2,2);
        for t=1:Block
            if t>2  
                if v(t)<BE(r)
                    vp(t)=0;
                    vGA(t)=v(t);
                else
                    vp(t)=1;
                    vBA(t)=v(t);
                end
                if (vp(t)==0) && (vp(t-1)==0)
                    TMBC(1,1)=TMBC(1,1)+1;
                elseif (vp(t)==0) && (vp(t-1)==1)
                    TMBC(1,2)=TMBC(1,2)+1;
                elseif (vp(t)==1) && (vp(t-1)==1)
                    TMBC(2,2)=TMBC(2,2)+1;
                else
                    TMBC(2,1)=TMBC(2,1)+1;
                end
            end
        end
        TMB=zeros(2,2);per=zeros(2,2);
        for j=1:2
            for i=1:2
                TMB(j,i)=TMBC(j,i)/sum(TMBC(j,:));
                per(j,i)=1/(1-TMB(j,i));
            end
        end
        EDgb(m)=per(1,1);
        EDbb(m)=per(2,2);
        GBper(m)=TMB(1,1);
        if isnan(GBper(m))
            GBper(m)=0;
        end
        BBper(m)=TMB(2,2);
        if isnan(BBper(m))
            BBper(m)=0;
        end    
        TGB(m)=(TMBC(1,1)+TMBC(1,2))/(Block-2);
        TGB2(m)=(1-per(1,1))/((1-per(1,1))+(1-per(2,2)));
        TBB(m)=(TMBC(2,2)+TMBC(2,1))/(Block-2);
        TBB2(m)=(1-per(2,2))/((1-per(1,1))+(1-per(2,2)));
        vGA(isnan(vGA))=[];
        vBA(isnan(vBA))=[];
        mcvGA(m)=mean(vGA);
        movGA(m)=mode(vGA);
        mcvBA(m)=mean(vBA);
        movBA(m)=mode(vBA);
        %m
        if (RR(r)==42) && (m==1)
            xvGA=vGA;
        end
        
    end
GBper(GBper==0)=[];
BBper(BBper==0)=[];
TGB(TGB==0)=[];
TBB(TBB==0)=[];
mcvGA(mcvGA==0)=[];
mcvGA(isnan(mcvGA))=[];
movGA(movGA==0)=[];
movGA(isnan(movBA))=[];
mcvBA(mcvBA==0)=[];
movBA(movBA==0)=[];
mGBper(RR(r))=mean(GBper);
mBBper(RR(r))=mean(BBper);
mTGB(RR(r))=mean(TGB);
mTBB(RR(r))=mean(TBB);
mTGB2(RR(r))=mean(TGB2);
mTBB2(RR(r))=mean(TBB2);
mvGA(RR(r))=mean(mcvGA);
mvBA(RR(r))=mean(mcvBA);
moGA(RR(r))=mean(movGA);
moBA(RR(r))=mean(movBA);
r
end

load mvbl

Rbl=zeros(NN,1);
mmvbl=zeros(NN,1);
for i=1:NN

    Rbl(i)=i-1;
    if i<NN
        mmvbl(i)=mvbl(i+1);
    end
    if i < 21
        mGBper(i)=NaN;
        mTGB(i)=NaN;
        mvGA(i)=NaN;
        mBBper(i)=1;
        mTBB(i)=1;
        mvBA(i)=mvbl(i);
    end
    if (20<i) && (i<44)
        if isnan(mvGA(i))
            mvGA(i)=mvGA(44);
        end
        if isnan(moGA(i))
            moGA(i)=moGA(44);
        end
    end
    if i > 44
        mGBper(i)=1;
        mTGB(i)=1;
        mvGA(i)=mvbl(i);
        mBBper(i)=NaN;
        mTBB(i)=NaN;
        mvBA(i)=NaN;
    end
end

figure
tile=tiledlayout(8,5);
tile.Padding='none';
tile.TileSpacing='tight';
nexttile([2 5])
hold on
set(gca,'TickDir','out','TickLength',[0.005,0.005],'FontSize',11)
%box on
plot((Rbl+1),mGBper,'Color','k','LineStyle',':','Marker','square','MarkerIndices',1:3:NN,'LineWidth',1.5)
plot((Rbl+1),mBBper,'Color','k','LineStyle','--','Marker','o','MarkerIndices',1:3:NN,'LineWidth',1.5)
%plot(RR,GBper,'Color','k','LineStyle','-','LineWidth',1.5)
%plot(RR,BBper,'Color','k','LineStyle','--','LineWidth',1.5)
title('Panel 1: Persistence of GA and BA','FontSize',17,'FontWeight','normal')
legend('Persistence of GA','Persistence of BA','FontSize',15,'Location','east')
legend boxoff
%xlim([39 43])
%xticks([39 40 41 42 43])
ylim([0.8 1.01])
xlim([15 55])
%xticks([20 23 27 30 34 37 38 39 40 41 42 43 44])
legend('AutoUpdate','off')
xline(55)
yline(1.01)
hold off
nexttile([2 5])
hold on
set(gca,'TickDir','out','TickLength',[0.005,0.005],'FontSize',11)
%box on
plot((Rbl+1),mTGB*100,'Color','k','LineStyle',':','Marker','square','MarkerIndices',1:3:NN,'LineWidth',1.5)
plot((Rbl+1),mTBB*100,'Color','k','LineStyle','--','Marker','o','MarkerIndices',1:3:NN,'LineWidth',1.5)
title('Panel 2: % of time spent in GA and BA','FontSize',17,'FontWeight','normal') 
legend('% time in GA','% time in BA','FontSize',15,'Location','east')
legend boxoff
%xlim([0 100])
%xticks([20 23 27 30 34 37 38 39 40 41 42 43 44])
ylim([-5 105])
xlim([15 55])
ytickformat('percentage')
legend('AutoUpdate','off')
xline(55)
yline(105)
hold off
nexttile ([4 5])
hold on
%box on
set(gca,'TickDir','out','TickLength',[0.005,0.005],'FontSize',11)
plot((Rbl+1),mmvbl,'Color','k','LineStyle','-','LineWidth',1.5)
plot((Rbl+1),mvGA,'Color','k','LineStyle',':','Marker','square','MarkerIndices',1:3:NN,'LineWidth',1.5)
plot((Rbl+1),mvBA,'Color','k','LineStyle','--','Marker','o','MarkerIndices',1:3:NN,'LineWidth',1.5)
xlim([15 55])
ylim([-5 105])
title('Panel 3: E(v|R) and FPs within GA and BA','FontSize',17,'FontWeight','normal')
xlabel('Enforcement resources (R)','FontSize',15)
legend('Expected violations','Expected violations in GA','Expected violations in BA','FontSize',15,'Location','east')
legend boxoff
legend('AutoUpdate','off')
xline(55)
yline(105)
hold off
