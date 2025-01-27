clc;
clear;
close all;
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
coordsRange = [1, Huo_jia; 1, Huo_y; 1, Huo_z]; % 坐标范围 [xmin, xmax; ymin, ymax; zmin, zmax]
maxGenerations = 2000;  % 最大迭代次数
populationSize = 20;   % 种群大小
crossoverRate = 0.6;   % 交叉概率
mutationRate = 0.9;    % 变异概率
T0 = 1000;              % 初始温度（模拟退火）
alpha = 0.95;          % 温度衰减因子
figure;
view(3)


%% 第一排货架
x1=1;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
plot3([x1 x1-1],[10 10],[6 6],'k-');hold on

for i=0:10
plot3([x1-1 x1-1],[i i],[0 6],'k-');hold on
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end

for i=0:6
plot3([x1-1 x1-1],[0 10],[i i],'k-');hold on
plot3([x1-1 x1-1],[i i],[0 6],'k-');hold on
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end
axis([-0.5 15 -2 Huo_y 0 Huo_z+2 ])

%% 2/3排货架
x1=3;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1-1 x1-1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
plot3([x1-1 x1-1],[0 10],[6 6],'k-');hold on
plot3([x1 x1-1],[10 10],[6 6],'k-');hold on
for i=0:10
plot3([x1-1 x1-1],[i i],[5.5 6],'k-');hold on
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1-1 x1-1],[0 1],[i i],'k-');hold on
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end
x1=4;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
for i=0:10
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end

%% 4/5排货架
x1=6;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1-1 x1-1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
plot3([x1-1 x1-1],[0 10],[6 6],'k-');hold on
plot3([x1 x1-1],[10 10],[6 6],'k-');hold on
for i=0:10
plot3([x1-1 x1-1],[i i],[5.5 6],'k-');hold on
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1-1 x1-1],[0 1],[i i],'k-');hold on
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end
plot3([x1+1 x1+1],[0 0],[0 6],'k-');hold on
plot3([x1+1 x1+1],[0 10],[6 6],'k-');hold on
for i=0:10
plot3([x1+1 x1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1 x1+1],[0 0],[i i],'k-');hold on
end
% 
%% 6/7排货架
x1=9;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1-1 x1-1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
plot3([x1-1 x1-1],[0 10],[6 6],'k-');hold on
plot3([x1 x1-1],[10 10],[6 6],'k-');hold on
for i=0:10
plot3([x1-1 x1-1],[i i],[5.5 6],'k-');hold on
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1-1 x1-1],[0 1],[i i],'k-');hold on
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end
plot3([x1+1 x1+1],[0 0],[0 6],'k-');hold on
plot3([x1+1 x1+1],[0 10],[6 6],'k-');hold on
for i=0:10
plot3([x1+1 x1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1 x1+1],[0 0],[i i],'k-');hold on
end
% 
% %% 8/9排货架
x1=12;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1-1 x1-1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
plot3([x1-1 x1-1],[0 10],[6 6],'k-');hold on
plot3([x1 x1-1],[10 10],[6 6],'k-');hold on
for i=0:10
plot3([x1-1 x1-1],[i i],[5.5 6],'k-');hold on
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1-1 x1-1],[0 1],[i i],'k-');hold on
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end
plot3([x1+1 x1+1],[0 0],[0 6],'k-');hold on
plot3([x1+1 x1+1],[0 10],[6 6],'k-');hold on
for i=0:10
plot3([x1+1 x1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1 x1+1],[0 0],[i i],'k-');hold on
end
% 
%% 10排货架
x1=15;
plot3([x1 x1],[0 0],[0 6],'k-');hold on
plot3([x1-1 x1-1],[0 0],[0 6],'k-');hold on
plot3([x1 x1],[0 10],[6 6],'k-');hold on
plot3([x1-1 x1-1],[0 10],[6 6],'k-');hold on
plot3([x1 x1-1],[10 10],[6 6],'k-');hold on
for i=0:10
plot3([x1-1 x1-1],[i i],[5.5 6],'k-');hold on
plot3([x1 x1-1],[i i],[6 6],'k-');hold on
end
for i=0:6
plot3([x1-1 x1-1],[0 1],[i i],'k-');hold on
plot3([x1-1 x1],[0 0],[i i],'k-');hold on
end

%% 绘制货物信息
load temp.mat
load best_position.mat
hold on
% 颜色标签从深到浅

