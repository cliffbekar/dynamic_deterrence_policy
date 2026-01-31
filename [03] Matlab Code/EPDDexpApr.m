%EPDDexpApr.m
%Updated Jan., 2026, Kenneth I. Carlaw 
% exponential objective prob of apprehension  

clear

%parameters 

N=100;      %population of agents
NN=N+1;
%M=20;
MM=200;

Block=50000;

Rstar=0;      %resources devoted to apprehension
F=1;        %individual cost of apprehnsion given ASA
gam=0.8;
aa=1;
bb=0.25; %0.1765;
mu=0.6;     %mean value of g, individual benefit from ASA
sig=0.2;    %varance of g 
lam=5;     %socail cost conversion of individual ASA for social damage function
rho=2;
Z=2;        %z-history length
Bin=2;
BinE=50;
eps=8;

critconv1=0.01;
RR=zeros(NN,1);
mv=zeros(NN,1);
mov=zeros(NN,1);
sdv=zeros(NN,1);
coefv=zeros(NN,1);
coefvw=zeros(NN,1);
ma=zeros(NN,1);
sda=zeros(NN,1);
gpiv=zeros(NN,1);
vcon=zeros(NN,Block);
cost=zeros(NN,1);
cost2=zeros(NN,1);
mgb=zeros(NN,1);
ARATE=zeros(NN,1);
ARATER=NaN(NN,1);
IRATE=zeros(NN,1);
IRATER=NaN(NN,1);
EXCAP=NaN(NN,1);
EI=zeros(NN,1);
elsc=zeros(NN,1);elsu=zeros(NN,1);pc=zeros(NN,1);pu=zeros(NN,1);Tc=zeros(NN,1);Tu=zeros(NN,1);
mvc=zeros(NN,1);mvu=zeros(NN,1);sdvc=zeros(NN,1);sdvu=zeros(NN,1);
SIGGc=zeros(NN,1);SIGGu=zeros(NN,1);
OPERRc=zeros(NN,1);OPERRu=zeros(NN,1);PrEvc=zeros(NN,1);PrEvu=zeros(NN,1);
BH=zeros(NN,1);

edges=zeros(NN+1,1);
for j=1:NN+1
    edges(j)=j-1.5;
end

