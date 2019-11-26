%% 2분법 매칭
clear
clc

target = xlsread('variables.xlsx');
load('stid.mat');
pattern = xlsread('patternfinal.xlsx');


target1 = sortrows(target,1);
target2 = target1(ismember(target1(:,1), STID),:);
STID = [STID (1:685)'];
STID2 = STID(ismember(STID(:,1), target2(:,1)),:); 

pattern1 = pattern(:,2:686)';
pattern2 = [(1:685)' pattern1];
pattern3 = pattern2(ismember(pattern2(:,1), STID2(:,2)), :);

target3 = [STID2(:,2) target2(:,2:6)];

save('matching.mat','target3', 'pattern3') 


%% 설문지 매칭
clear
clc

target = xlsread('12월설문지2.xlsx');
load('stid.mat','STID');
pattern = xlsread('patternfinal.xlsx');


target1 = sortrows(target,1);
target2 = target1(ismember(target1(:,1), STID),:);
STID = [STID (1:685)'];
STID2 = STID(ismember(STID(:,1), target2(:,1)),:); 

pattern1 = pattern(:,2:686)';
pattern2 = [(1:685)' pattern1];
pattern3 = pattern2(ismember(pattern2(:,1), STID2(:,2)), :);

target3 = [STID2(:,2) target2(:,2:12)];

save('matchingsurvey.mat','target3', 'pattern3') 


%% 정신건강 
clear
clc

target = xlsread('12월설문지2.xlsx');
load('mental.mat')

target1 = sortrows(target,1);
target2 = target1(ismember(target1(:,1), STID(:,1)),:);
STID2 = STID(ismember(STID(:,1), target2(:,1)),:); 
mental = target2(:,[1 9 10 11 12]);
location1 = length1';
location1 = [(1:4852)' location1];

location1 = location1(ismember(location1(:,1), STID2(:,2)),:);
mental1 = [STID2(:,2) mental(:,2:5)];

save('maching.mat','mental1', 'location1');

%% pattern 정신건강
clear
clc

target = xlsread('12월설문지2.xlsx');
load('mental.mat')

target1 = sortrows(target,1);
target2 = target1(ismember(target1(:,1), STID(:,1)),:);
STID2 = STID(ismember(STID(:,1), target2(:,1)),:); 
mental = target2(:,[1 9 10 11 12]);
location1 = total';
location1 = [(1:4852)' location1];

location1 = location1(ismember(location1(:,1), STID2(:,2)),:);
mental1 = [STID2(:,2) mental(:,2:5)];

save('machingpattern.mat','mental1', 'location1');
%% pattern 정신건강
clear
clc

target = xlsread('12월설문지2.xlsx');
load('mental.mat')

target1 = sortrows(target,1);
target2 = target1(ismember(target1(:,1), STID(:,1)),:);
STID2 = STID(ismember(STID(:,1), target2(:,1)),:); 
mental = target2;
location1 = total';
location1 = [(1:4852)' location1];

location1 = location1(ismember(location1(:,1), STID2(:,2)),:);
mental1 = [STID2(:,2) mental(:,2:end)];

save('machingmentalpattern.mat','mental1', 'location1');

%% GPA
clear
clc

load('mental.mat')
target = xlsread('gpa.xlsx');

arget1 = sortrows(target,1);
target2 = target1(ismember(target1(:,1), STID(:,1)),:);
STID2 = STID(ismember(STID(:,1), target2(:,1)),:); 
gpa1 = target2;
location1 = total';
location1 = [(1:4852)' location1];

location1 = location1(ismember(location1(:,1), STID2(:,2)),:);
gpa2 = [STID2(:,2) gpa1(:,2)];

save('machingpattern.mat','gpa2', 'location1');
