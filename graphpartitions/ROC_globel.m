c=sortrows(tenlgR,-1);
[X1,Y1,T1 AUC1]=perfcurve(c(:,2),c(:,1),'1');
plot(X1,Y1,'LineWidth',2);
xlabel('False positive rate(1-Specificity)','FontSize',20)
ylabel('True positive rate(Sensitivity)','FontSize',20)
title(sprintf('ROC curve (AUC=%0.4f)',AUC1),'FontSize',24);