for r=1:NN
    RR(r)=r-1;
   
    c=1;
    b=0;
    cc=0;
    TESTCONV=zeros(MM,1);
    TESTCONV(1)=1;
    while ((cc<1) && (b<MM))
        g=normrnd(mu,sig,Block,N);
        swi=zeros(Block,1);
        swic=zeros(Block,1);
        vz=zeros(Block,1);
        az=zeros(Block,1);
        eta=zeros(Block,1);
        R=zeros(Block,1);
        gbar=zeros(Block,N);
        gbar3=zeros(Block,1);
        A=zeros(Block,1);
        NCw=zeros(Block,1);NCw2=zeros(Block,1);
        vw=zeros(Block,1);aw=zeros(Block,1);
        b=b+1;
        BH(r)=b;
        if b<2
            in=Z+1;
        else
            in=1;
        end
        for t=1:Block
            R(t)=RR(r);
            if (b<2)
                if (t<Z+1)
                    for z=1:Z
                        vz(z)=Z*unifrnd(0,N);
                        az(z)=Z*unifrnd(0,vz(z));
                    end
                else
                    vz(t)=sum(vw(t-Z:t-1));
                    az(t)=sum(aw(t-Z:t-1));
                end
            else
                if t<1+Z
                    if t<2
                        vz(t)=sum(v(t+(b-1)*Block-Z:t+(b-1)*Block-1));
                        az(t)=sum(a(t+(b-1)*Block-Z:t+(b-1)*Block-1));
                    else
                        vz(t)=sum(v(t+(b-1)*Block-Z-1:(b-1)*Block))+sum(vw(t-(Z-(Z-(t-1))):t-1));
                        az(t)=sum(a(t+(b-1)*Block-Z-1:(b-1)*Block))+sum(aw(t-(Z-(Z-(t-1))):t-1));  
                    end
                else
                    vz(t)=sum(vw(t-Z:t-1));
                    az(t)=sum(aw(t-Z:t-1));
                end
            end
            eta(t)=(aa+az(t))/(aa+bb+vz(t));
            for n=1:N
                if eta(t)*F<=g(t,n) %g(t+ind(r),n)
                    vw(t)=vw(t)+1;
                    gbar(t,n)=g(t,n); %g(t,n);
                end
            end
            gbar3(t)=sum(gbar(t,:));
            %A(t)=gam*min(1,R(t)/vw(t));
            A(t)=gam*(1-1/(eps^(R(t)/vw(t))));
            aw(t)=binornd(vw(t),A(t));
            NCw(t)=rho*R(t)+(lam-1)*gbar3(t);
        end
        if b<2
            v=vw;
            a=aw;
            gb=gbar3;
            NC=NCw;
        else
            vhold=cat(2,v',vw');
            ahold=cat(2,a',aw');
            gbhold=cat(2,gb',gbar3');
            NChold=cat(2,NC',NCw');
            v=vhold';
            a=ahold';
            gb=gbhold';
            NC=NChold';
        end

        vconv=v(1:b*Block);
        vconvlag=v(1:(b-1)*Block);
        freqvconv=histcounts(vconv(:),edges)/((b)*Block);
        freqvconvlag=histcounts(vconvlag(:),edges)/((b-1)*Block);
        TESTCONV1=zeros(1,NN);
        if b>1
            for j=1:NN
                TESTCONV1(j)=abs(freqvconv(j)-freqvconvlag(j));
            end
            TESTCONV(b)=sum(TESTCONV1);                
        end
        if b > 4
            if (TESTCONV(b)<=critconv1) && (TESTCONV(b-1)<=critconv1) ...
                && (TESTCONV(b-2)<=critconv1) && (TESTCONV(b-3)<=critconv1)...
                && (TESTCONV(b-4)<=critconv1)
                c=b;
                cc=1;
            end
        end
    end

    SGGc=zeros(c*Block,1);SGGu=zeros(c*Block,1);
    vp=zeros(c*Block,1);vcc=zeros(c*Block,1);vu=zeros(c*Block,1);
    TMBC=zeros(2,2);
    TMB=zeros(2,2);
    per=zeros(2,2);        
    for t=1:c*Block
        if t>1000  
            if v(t)<BinE %(r)
                vp(t)=0;
                vcc(t)=v(t);
                vu(t)=-1;
                SGGc(t)=gb(t);                    
            else
                vp(t)=1;
                vcc(t)=-1;
                vu(t)=v(t);
                SGGu(t)=gb(t);                    
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
    
    for j=1:2
        for i=1:2
            TMB(j,i)=TMBC(j,i)/sum(TMBC(j,:));
            per(j,i)=1/(1-TMB(j,i));
        end
    end
    elsc(r)=per(1,1);
    elsu(r)=per(2,2);
    pc(r)=TMB(1,1);
    if isnan(pc(r))
        pc(r)=0;
    end
    pu(r)=TMB(2,2);
    if isnan(pu(r))
        pu(r)=0;
    end    
    Tc(r)=TMBC(1,1)/(c*Block-1000);
    Tu(r)=TMBC(2,2)/(c*Block-1000);
    vcc(vcc==-1)=[];
    vtc=length(vcc);
    vu(vu==-1)=[];
    vtu=length(vu);
    SGGc(SGGc==0)=[];
    stc=length(SGGc);
    SGGu(SGGu==0)=[];
    stu=length(SGGu);
    SIGGc(r)=mean(SGGc);
    SIGGu(r)=mean(SGGu);    
    mvc(r)=mean(vcc(1000:vtc)); %mean(vcc);
    mvu(r)=mean(vu(1000:vtu)); %mean(vu);
    sdvc(r)=std(vcc);
    sdvu(r)=std(vu);
    OPERRc(r)=Tc(r)*pc(r)+(1-Tc(r))*(1-pu(r));
    OPERRu(r)=Tu(r)*pu(r)+(1-Tu(r))*(1-pc(r));
    PrEvc(r)=Tc(r)*mvc(r);
    PrEvu(r)=Tu(r)*mvu(r);
       
    vcon(r,:)=v((c-2)*Block+1:(c-1)*Block);
    mv(r)=mean(v);
    mov(r)=mode(v);
    sdv(r)=std(v);
    ma(r)=mean(a);
    sda(r)=std(a);
    coefv(r)=sdv(r)/mv(r);
    mgb(r)=mean(gb);
    cost(r)=rho*RR(r)+(lam-1)*mgb(r); 
    cost2(r)=mean(NC);

    ARATE(r)=ma(r)/mv(r);
   
    IRATE(r)=min(RR(r),mv(r))/mv(r);
    
    if RR(r)>0
        EXCAP(r)=max(0,(RR(r)-mv(r))/RR(r));
        ARATER(r)=ARATE(r)/RR(r);
        IRATER(r)=IRATE(r)/RR(r);
    end
    
    gp=-1;
    eqn=0;
    while eqn < mv(r)
        gp=gp+0.0001;
        eqn=N*normcdf(gp,mu,sig);
    end
    gpiv(r)=normpdf(gp,mu,sig);
    
%    clear(currentFile,'g')
    RR(r)

end

[M, I]=min(cost);
Rst=RR(I);

