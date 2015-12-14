cutoff1=zeros(20,20);
for f=1:20
    for d=1:20
        lgR = interclass(MD(test,:),MP(test,:),MD(train,:),MP(train,:),label(train,:),label(test,:),(f/20),(d/20));
        c=sortrows(lgR,-1);
        [X1,Y1,T1 AUC1]=perfcurve(c(:,2),c(:,1),'1');
        cutoff1(d,f)=AUC1;
    end
end    