% colors = [
%     135, 206, 235;   % 天空蓝
%     65, 105, 225;    % 宝蓝
%     0, 56, 103;      % 深海蓝
%     0, 128, 255;     % 湖蓝
%     0, 71, 171;      % 钴蓝
%     0, 127, 255;     % 蔚蓝
%     173, 216, 230;   % 淡蓝
%     207, 255, 255;   % 冰蓝
%     0, 0, 128;       % 海军蓝
%     0, 128, 128;     % 蓝绿色
% ]./256;
% 
% % RGB矩阵表示绿色系颜色
% colors = [
%     0, 255, 0;       % 纯绿
%     34, 139, 34;     % 森林绿
%     0, 128, 0;       % 中绿
%     46, 139, 87;     % 深海绿色
%     144, 238, 144;   % 草绿色
%     50, 205, 50;     % 黄绿色
%     152, 251, 152;   % 淡绿
%     102, 205, 170;   % 军绿
%     60, 179, 113;    % 海绿色
%     0, 255, 127;     % 春天绿
% ]./256;

colors = [
    255, 0, 0;       % 纯红
    255, 99, 71;     % 番茄红
    255, 69, 0;      % 橙红
    139, 0, 0;       % 深红
    255, 20, 147;    % 深粉红
    255, 105, 180;   % 热情粉
    233, 150, 122;   % 烧橙色
    220, 20, 60;     % 火砖红
    255, 127, 80;    % 鳄梨红
    255, 182, 193;   % 轻柔粉
]./256;

for i=1:size(optimizedPlacement,1)
color=colors(floor(weights(i)/10)+1,:);
% scatter3(optimizedPlacement(:,1)-0.5, optimizedPlacement(:,2)-0.5, optimizedPlacement(:,3)-0.5, 100, 'filled','Marker', 'o');  % 货物位置
% 设置立方体的中心坐标和边长
if optimizedPlacement(i,1)==1
x_center = optimizedPlacement(i,1)-0.5;  % x 坐标
y_center = optimizedPlacement(i,2)-0.5;  % y 坐标
z_center = optimizedPlacement(i,3)-0.5;  % z 坐标

L = 1;  % 立方体边长
% 立方体的 8 个顶点坐标
half_L = L / 2;
vertices=[];
vertices = [
    x_center - half_L, y_center - half_L, z_center - half_L;
    x_center + half_L, y_center - half_L, z_center - half_L;
    x_center + half_L, y_center + half_L, z_center - half_L;
    x_center - half_L, y_center + half_L, z_center - half_L;
    x_center - half_L, y_center - half_L, z_center + half_L;
    x_center + half_L, y_center - half_L, z_center + half_L;
    x_center + half_L, y_center + half_L, z_center + half_L;
    x_center - half_L, y_center + half_L, z_center + half_L;
];

% 定义每个面由哪些顶点组成
faces = [
%     5, 6, 7, 8;  % 上
%     1, 2, 6, 5;  % 前
    4, 1, 5, 8;  % 左
];
hold on
% 绘制立方体
patch('Vertices', vertices, 'Faces', faces, 'FaceColor', color);
hold on
end
% 
if optimizedPlacement(i,2)==1
x_center = optimizedPlacement(i,1)-0.5;  % x 坐标
y_center = optimizedPlacement(i,2)-0.5;  % y 坐标
z_center = optimizedPlacement(i,3)-0.5;  % z 坐标

L = 1;  % 立方体边长
% 立方体的 8 个顶点坐标
half_L = L / 2;
vertices=[];
vertices = [
    x_center - half_L, y_center - half_L, z_center - half_L;
    x_center + half_L, y_center - half_L, z_center - half_L;
    x_center + half_L, y_center + half_L, z_center - half_L;
    x_center - half_L, y_center + half_L, z_center - half_L;
    x_center - half_L, y_center - half_L, z_center + half_L;
    x_center + half_L, y_center - half_L, z_center + half_L;
    x_center + half_L, y_center + half_L, z_center + half_L;
    x_center - half_L, y_center + half_L, z_center + half_L;
];
if optimizedPlacement(i,1)==4||optimizedPlacement(i,1)==7||optimizedPlacement(i,1)==10||optimizedPlacement(i,1)==13
% 定义每个面由哪些顶点组成
faces = [
%     5, 6, 7, 8;  % 上
    1, 2, 6, 5;  % 前
%     4, 1, 5, 8;  % 左
];
else
  faces = [
%     5, 6, 7, 8;  % 上
    1, 2, 6, 5;  % 前
    4, 1, 5, 8;  % 左
];  
end
hold on
% 绘制立方体
patch('Vertices', vertices, 'Faces', faces, 'FaceColor', color, 'FaceAlpha', 0.5);
hold on
end
end
grid on
xlabel('货架号')
zlabel('货架高度')
ylabel('货架长度')