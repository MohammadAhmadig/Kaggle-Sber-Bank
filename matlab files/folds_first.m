
close all
clear

load('trainData');
load('Gain_index_sort_kambeziad');

numfeatures = 30;

% X = data(:,1:end-1);
% Y = data(:,end);
X = data(:,cc(261:290));
Y = data(:,end);

samples_size = length(Y);
k =10;
indices = K_Fold(samples_size,k);
Train = X(indices(:,1:k-1),:);
Train_labels = Y(indices(:,1:k-1),:);
Test = X(indices(:,k),:);
Test_labels = Y(indices(:,k),:);

%mdl = TreeBagger(100,Train,Train_labels,'Method','regression');
%class = predict(mdl,Test);
% mdl = fitlm(Train,Train_labels);
% class = predict(mdl,Test);
mdl = fitrsvm(Train,Train_labels);
class = predict(mdl,Test);
% mdl = fitrsvm(Train,Train_labels,'Standardize',true,'KernelFunction','gaussian');
% class = predict(mdl,Test);

sum1=0;
mse_train = (sum((class - Test_labels).^2))/(2*samples_size);
    
% data = 0;
% load('testData');
% %test = testData;
% testSize = size(data,1);
% 
% test_Data = data(:,cc(191:290));
% class = predict(mdl,test_Data);
% result(:,2)=class;
% 
% for i = 1:testSize
%     i
%     result(i,1) = 30473+i;
% end
% 
% 
% file = fopen('result.csv','w');
% fprintf(file,'id,price_doc\n');
% for i = 1:testSize
%     fprintf(file,'%d,%f\n',result(i,1),result(i,2));
% end
% fclose(file);
%          
