clc;
clear all;
close all;
load Label.mat;
load Data.mat;
mir=xlsread('mir.xls');
mir=[mir(1:186,1:93);mir(580:805,1:93)]
label=[Label(1:186);Label(580:805)];
data0=mir;
[m,n]=size(data0);
indices =crossvalind('Kfold', m, 10);
for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train0=data0(train,:); 
  label_train0=label(train,:); 
  data_test0=data0(test,:); 
  label_test0=label(test,:); 
end
model = svmtrain(label_train0,data_train0,'-c 1 -t 2 -s 1');
[predict_label0, accuracy0, dec_values] = svmpredict(label_test0,data_test0,model);
%%只有一种模态
om=xlsread('onlymir.xls')
label=om(:,1);
om=om(:,2:94);
label=Label(label);
label=[label(1:93);label(285:409)];
data=[om(1:93,:);om(285:409,:)];
[m,n]=size(data);
indices =crossvalind('Kfold', m, 10);
for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data(train,:); 
  label_train=label(train,:); 
  data_test=data(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2');
[predict_label, accuracy1, dec_values] = svmpredict(label_test,data_test,model);
p_label=predict_label;
%%

label=xlsread('pclabelnum.xls');
label=label';
mpcdata=xlsread('mcpdata.xls');
label=Label(label);
label=[label(1:50);label(148:200)];
mirdata=[mpcdata(1:50,1:93);mpcdata(148:200,1:93)];
petdata=[mpcdata(1:50,94:186);mpcdata(148:200,94:186)];
csfdata=[mpcdata(1:50,187:189);mpcdata(148:200,187:189)];

data1=mirdata;
data2=petdata;
data3=csfdata;
data4=[data1,data2];
data5=[data1,data3];
data6=[data2,data3];
data7=[data1,data2,data3];

[m,n]=size(data1);
indices =crossvalind('Kfold', m, 10);
for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data1(train,:); 
  label_train=label(train,:); 
  data_test=data1(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2');
[predict_label2, accuracy2, dec_values] = svmpredict(label_test,data_test,model);
p_label2=predict_label2;


for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data2(train,:); 
  label_train=label(train,:); 
  data_test=data2(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2');
[predict_label3, accuracy3, dec_values] = svmpredict(label_test,data_test,model);
p_label3=predict_label3;


for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data3(train,:); 
  label_train=label(train,:); 
  data_test=data3(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2');
[predict_label4, accuracy4, dec_values] = svmpredict(label_test,data_test,model);
p_label4=predict_label4;


for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data4(train,:); 
  label_train=label(train,:); 
  data_test=data4(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2 ');
[predict_label5, accuracy5, dec_values] = svmpredict(label_test,data_test,model);
p_label5=predict_label5;


for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data5(train,:); 
  label_train=label(train,:); 
  data_test=data5(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2');
[predict_label6, accuracy6, dec_values] = svmpredict(label_test,data_test,model);
p_label6=predict_label6;


for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data6(train,:); 
  label_train=label(train,:); 
  data_test=data6(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2 ');
[predict_label7, accuracy7, dec_values] = svmpredict(label_test,data_test,model);
p_label7=predict_label7;


for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data7(train,:); 
  label_train=label(train,:); 
  data_test=data7(test,:); 
  label_test=label(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2 ');
[predict_label8, accuracy8, dec_values] = svmpredict(label_test,data_test,model);
p_label8=predict_label8;

sum=p_label2+p_label3+p_label4+p_label5+p_label6+p_label7+p_label8;
save('sum.mat','sum')
temp=load('sum.mat');
[m1,n1]=size(sum);
for i=1:m1
    if sum(i)>6
        sum(i)=2;
    else
        sum(i)=0;
    end
end
%%
%只有两种模态
opnum=xlsread('onlypet.xls');
omp=xlsread('mpdata.xls');
omplabel=Label(opnum);
omplabel=omplabel(44:196);
data8=[omp(1:43,1:96);omp(148:196,1:96)]
[m,n]=size(data8);
indices =crossvalind('Kfold', m, 10);
for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train=data8(train,:); 
  label_train=omplabel(train,:); 
  data_test=data8(test,:); 
  label_test=omplabel(test,:); 
end
model = svmtrain(label_train,data_train,'-c 1 -t 2 -s 1');
[predict_label9, accuracy1, dec_values] = svmpredict(label_test,data_test,model);
p_label9=predict_label9;
p_labels=[p_label;sum;p_label8]

p_labels=sort(p_labels,'descend')
[ACC,Sen,Spe,BAC,PPV,NPV,Fmeasure,MCC,Gmeasure]=lmx_SenSpeAcc(p_labels,label_test0)