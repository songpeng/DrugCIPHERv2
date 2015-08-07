function d2t_hash = getD2tHash( d2t_path )
    fid = fopen(d2t_path);
    line = fgetl(fid);
    DrugIndex = 1;
    d2t_hash = cell(0,0);
    while ischar(line) && ~isempty(line)
        chArray = regexp(line,'\t','split'); %Get target array for this drug
        TargetNum = size(chArray,2);
        if strcmp(chArray(1),'-1')
            d2t_hash{DrugIndex} = [];
        else
            Array = zeros(1,TargetNum);
            for i = 1:TargetNum
                Array(i) = str2double(chArray{i});
            end
            d2t_hash{DrugIndex} = Array;
        end
        % Next line
        line = fgetl(fid);
        DrugIndex = DrugIndex + 1;
    end
end

