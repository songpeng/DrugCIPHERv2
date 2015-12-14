function PPI_Matrix = preProcess( PPI_Matrix_Path )
    % Load PPI_Matrix
    if ~isempty(regexp(PPI_Matrix_Path,'\.txt$','match'))
        % As TXT format
        PPI_Matrix_data = load(PPI_Matrix_Path);
        ProteinNum = max(max(PPI_Matrix_data));
        PPI_Matrix = sparse(PPI_Matrix_data(:,1),PPI_Matrix_data(:,2),1, ProteinNum, ProteinNum);
        PPI_Matrix = PPI_Matrix + PPI_Matrix';
        [m, n] = size(PPI_Matrix);
        fprintf('this matrix is %d*%d\n', m, n);
    else
        disp('Error, please check the input format.');
    end
end

