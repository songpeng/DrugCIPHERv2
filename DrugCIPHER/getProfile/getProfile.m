function profile = getProfile( g2d_closeness, c2d_similarity, measureScore )
   [gene_num, drug_num] = size(g2d_closeness);
   [chem_num, drug_num_1] = size(c2d_similarity);
   if drug_num ~= drug_num_1
       error('dimension of g2d_closeness and c2d_similarity is not identical');
   end
   profile = zeros(gene_num, chem_num);
   for i = 1:gene_num
        for j = 1:chem_num
           profile(i, j) = measureScore(g2d_closeness(i, :), c2d_similarity(j, :));
		end
	    if rem(i,100)==0
            fprintf('computing the %dth gene profile...\n', i);
        end
   end
end

