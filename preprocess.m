clear all
clc



%load('preprocess.mat'); %% 

% table2array

new = [preprocess(:,1) preprocess(:,3) preprocess(:,2) preprocess(:,4)];
[r, c] = size(new);


%% 건물별 semantic화
for i = 1:r
    if new(i,3) == 1 || new(i,3) == 2
        new(i,3) = 1;
    elseif new(i,3) == 3 
        new(i,3) = 2;
    elseif new(i,3) == 4 || new(i,3) == 5 || new(i,3) == 9 || new(i,3) == 10 || new(i,3) == 11 || new(i,3) == 12
        new(i,3) = 3;
    elseif new(i,3) == 6 || new(i,3) == 8
        new(i,3) = 4;
    elseif new(i,3) == 7 || new(i,3) == 14
        new(i,3) = 5;
    end
end


%% 중복 연속로그 제거
temp = new(1,3);
Removed = zeros(r,c);
Removed(1,:) = new(1,:);
for i = 1:r
    if new(i,3) ~= temp
        Removed(i,:) = new(i,:);
        temp = new(i,3);
    end
end
REMOVE = Removed(any(Removed,2),:); %% value가 0 0 0 0 인 행 제거
%REMOVE = new(any(new,2),:);

%% 각 trajectory 길이 계산
[r, c] = size(REMOVE);

D = max(REMOVE(:,2)); %% 날짜 수

Num_stu = unique(REMOVE(:,1));
L = length(Num_stu);
SIZE = zeros(L, D);
% 아이디 변환
NUM = 1:L;
STID = [Num_stu NUM'];
[idxa, idxb] = ismember(REMOVE(:,1), STID(:,1)); 
idxb(idxb==0) = [];
JOIN = [REMOVE(idxa,:) STID(idxb,:)];
REMOVE = [JOIN(:,6) JOIN(:,2:4)];

for k = 1: L
    disp(['Student num : ',num2str(k)]);
    for j = 1: D
        SIZE(k,j) = size(REMOVE(REMOVE(:,1)==k & REMOVE(:,2)==j),1) ;
    end
end
     
%% trajectory 사전 할당
trajectory = cell(L, D);

for l = 1: L
    for m = 1 : D 
        trajectory{l, m} = zeros(1, SIZE(l,m)); 
    end
end

%% trajectory 구축
for n = 1: L
    disp(['Student num : ',num2str(n)]);
    for o = 1: D
        trajectory{n, o} = REMOVE(REMOVE(:,1)==n & REMOVE(:,2)==o, 3)' ;   
    end
end

%% 학생당 trajectory
student_trajectory = cell(L,1);
trans = trajectory';

save('trajectory.mat')
%% prefixspan mining
[r1,c1] = size(trans);

db = trans;

min_support = 2; %% Thredhold
loc_num = 5; %% 1, 2, 3, 4, 5

length1 = zeros(loc_num,c1); %% length-1 sequential patterns 

for p = 1 : c1
    for q = 1 : r1
        for s = 1 : loc_num
            length1(s,p) = length1(s,p) + sum(db{q,p} == s);
        end       
    end
end



db_1 = cell (r1,c1); %% postfix db for each prefix
db_2 = cell (r1,c1);
db_3 = cell (r1,c1);
db_4 = cell (r1,c1);
db_5 = cell (r1,c1);

%% prefix 1
for t = 1: c1
    disp(['Date : ',num2str(t)]);
    for u = 1: r1 
        if  ~isempty(find(db{u,t} == 1,1))
            if length1(1, t) > 1 
                temp1 =  find(db{u,t} == 1);
                db_1{u,t} = db{u,t}(1, temp1(1,1)+1 : SIZE(t,u));
            end
        end
    end
end


length21 = zeros(loc_num,c1);
for p = 1 : c1
    for q = 1 : r1
        for s = 1 : loc_num
            length21(s,p) = length21(s,p) + sum(db_1{q,p} == s);
        end       
    end
end

pattern1_2 = zeros(loc_num,c1);

for p = 1 : c1
    for q = 1 : r1
        for s = 1 : loc_num
            if ~isempty(db_1{q,p})
                pattern1_2(s,p) = pattern1_2(s,p) + sum(db_1{q,p}(1,1) == s);
            end
        end       
    end
end

db_21 = cell(111, L);

for t = 1: c1
    for u = 1: r1 
        if  ~isempty(find(db_1{u,t} == 1,1))
            if length21(2, t) > 1
                if db_1{u,t}(:,1) == 2
                    temp1 =  find(db_1{u,t} == 2);
                    if temp1(1,1) ~= length(db_1{u,t})
                        db_21{u,t} = db_1{u,t}(1, temp1(1,1)+1 : length(db_1{u,t}));
                    end
                end
            end
        end
    end
end

pattern12_3 = zeros(loc_num,c1);
for p = 1 : c1
    for q = 1 : r1
        for s = 1 : loc_num
            if ~isempty(db_21{q,p})
                pattern12_3(s,p) = pattern12_3(s,p) + sum(db_21{q,p}(1,1) == s);
            end
        end       
    end
end

save('traans.mat')