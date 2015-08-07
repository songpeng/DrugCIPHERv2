function Protein_Shortest_Distance = measureDistance( PPI_Matrix )
    Protein_Shortest_Distance = graphallshortestpaths(PPI_Matrix,'Directed','false');
end

