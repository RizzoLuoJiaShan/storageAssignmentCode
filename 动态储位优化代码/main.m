clc;
clear all;
close all;
load C:\Users\����ɽ2021¼ȡ�Ұ�\Documents\MATLAB\��̬��ģ0127\Codev10\����洢\Best_store.mat
Huo_jia=10;    %���ܸ���
Huo_y=10;    %���ܳ���
Huo_z=6;    %���ܸ߶�
num_stacker = round(Huo_jia/2); % �Ѷ������
nGoods = 120;  % ��������
nCoords = Huo_jia*Huo_y*Huo_z; % ������������
a0 = 0.5;                   % �Ѷ�����ٶ�
v_max = 2;                % �Ѷ������ٶ�
alpha = 2;              % �ٶ�˥��ϵ��
V_Z=0.1;                % ��ֱ���ٶ�

%% ����Ⱥ�㷨���

% ��������
N = 10; % �ܻ�����
M = N / 2; % �Ѷ����
num_particles = 50;  % ��������
max_iter = 2000;  % ����������
inertia_weight_max = 0.9;  % ��ʼ����Ȩ��
inertia_weight_min = 0.4;  % ���չ���Ȩ��
c1 = 1.5;  % ����ѧϰ����
c2 = 1.5;  % ���ѧϰ����
particle_vel = zeros(num_particles, 5);
% ����Ⱥ�Ż�����
globalBestFitness = inf;
globalBestPosition = zeros(1, N);
particleBestFitness = inf(num_particles, 1);
particleBestPosition = cell(1,3);
% ��ʼ������λ��
for i = 1:num_particles
    particlePosition{i}=  IniparticleVelocity(stacker_tasks,store_tasks);
end
for iter = 1:max_iter
    % ��̬��������Ȩ��
    inertia_weight = inertia_weight_max - (inertia_weight_max - inertia_weight_min) * (iter / max_iter);
    for i = 1:num_particles
        % ������Ӧ��
        [fitness Task] = evaluateParticle(particlePosition{i},M,Takes,Store,a0,v_max,alpha,V_Z,Huo_y,Huo_z);        
        % ���¸�������
        if fitness < particleBestFitness(i)
            particleBestFitness(i) = fitness;
            particleBestPosition= Task;
        end        
        % ����ȫ������
        if fitness < globalBestFitness
            globalBestFitness = fitness;
            globalBestPosition = Task;
            disp(['��������' num2str(iter) '��ǰ���Ž�' num2str(globalBestFitness)])
        end
    end
    % ���������ٶȺ�λ��
    for i = 1:num_particles
%         % �����ٶȸ��£������ֲ�������ȫ��ѧϰ��
%         particle_vel(i, :) = inertia_weight * particle_vel(i, :) + ...
%             c1 * rand() * (particle_best_pos(i, :) - particle_pos(i, :)) + ...
%             c2 * rand() * (global_best_pos - particle_pos(i, :));
        for m=1:size(particlePosition{i}{1},1)
            particlePosition{i}{1}{m}=particlePosition{i}{1}{m}(randperm(length(particlePosition{i}{1}{m})));
        end
        for m=1:size(particlePosition{i}{2},1)
            particlePosition{i}{2}{m}=particlePosition{i}{2}{m}(randperm(length(particlePosition{i}{2}{m})));
        end
    end    
    
end
% ������Ž�

disp('��С���������ʱ��:');
disp(globalBestFitness);

disp('------------------------------------')
disp('�Ѷ��ȡ���������')
for i=1:M
    disp(['�Ѷ��' num2str(i) ':    ' num2str(globalBestPosition{1}{i})])
end
disp('------------------------------------')
disp('�Ѷ������������')
for i=1:M
    disp(['�Ѷ��' num2str(i) ':    ' num2str(globalBestPosition{2}{i})])
end
