function [ gain_split ] = Gain_Split( data , label )

    %data=data';
    %label=label';
    
    %initialize
    samples_size = length(label);% number of samples
    attrs_size = size(data,2);% number of attributes
    
    gain_split = zeros(attrs_size,1);
    Ent_Root = Entropy(label);
    % calculate gain of Attribute
    for i=1:attrs_size
        sum_entrpy = 0;
        values = unique(data(:,i));
        % calculate Entropy of each value for this attribute
        for j=1:length(values)
           subtree_labels = label(data(:,i) == values(j),:);
           subtree_size = length(subtree_labels);%number of samples that they have this value of attribute
           sum_entrpy = sum_entrpy + (subtree_size/samples_size)*Entropy(subtree_labels); 
        end
        gain_split(i) = Ent_Root - sum_entrpy;
    end
end

