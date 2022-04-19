clc
close all
clear

load('new_trainData');
%load('Gain_index_sort_kambeziad');

numfeatures = 290;

% X = data(:,1:end-1);
% Y = data(:,end);
X = data(:,1:end-1);
Y = data(:,end);

%mode

[indicesR,indicesC] = find(ismember(data,-1));
%for i = 1:length(indicesR)
    for j = 1:length(indicesR)
        temp = unique(data(:,indicesC(j)));
        temp(ismember(temp,-1))=[];
        uniqs = zeros(size(temp,1),2);
        uniqs(:,1)=temp;
        for k = 1:length(uniqs(:,1))
            [ind,~] = find(ismember(data(:,indicesC(j)),uniqs(k,1)));
            uniqs(k,2) = mean(data(ind,end));
        end
        diff = abs(uniqs(:,2) - (data(indicesR(j),end) * ones(size(uniqs,1),1)));
        [minv , mini]= min(diff);
        data(indicesR(j),indicesC(j))=uniqs(mini,1);
        j
    end
    
%end
new_train = data;
save('New_Train','new_train');
% 
% mdl = TreeBagger(100,X,Y,'Method','regression');
% 
% data = 0;
% load('testData');
% %test = testData;
% testSize = size(data,1);
% 
% test_Data = data(:,1:end);
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
