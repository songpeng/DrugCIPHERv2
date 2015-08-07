function profile = getPlot( g2d_closeness, c2d_similarity, location, row_num, col_num )
%    [gene_num, drug_num] = size(g2d_closeness);
%    [chem_num, drug_num_1] = size(c2d_similarity);
%    if drug_num ~= drug_num_1
%        error('dimension of g2d_closeness and c2d_similarity is not identical');
%    end
%    for i = 1:gene_num
%        for j = 1:chem_num
%            plot(g2d_closeness(i, :), c2d_similarity(j, :), '*');
%            axis([0,3,0,1]);
%            saveas(gcf, [num2str(i),'_',num2str(j),'.jpg']);
%        end
%    end
     [x, y] = size(location);
     if x > row_num*col_num
         error('too many plots in a picture!');
     end
     subplot(row_num, col_num, 1);
     for i = 1:x
         subplot(row_num, col_num, i);
         plot(g2d_closeness(location(i, 1), :), c2d_similarity(location(i, 2), :), '*');
         axis([0,3,0,1]);
     end
     saveas(gcf, [num2str(row_num),'_',num2str(col_num),'.jpg']);
end
