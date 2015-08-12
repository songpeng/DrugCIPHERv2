function [lgR] = interclass( Dtest,Ptest,Dtrain,Ptrain,labeltrain,labeltest)
d=0.6;
f=0.54;
PL=[Ptrain,labeltrain];
row_index1=(PL(:,end)==1);
row_index2=(PL(:,end)==0);
D=Dtrain(row_index1,:);
P=Ptrain(row_index1,:);
DU=Dtrain(row_index2,:);
U=Ptrain(row_index2,:);

%s=length(P(:,1));
%su=length(U(:,1));
N1 = (sum(sum((D<d) & (P<f))));
M1 = (sum(sum((DU<d) & (U<f))));
N2 = (sum(sum((D>=d) & (P<f))));
M2 = (sum(sum((DU>=d) & (U<f))));
N3 = (sum(sum((D>=d) & (P>=f))));
M3 = (sum(sum((DU>=d) & (U>=f))));
N4 = (sum(sum((D<d) & (P>=f))));
M4 = (sum(sum((DU<d) & (U>=f))));
P11 = N1/(N1+N2+N3+N4);
P12 = N2/(N1+N2+N3+N4);
P13 = N3/(N1+N2+N3+N4);
P14 = N4/(N1+N2+N3+N4);
P01 = M1/(M1+M2+M3+M4);
P02 = M2/(M1+M2+M3+M4);
P03 = M3/(M1+M2+M3+M4);
P04 = M4/(M1+M2+M3+M4);
clear N1 N2 N3 N4 M1 M2 M3 M4
if P01==0
    P01=0.0000000001;
end
if P02==0
    P02=0.0000000001;
end
if P03==0
    P03=0.0000000001;
end
if P04==0
    P04=0.0000000001;
end
lgPr=[log10(P11/P01),log10(P12/P02),log10(P13/P03),log10(P14/P04)];
clear  P11 P12 P13 P14

t=length(Ptest(:,1));
for i=1:t
   n1 = sum((Dtest(i,:)<d) & (Ptest(i,:)<f));
   n2 = sum((Dtest(i,:)>=d) & (Ptest(i,:)<f));
   n3 = sum((Dtest(i,:)>=d) & (Ptest(i,:)>=f));
   n4 = sum((Dtest(i,:)<d) & (Ptest(i,:)>=f));
   n=[n1,n2,n3,n4];
   lgR(i,1)=sum(n.*lgPr);
   lgR(i,2)=labeltest(i,1);
end
end

