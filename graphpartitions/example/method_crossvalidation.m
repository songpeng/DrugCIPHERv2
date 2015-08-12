clear all
profile ON
%% get all Drug-Target Relation
fid=fopen('D_T_Relation_Inner_GO.txt','r');
line=fgetl(fid);
DrugIndex = 1;
g=0;
while ischar(line) && ~isempty(line)
    chArray = regexp(line,'\t','split');
    TargetNum = size(chArray,2);
    if strcmp(chArray(1),'-1')
        Drug_Target_Relation{DrugIndex} = [];
    else
        Array = zeros(1,TargetNum);
        for i = 1:TargetNum
            Array(i) = str2double(chArray{i});
        end
        g=g+length(Array);
        Drug_Target_Relation{DrugIndex}=Array;
    end
    
    line=fgetl(fid);
    DrugIndex=DrugIndex + 1;
end
fclose(fid);
Drugnumber=DrugIndex-1;
clear fid line DrugIndex chArray Array TargetNum ans i
%% load drug similarity and protein similarity matrice
load('GO_SP');
load('drugS.mat');
Protein_SP=y;
Proteinnumber=length(Protein_SP(:,1));    %assign label to all drug-protein relationship
collabel=Proteinnumber+1;

for i=1:Proteinnumber
    Protein_SP(i,collabel)=i;
end
clear i
%% generate positive and nagetive samples
P=zeros(g,1);
D=zeros(g,Drugnumber);
U=zeros(2*g,1);
t=1;
for DrugIndex = 1:Drugnumber                         %select known drug-target ineractions
    Array = Drug_Target_Relation{DrugIndex};
    n=length(Array);
    if ~isempty(Array)
       for i=1:n;
          P(t,1)=Protein_SP(Array(i),collabel);
          D(t,:)=a(DrugIndex,:);
          t=t+1;
       end
    end
end
for i=1:2*(t-1)                                       %select unknown drug-target ineractions
    nontarget=randint(1,1,[1 Proteinnumber]);   
    while(ismember(nontarget,P))
         nontarget=randint(1,1,[1 Proteinnumber]);
    end
    U(i,1)=Protein_SP(nontarget,collabel);
end
clear a y Array DrugIndex collabel i n g t nontarget

%% 10-fold crossvalidation
load('label');
M=[P;U];
indices = crossvalind('Kfold',M,5);
tenlgR=[];
for i = 1:5
    test=(indices==i);train = ~test;
    MD=[D;D;D];
    [Protein2Drug_Closeness,MD]=newcloseness(M(test,1),Protein_SP(:,1:Proteinnumber),MD); %compute new Drug-protein closeness
    MP=zeros(length(M),length(MD(1,:)));
    for j=1:length(M)
        MP(j,:)=Protein2Drug_Closeness(M(j,1),:);
    end
    lgR = interclass(MD(test,:),MP(test,:),MD(train,:),MP(train,:),label(train,:),label(test,:));
    tenlgR=vertcat(tenlgR,lgR);
end

profile VIEWER