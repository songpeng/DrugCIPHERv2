function g2d_closeness = getG2dCloseness( network_matrix, d2t_hash, closenessFunc)
    [tmp, GeneNum] = size(network_matrix);
    [tmp, DrugNum] = size(d2t_hash);
    g2d_closeness = zeros(GeneNum,DrugNum);
    for GeneIndex = 1:GeneNum
        for DrugIndex = 1:DrugNum
            Array = d2t_hash{DrugIndex};
            if ~isempty(Array)
                g2d_closeness(GeneIndex,DrugIndex) = closenessFunc(network_matrix(GeneIndex,Array));
            else
                g2d_closeness(GeneIndex,DrugIndex) = 0;
            end
        end
        if rem(GeneIndex,100)==0
            fprintf('computing the %dth gene closeness profile...\n',GeneIndex);
        end
    end
end

