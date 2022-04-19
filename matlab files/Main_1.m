clear;close all;clc;

format long

filename = 'train.csv';
fid = fopen(filename, 'r');
ff=fgetl(fid);

dataSize = 30471;
% 292 with id and price(label)
numfeatures = 291;
text = cell(dataSize,1);
i = 1;
while (~ feof (fid) && i<(dataSize+1))
    i% row of csv
    text_line = fgetl (fid);
    text{i} = cell(numfeatures+1,1);
    index = 1;
    for j = 1:numfeatures+1 % column of csv
        text{i}{j} = '';
        while(index<=length(text_line) && text_line(index) ~= ',')
                          
            text{i}{j} = strcat(text{i}{j},text_line(index));
            index = index + 1;
        end
        index = index + 1;
    end
    i = i+1;
end
fclose (fid);


%load('train');
%clear dataSIze;
%dataSize = 7662;
data = zeros(dataSize,numfeatures);

for j = 1:numfeatures
    j
    temp = {};
    for i = 1:dataSize
        
        str = text{i}{j+1};
        
        if( strcmp(str,'NA') )
            index = -1;
        elseif(strfind(str,'e3') == 2)% for 1e3 and ..
            index = str2num(str);
            
        % digit stay digit and strings become digit
        elseif( length(num2str(str2num(str),15)) == length(str) )
            index = str2num(str);
        else
            index = find(ismember(temp,str));
            if(isempty(index))
                temp{end+1} = str;
                index = length(temp);
            end
        end
        data(i,j) = index;
        
    end
end

save('trainData','data');



% Address = 'C:\Program Files\MATLAB\MATLAB Production Server\R2012b\bin\ML_PROJECT\test.csv';
% fileID = fopen(Address,'r');
% data = textscan(fileID,'%s');
% save('data','data')

% load('data');
% dlmwrite('mytest.txt', data, 'delimiter', '\t')

%tt=dlmread('train.csv');
%rr=dlmread('test1.csv',',');

%train = load('train.csv');
% test = load('test.csv');
% X=readtable('train.csv');
% y = readtable('test.csv');
% X = table2array(X);
% y = table2array(y);
%tt=textscan('train.csv');
%rr=textscan('test.csv');
%csvread()

