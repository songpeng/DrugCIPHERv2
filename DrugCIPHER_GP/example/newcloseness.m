function [ Protein2Drug_Closeness,MD] = newcloseness( label,Protein_SP,MD )
fid=fopen('D_T_Relation_Inner_GO.txt','r');
line=fgetl(fid);
DrugIndex = 1;

while ischar(line) && ~isempty(line)
    chArray = regexp(line,'\t','split');
    TargetNum = size(chArray,2);
    if strcmp(chArray(1),'-1')
        Drug_Target_Relation{DrugIndex} = [];
    else
        Array = zeros(1,TargetNum);
        rows=[];
        j=1;
        for i = 1:TargetNum
            Array(i) = str2double(chArray{i});
            if ~ismember(Array(i),label)
                rows(j)=Array(i);
                j=j+1;
            end    
        end
        Drug_Target_Relation{DrugIndex}=rows;
    end
    
    line=fgetl(fid);
    DrugIndex=DrugIndex + 1;
end
fclose(fid);
Drugnumber=DrugIndex-1;
clear fid line DrugIndex chArray Array TargetNum ans

Proteinnumber=length(Protein_SP(:,1));
Protein2Drug_Closeness = zeros(Proteinnumber, Drugnumber);

for ProteinIndex = 1:Proteinnumber
    i=1;
    for DrugIndex = 1:Drugnumber
        Array = Drug_Target_Relation{DrugIndex};
        if ~isempty(Array)
            n=length(Array);
            Protein2Drug_Closeness(ProteinIndex, DrugIndex) = (sum(exp(-(Protein_SP(ProteinIndex,Array)).^2)))/n;
        else
            Protein2Drug_Closeness(ProteinIndex,DrugIndex) = 0;
            undrug(i)=DrugIndex;
            i=i+1;
        end
    end
end
Protein2Drug_Closeness(:,find(sum(abs(Protein2Drug_Closeness),1)==0))=[];
MD(:,undrug)=[];
end

