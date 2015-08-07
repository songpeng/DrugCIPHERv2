function closeness = measureCloseness( distArray )
    closeness = sum(exp(-(distArray).^2));
end

