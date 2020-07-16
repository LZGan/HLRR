%%
clear all;
clc;
tic
%% Simulation distance matrices
load Data.mat
load Label.mat;
Data = Data;

mPara.GraphType = 2;
mPara.IS_ProH=1;
mPara.mStarExp=1;
mPara.mRatio=0.1;
mPara.mProb=1;
% The neighbor selection method
% 1: star expansion using mStarExp   2: distance-based using mRatio
%% The main procedures
numModal = 3; % MRI, PET, and CSF
fusion = 1;

%% Data grouping and hypergraph construction
[H, W ] = DataGrouping( Data, mPara, fusion );
%%mir  AD/NC
mir=Data(:,1:93);
h1=H{1,1};
[Z1, E]=sparse_graph_LRR_release(mir',h1,0.1,0.1,0.1);
mir=mir'*Z1;
mir=mir';
xlswrite('mir',mir);
data1=[mir(1:186,:);mir(580:805,:)]
label1=[Label(1:186);Label(580:805)]
xlswrite('mrilabel',label1);
%% pet
iPET = Data(:,94:186);
index=find(~isnan(iPET(:,2)))
iPET=iPET(index,:);
label=Label(index);
xlswrite('petlabel',index);
h2=H{1,2}
[Z2, E]=sparse_graph_LRR_release(iPET',h2,0.1,0.1,0.1);
iPET=iPET'*Z2;
iPET=iPET';
xlswrite('iPET',iPET);

%%
%iCSF
iCSF = Data(:,187:189);
index=find(~isnan(iCSF(:,2)))
iCSF=iCSF(index,:);
label=Label(index);

xlswrite('csflabel',index);
h3=H{1,3}
[Z3, E]=sparse_graph_LRR_release(iCSF',h3,0.1,0.1,0.1);
iCSF=iCSF'*Z3;
iCSF=iCSF'
xlswrite('iCSF',iCSF)


%% mir+pet
mpdata = Data(:,1:186);
index=find(~isnan(mpdata(:,94)))
mpdata=mpdata(index,:);
label=Label(index);
xlswrite('mplabel',label);
h4=H{1,4}
[Z4, E]=sparse_graph_LRR_release(mpdata',h4,0.1,0.1,0.1);
mpdata=mpdata'*Z4;
mpdata=mpdata'
xlswrite('mpdata',mpdata);

%%  mir+csf

mcdata = [Data(:,1:93),Data(:,187:189)]
index=find(~isnan(mcdata(:,95)))
mcdata=mcdata(index,:);
label=Label(index);
xlswrite('mclabel',label);
h5=H{1,5}
[Z5, E]=sparse_graph_LRR_release(mcdata',h5,0.1,0.1,0.1);
mcdata=mcdata'*Z5;
mcdata=mcdata'
xlswrite('mcdata',mcdata);

%%  PET+CSF
pcdata = Data(:,94:189);
[j,k]=find(isnan(pcdata(:,1:96))) ;
pcdata(j,:)=[] ;
label=Label(j);
h6=H{1,6};
[Z6, ~]=sparse_graph_LRR_release(pcdata',h6,0.1,0.1,0.1);
pcdata=pcdata'*Z6;
pcdata=pcdata'
xlswrite('pcdata',pcdata)

%% mir+pet+csf
       
mcpdata = Data(:,1:189);
[m,n]=find(isnan(mcpdata)) ;
mcpdata(m,:)=[] ;
label=Label(m);
h7=H{1,7}
[Z7, E]=sparse_graph_LRR_release(mcpdata',h7,0.1,0.1,0.1);
mcpdata=mcpdata'*Z7;
mcpdata=mcpdata';
xlswrite('mcpdata',mcpdata);