[acf38,lag38]=autocorr(vcon(29,Block-10000:Block-5000));
[acf39,lag39]=autocorr(vcon(33,Block-10000:Block-5000));
[acf40,lag40]=autocorr(vcon(35,Block-10000:Block-5000));
[acf41,lag41]=autocorr(vcon(37,Block-10000:Block-5000));
[acf42,lag42]=autocorr(vcon(41,Block-10000:Block-5000));
[acf43,lag43]=autocorr(vcon(44,Block-10000:Block-5000));

figure %figure 3.1
tile=tiledlayout(5,5);
tile.Padding='none';
tile.TileSpacing='tight';
nexttile([1 3])
plot(vcon(29,Block-10000:Block-5000),'Color',[0.5 0.5 0.5])
ylabel('R = 28','FontSize',20)
ylim([0 100])
xlim([0 5000])
nexttile
histogram(vcon(29,Block-10000:Block-5000),'Normalization','probability','FaceColor',[0.2 0.2 0.2],'BinWidth',1)
xlim([0 100])
ylim([0 0.15])
view(90,-90)
nexttile
stem(lag39(2:4),acf39(2:4),'Filled','Color','k')
xlim([0 4]);
%title('Autocorrelation in violations')
%xlabel('Lags')
nexttile([1 3])
plot(vcon(33,Block-10000:Block-5000),'Color',[0.5 0.5 0.5])
ylabel('R = 32','FontSize',20)
ylim([0 100])
xlim([0 5000])
nexttile
histogram(vcon(33,Block-10000:Block-5000),'Normalization','probability','FaceColor',[0.2 0.2 0.2],'BinWidth',1)
xlim([0 100])
ylim([0 0.15])
view(90,-90)
nexttile
stem(lag40(2:4),acf40(2:4),'Filled','Color','k')
xlim([0 4]);
%title('Autocorrelation in violations')
%xlabel('Lags')
nexttile([1 3])
plot(vcon(35,Block-10000:Block-5000),'Color',[0.5 0.5 0.5])
ylabel('R = 34','FontSize',20)
ylim([0 100])
xlim([0 5000])
nexttile
histogram(vcon(35,Block-10000:Block-5000),'Normalization','probability','FaceColor',[0.2 0.2 0.2],'BinWidth',1)
xlim([0 100])
ylim([0 0.15])
view(90,-90)
nexttile
stem(lag41(2:4),acf41(2:4),'Filled','Color','k')
xlim([0 4]);
%title('Autocorrelation in violations')
%xlabel('Lags')
nexttile([1 3])
plot(vcon(37,Block-10000:Block-5000),'Color',[0.5 0.5 0.5])
ylabel('R = 36','FontSize',20)
ylim([0 100])
xlim([0 5000])
nexttile
histogram(vcon(37,Block-10000:Block-5000),'Normalization','probability','FaceColor',[0.2 0.2 0.2],'BinWidth',1)
xlim([0 100])
ylim([0 0.15])
view(90,-90)
nexttile
stem(lag42(2:4),acf42(2:4),'Filled','Color','k')
xlim([0 4]);
nexttile([1 3])
plot(vcon(41,Block-10000:Block-5000),'Color',[0.5 0.5 0.5])
%title('Panel 6: R = 43')
ylim([0 100])
xlim([0 5000])
ylabel('R = 40','FontSize',20)
xlabel('Period (T = 0,...,5000)','FontSize',20)
nexttile
histogram(vcon(41,Block-10000:Block-5000),'Normalization','probability','FaceColor',[0.2 0.2 0.2],'BinWidth',1)
xlim([0 100])
ylim([0 0.15])
ylabel('Frequency of violations','FontSize',20)
view(90,-90)
nexttile
stem(lag43(2:4),acf43(2:4),'Filled','Color','k')
xlim([0 4]);
%title('Autocorrelation in violations')
xlabel('AC for 3 lags','FontSize',20)

load mvbl
figure % Figure 3.6
tile=tiledlayout(4,1);
tile.Padding='none';
tile.TileSpacing='tight';
nexttile ([4 1])
hold on
set(gca,'TickDir','out','TickLength',[0.005,0.005],'FontSize',20)
plot(RR,mvbl,'Color','k','LineStyle','-','LineWidth',0.5)
plot(RR,mv,'Color','k','LineStyle','--','LineWidth',0.5)
xline(N)
yline(N)
ylabel('Number of violations','FontSize',20)
xlabel('Enforcement resources (R)','FontSize',20)
title('Variation in the apprehension function','FontSize',20)
legend('Mean violations E(v|R) Baseline','Mean violations E(v|R) exponential apprehension function','Fontsize',15)
legend boxoff
hold off


%save C:\Users\kcarlaw\Documents\MATLAB\ASB2022final\mvApr mv -ASCII -DOUBLE;
