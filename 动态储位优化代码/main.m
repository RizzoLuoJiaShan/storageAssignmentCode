clc;
clear all;
close all;
load C:\Users\珞珈山2021录取我把\Documents\MATLAB\动态建模0127\Codev10\结果存储\Best_store.mat
Huo_jia=10;    %货架个数
Huo_y=10;    %货架长度
Huo_z=6;    %货架高度
num_stacker = round(Huo_jia/2); % 堆垛机数量
nGoods = 120;  % 货物数量
nCoords = Huo_jia*Huo_y*Huo_z; % 可用坐标数量
a0 = 0.5;                   % 堆垛机加速度
v_max = 2;                % 堆垛机最大速度
alpha = 2;              % 速度衰减系数
V_Z=0.1;                % 垂直加速度

%% 粒子群算法求解

% 参数设置
N = 10; % 总货架数
M = N / 2; % 堆垛机数
num_particles = 50;  % 粒子数量
max_iter = 2000;  % 最大迭代次数
inertia_weight_max = 0.9;  % 初始惯性权重
inertia_weight_min = 0.4;  % 最终惯性权重
c1 = 1.5;  % 个体学习因子
c2 = 1.5;  % 社会学习因子
particle_vel = zeros(num_particles, 5);
% 粒子群优化过程
globalBestFitness = inf;
globalBestPosition = zeros(1, N);
particleBestFitness = inf(num_particles, 1);
particleBestPosition = cell(1,3);
% 初始化粒子位置
for i = 1:num_particles
    particlePosition{i}=  IniparticleVelocity(stacker_tasks,store_tasks);
end
for iter = 1:max_iter
    % 动态调整惯性权重
    inertia_weight = inertia_weight_max - (inertia_weight_max - inertia_weight_min) * (iter / max_iter);
    for i = 1:num_particles
        % 计算适应度
        [fitness Task] = evaluateParticle(particlePosition{i},M,Takes,Store,a0,v_max,alpha,V_Z,Huo_y,Huo_z);        
        % 更新个体最优
        if fitness < particleBestFitness(i)
            particleBestFitness(i) = fitness;
            particleBestPosition= Task;
        end        
        % 更新全局最优
        if fitness < globalBestFitness
            globalBestFitness = fitness;
            globalBestPosition = Task;
            disp(['迭代次数' num2str(iter) '当前最优解' num2str(globalBestFitness)])
        end
    end
    % 更新粒子速度和位置
    for i = 1:num_particles
%         % 粒子速度更新（包含局部搜索和全局学习）
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
% 输出最优解

disp('最小化的最大工作时间:');
disp(globalBestFitness);

disp('------------------------------------')
disp('堆垛机取货任务分配')
for i=1:M
    disp(['堆垛机' num2str(i) ':    ' num2str(globalBestPosition{1}{i})])
end
disp('------------------------------------')
disp('堆垛机存放任务分配')
for i=1:M
    disp(['堆垛机' num2str(i) ':    ' num2str(globalBestPosition{2}{i})])
end
