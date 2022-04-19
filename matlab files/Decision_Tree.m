classdef Decision_Tree < handle
    
    properties
        Root = Node;
    end
    
    methods
        % constructor of Decision Tree
        function Object = Decision_Tree(data,label,Gain_r,No_fold)
            Attributes = 1:size(data,2);
            ID3(Object, Object.Root,data,label,Attributes,Gain_r,No_fold);
        end
        % Recursive ID3
        function ID3( Object, Root, data, label, Attributes, Gain_r, No_fold )
            ULabels = unique(label);
            %counts = hist(label,ULabels);
            len=length(ULabels);
            counters = zeros(length(ULabels),1);
            % calculate frequency of each value
            for i = 1:len
                for j =1:length(label)
                    if(label(j)==ULabels(i))
                        counters(i)= counters(i)+1;
                    end
                end
            end
            
            [~,maxi] = max(counters);
            if length(ULabels) == 1
               Root.array{3} = ULabels; 
            elseif isempty(Attributes)
               Root.array{3} = ULabels(maxi);
            else
               if(Gain_r)
                   gain = Gain_Ratio(data,label);
               else
                   gain = Gain_Split(data,label);
               end
               [~,maxGain] = max(gain(Attributes));
               Root.array{1} = Attributes(maxGain);
               Attributes = [Attributes(1:maxGain-1) ...
               Attributes(maxGain+1:length(Attributes))];
               Values = unique(No_fold(:,Root.array{1}));
               Root.array{2} = [];
               for i=1:length(Values)
                  data2 = data(data(:,Root.array{1})==Values(i),:);
                  label2 = label(data(:,Root.array{1})==Values(i),:);
                  node1 = Node;
                  if isempty(data2)
                      node1.array{3} = ULabels(maxi);
                  else
                      Object.ID3( node1, data2, label2, Attributes, Gain_r ,No_fold)
                  end
                  Root.array{2} = [Root.array{2} node1];
               end

            end
        end
        
        function class = Classifier(Object, test, data)
            
            node = Object.Root;
            while strcmp(node.array{3},'no_label')
                Value = test(node.array{1});
                
                FValues = unique(data(:,node.array{1}));
                node = node.array{2}(FValues == Value);
            end
            
            class = node.array{3};
        end
    end
    
end

