for i=1:6162
    label(i,1)=1;
end
for i=6163:18486
    label(i,1)=0;
end
save('label','label')