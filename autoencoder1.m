
load matchingsurvey.mat;
pattern = pattern3';
pattern1 = pattern(2:156,:);
autoenc1 = trainAutoencoder(pattern1,100, ...
'MaxEpochs',400, ...
'L2WeightRegularization',0.004, ...
'SparsityRegularization',4, ...
'SparsityProportion',0.15, ...
'ScaleData', false);
feat1 = encode(autoenc1,pattern1);
enc1 = feat1';
Z = linkage(enc1, 'ward','euclidean');
figure
[~,T] = dendrogram(Z,4);
cluster1 = find(T==1);
cluster2 = find(T==3);
cluster3 = find(T==2);
cluster4 = find(T==4);
cluster11 = target3(cluster1(:,1), :);
cluster22 = target3(cluster2(:,1), :);
cluster33 = target3(cluster3(:,1), :);
cluster44 = target3(cluster4(:,1), :);
MEAN1= [];
for i = 2 : 12
MEAN1 = [MEAN1 mean(cluster11(:,i))];
end
MEAN2= [];
for i = 2 : 12
MEAN2 = [MEAN2 mean(cluster22(:,i))];
end
MEAN3= [];
for i = 2 : 12
MEAN3 = [MEAN3 mean(cluster33(:,i))];
end
MEAN4= [];
for i = 2 : 12
MEAN4 = [MEAN4 mean(cluster44(:,i))];
end
MEAN = [MEAN1; MEAN2; MEAN3; MEAN4;];
pattern11 = pattern3(cluster1(:,1), 2:end);
pattern22 = pattern3(cluster2(:,1), 2:end);
pattern33 = pattern3(cluster3(:,1), 2:end);
pattern44 = pattern3(cluster4(:,1), 2:end);
meanpattern = [mean(pattern11); mean(pattern22); mean(pattern33); mean(pattern44)];

eva = evalclusters(enc1,'linkage','silhouette','KList',[1:6])
%% Stacked AE
hiddenSize2 = 50;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',100, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);
feat2 = encode(autoenc2,feat1);
enc2 = feat2';
Z = linkage(enc2, 'ward','euclidean');
figure
[~,T] = dendrogram(Z,6);
cluster1 = find(T==1);
cluster2 = find(T==2);
cluster3 = find(T==3);
cluster4 = find(T==4);
cluster5 = find(T==5);
cluster6 = find(T==6);

cluster11 = target3(cluster1(:,1), :);
cluster22 = target3(cluster2(:,1), :);
cluster33 = target3(cluster3(:,1), :);
cluster44 = target3(cluster4(:,1), :);
cluster55 = target3(cluster5(:,1), :);
cluster66 = target3(cluster6(:,1), :);

MEAN1= [];
for i = 2 : 12
MEAN1 = [MEAN1 mean(cluster11(:,i))];
end
MEAN2= [];
for i = 2 : 12
MEAN2 = [MEAN2 mean(cluster22(:,i))];
end
MEAN3= [];
for i = 2 : 12
MEAN3 = [MEAN3 mean(cluster33(:,i))];
end
MEAN4= [];
for i = 2 : 12
MEAN4 = [MEAN4 mean(cluster44(:,i))];
end
MEAN5= [];
for i = 2 : 12
MEAN5 = [MEAN5 mean(cluster55(:,i))];
end
MEAN6= [];
for i = 2 : 12
MEAN6 = [MEAN6 mean(cluster66(:,i))];
end

MEAN = [MEAN1; MEAN2; MEAN3; MEAN4; MEAN5; MEAN6];
pattern11 = pattern3(cluster1(:,1), 2:end);
pattern22 = pattern3(cluster2(:,1), 2:end);
pattern33 = pattern3(cluster3(:,1), 2:end);
pattern44 = pattern3(cluster4(:,1), 2:end);
pattern55 = pattern3(cluster5(:,1), 2:end);
pattern66 = pattern3(cluster6(:,1), 2:end);
meanpattern = [mean(pattern11); mean(pattern22); mean(pattern33); mean(pattern44); mean(pattern55); mean(pattern66)];

evasil1 = evalclusters(enc2,'linkage','silhouette','KList',4)
evasil2 = evalclusters(pattern3,'linkage','silhouette','KList',4)

evagap1 = evalclusters(enc2,'linkage','gap','KList',4)
evagap2 = evalclusters(pattern3,'linkage','gap','KList',4)

evacal1 = evalclusters(enc2,'linkage','CalinskiHarabasz','KList',4)
evacal2 = evalclusters(pattern3,'linkage','CalinskiHarabasz','KList',4)

evadav1 = evalclusters(enc2,'linkage','DaviesBouldin','KList',4)
evadav2 = evalclusters(pattern3,'linkage','DaviesBouldin','KList',4)

