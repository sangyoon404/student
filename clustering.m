clear

load('matchingsurvey.mat')

Z = linkage(pattern3(:,2:156), 'ward','euclidean');

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

%% pattern frequency

pattern11 = pattern3(cluster1(:,1), 2:end);
pattern22 = pattern3(cluster2(:,1), 2:end);
pattern33 = pattern3(cluster3(:,1), 2:end);
pattern44 = pattern3(cluster4(:,1), 2:end);

meanpattern = [mean(pattern11); mean(pattern22); mean(pattern33); mean(pattern44)];
