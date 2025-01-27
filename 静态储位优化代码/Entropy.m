clc;
clear all;
close all;
% 基于熵权法计算权重的MATLAB代码
% 输入：数据矩阵 data，行代表样本，列代表指标
% 输出：各指标的权重 weights

% 示例数据 (行：样本，列：指标)
data = [0.50115	0.53461	0.41408
0.57666	0.46444	0.45985
0.5353	0.50342	0.35405
0.52886	0.48332	0.45862
0.51516	0.49906	0.3609
0.52919	0.48962	0.35697
0.50281	0.52283	0.32391
];

% 步骤1: 数据归一化（极差归一化到[0, 1]）
[m, n] = size(data); % 获取数据矩阵的大小
normalized_data = zeros(m, n);
for j = 1:n
    minVal = min(data(:, j));
    maxVal = max(data(:, j));
    normalized_data(:, j) = (data(:, j) - minVal) / (maxVal - minVal);
end

% 步骤2: 计算信息熵
k = 1 / log(m); % 常数
entropy = zeros(1, n);
for j = 1:n
    p = normalized_data(:, j) ./ sum(normalized_data(:, j)); % 比例
    p(isnan(p)) = 0; % 处理0/0情况
    entropy(j) = -k * sum(p .* log(p + eps)); % 信息熵，eps避免log(0)
end

% 步骤3: 计算权重
d = 1 - entropy; % 信息熵的对比度
weights = d / sum(d); % 归一化权重

% 显示结果
disp('指标权重：');
disp(weights);
