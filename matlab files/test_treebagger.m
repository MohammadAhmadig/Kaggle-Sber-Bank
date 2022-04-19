
close all
clear

load('trainData');
load('Gain_index_sort_kambeziad');

numfeatures = 290;

% X = data(:,1:end-1);
% Y = data(:,end);
X = data(:,cc(1:290));
Y = data(:,end);

mdl = TreeBagger(100,X,Y,'Method','regression');

data = 0;
load('testData');
%test = testData;
testSize = size(data,1);

test_Data = data(:,cc(1:290));
class = predict(mdl,test_Data);
result(:,2)=class;

for i = 1:testSize
    i
    result(i,1) = 30473+i;
end


file = fopen('result.csv','w');
fprintf(file,'id,price_doc\n');
for i = 1:testSize
    fprintf(file,'%d,%f\n',result(i,1),result(i,2));
end
fclose(file);
         
