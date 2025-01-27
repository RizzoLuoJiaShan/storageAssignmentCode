% ��Ӧ�Ⱥ���
function [fitness Task] = evaluateParticle(particle,Num_straks,Takes,Store,a0,v_max,alpha,V_Z,Huo_y,Huo_z)
stacker1=particle{1};
store1=particle{2};
for i=1:Num_straks
    %% ����Ѷ����ȡ��ʱ��
    for n=1:size(stacker1{i},2)
        Time_stacker(i,n)=calculate_travel_time(Takes(stacker1{i}(n),:),[1.5+(i-1)*2,-1,0],a0,v_max,alpha,V_Z,Huo_y,Huo_z);
        Time_ff(i,n)=calculate_travel_time([1.5+(i-1)*2,-1,0],Takes(stacker1{i}(n),:),a0,v_max,alpha,V_Z,Huo_y,Huo_z)
    end
    %% ����Ѷ���ܴ��ʱ��
    for n=1:size(store1{i},2)
        Time_store(i,n)=calculate_travel_time([1.5+(i-1)*2,-1,0],Store(store1{i}(n),:),a0,v_max,alpha,V_Z,Huo_y,Huo_z);
    end
end
%% ȡ��ʱ��ƽ��

% ������������A��B��ά�Ȳ����
A =  Time_stacker;       % 2x2 ����
B =  Time_store; % 2x3 ����

% ��ȡ����A��B�Ĵ�С
[m1, n1] = size(A);
[m2, n2] = size(B);

% �����µľ����С
m_max = max(m1, m2); % ����
n_max = max(n1, n2); % ����

% ��չ����A��B
Time_stacker= zeros(m_max, n_max); % ����һ��ȫ�����
Time_store= zeros(m_max, n_max); % ����һ��ȫ�����

% ��A��B��Ԫ�ظ�ֵ����չ��ľ�����
Time_stacker(1:m1, 1:n1) = A;
Time_store(1:m2, 1:n2) = B;

%% ����Ѷ��ȡ���ȴ�ʱ��
for m=1:Num_straks
    for n=1:size(store1{m},2)
        for i=1:Num_straks
            index=find(store1{m}(n) ==stacker1{i});
            if index~=0
                Index(m,n,1)=i;
                Index(m,n,2)=index;
            end
        end
    end
end
for m=1:Num_straks
    for n=1:size(store1{m},2)
        T_O(m,n)=sum(Time_stacker(Index(m,n,1),1:Index(m,n,2)))+sum(Time_store(Index(m,n,1),1:Index(m,n,2)))-Time_store(Index(m,n,1),Index(m,n,2));
        T_E(m,n)=sum(Time_stacker(Index(m,n,1),1:n))+sum(Time_store(m,1:n))-Time_store(m,n);
    end
end
T_wait=zeros(Num_straks,size(Time_stacker,2));
for m=1:Num_straks
    for n=1:size(store1{m},2)
        if T_E(m,n)-T_O(m,n)>=0
            T_wait(m,n)=0;
        else
            T_wait(m,n)=T_O(m,n)-T_E(m,n);
        end
    end
end
for m=1:Num_straks
    T_stack(m)=sum(T_wait(m,:))+sum(Time_store(m,:))+sum(Time_stacker(m,:));
end
fitness = max(T_stack);
Task{1}=stacker1;
Task{2}=store1;

end