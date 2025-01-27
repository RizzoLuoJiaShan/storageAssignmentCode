clc;
clear all;
close all;
load temp.mat
maxGenerations = 200000;  % 最大迭代次数
populationSize = 20;   % 种群大小
bestScore(1) = 1;
for generation = 1:maxGenerations
    % 评估适应度（评价分数）
    fitness = zeros(populationSize, 1);
    for i = 1:populationSize
%         fitness(i) = 1/(evaluatePlacement(squeeze(population(i, :, :)), weights, volumes, turnoverRates, correlationMatrix,Huo_jia,num_stacker,a0, v_max, alpha,Huo_y,Huo_z,V_Z) + 1e-5);  % 适应度越大越好
    fitness(i) =evaluatePlacement(squeeze(population(i, :, :)), weights, volumes, turnoverRates, correlationMatrix,Huo_jia,num_stacker,a0, v_max, alpha,Huo_y,Huo_z,V_Z,nGoods) ;  
    end
    % 记录当前最优解
    F(generation)=min(fitness);
    [currentBestScore, bestIdx] = min(fitness);
%     disp(['当前得分',num2str(min(fitness) )])
    if currentBestScore < bestScore(best_fi)
        best_fi=best_fi+1;
        bestScore(best_fi) = currentBestScore;
        bestScore_idx(best_fi)=generation;
        bestPlacement(best_fi,:,:) = squeeze(population(bestIdx, :, :));
    end
%     选择父代
    parents = selectParents(population, fitness,Huo_jia,Huo_y,Huo_z);
    % 交叉操作
    offspring = crossover(parents, crossoverRate,coordsRange,Huo_jia,Huo_y,Huo_z);
    % 模拟退火扰动
    offspring = simulateAnnealing(offspring, T0, alpha, coordsRange,Huo_jia,Huo_y,Huo_z);
    % 变异操作
    offspring = mutate(offspring, mutationRate, coordsRange, weights, volumes, turnoverRates, correlationMatrix,Huo_jia,num_stacker,a0, v_max, alpha,Huo_y,Huo_z ,V_Z);
    % 计算新种群的适应度并更新种群
    population = offspring;    
    % 温度衰减（模拟退火）
    T0 = T0 * alpha;
end
% 输出最终的优化结果
optimizedPlacement =squeeze( bestPlacement(best_fi,:,:));

disp('优化后的货物放置坐标：');
disp(optimizedPlacement);
disp(['最小评价分数：', num2str(bestScore)]);
[uniqueRows, ~, idx] = unique(optimizedPlacement, 'rows'); size(uniqueRows, 1) < size(optimizedPlacement, 1)
%  evaluatePlacement(optimizedPlacement, weights, volumes, turnoverRates, correlationMatrix,Huo_jia,num_stacker,a0, v_max, alpha,Huo_y,Huo_z,V_Z)

%% 绘制3D散点图
optimizedPlacement (:,1)=optimizedPlacement(:,1)+floor(optimizedPlacement (:,1) / 2);
% % % 自动生成货物编号
% % for i=1:nGoods
% % goods{i} = cellstr(char(65 + i));  % 生成'A', 'B', 'C', ..., 编号
% % end
% % 生成对应的坐标
% % % 绘制3D散点图
% figure;
% scatter3(optimizedPlacement(:,1)-0.5, optimizedPlacement(:,2)-0.5, optimizedPlacement(:,3)-0.5, 500, 'filled','Marker', 'o');  % 货物位置
% x=optimizedPlacement(:,1);
% y=optimizedPlacement(:,2);
% z=optimizedPlacement(:,3);
% % % 添加货物编号标签
% % for i = 1:nGoods
% %     text(x(i), y(i), z(i), [goods{i},'weight:',num2str(weights(i))], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% % end
% 
% % 设置图形的标签
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('货物位置可视图');
% grid on;
% % axis([-20 20 1 20 0 20])
% 
% %% 绘制存储货柜
% % 定义魔方的尺寸
% n_x = Huo_jia+floor(Huo_jia/2);  % 魔方的X方向单元格数量
% n_y = Huo_y;  % 魔方的Y方向单元格数量
% n_z = Huo_z;  % 魔方的Z方向单元格数量
% % 设置每个单元格的尺寸（长、宽、高）
% cell_length = 1;  % 单元格的长度（X方向）
% cell_width = 1;   % 单元格的宽度（Y方向）
% cell_height = 1;  % 单元格的高度（Z方向）
% 
% % 创建新的图形窗口
% hold on;
% 
% % 生成隐藏的X列（根据2 + 3n规则）
% hidden_columns_x = 2 + 3*(0:floor((n_x-2)/3)); % 隐藏第2, 5, 8, 11...列
% 
% % 绘制每个单元格的边界线
% for i = 0:n_x-1
%     for j = 0:n_y-1
%         for k = 0:n_z-1
%             % 只判断当前坐标是否在隐藏的X列范围内，若是，则跳过绘制
%             if ismember(i+1, hidden_columns_x)
%                 continue;  % 跳过当前X列的绘制
%             end
%             
%             % 当前单元格的起始坐标
%             x0 = i * cell_length;
%             y0 = j * cell_width;
%             z0 = k * cell_height;
%             
%             % 立方体的8个角
%             x_corners = [x0, x0+cell_length, x0+cell_length, x0, x0, x0+cell_length, x0+cell_length, x0];
%             y_corners = [y0, y0, y0+cell_width, y0+cell_width, y0, y0, y0+cell_width, y0+cell_width];
%             z_corners = [z0, z0, z0, z0, z0+cell_height, z0+cell_height, z0+cell_height, z0+cell_height];
%             
%             % 连接每个立方体的各个边，形成类似魔方的结构
%             fill3([x_corners(1), x_corners(2)], [y_corners(1), y_corners(2)], [z_corners(1), z_corners(2)],'r'); % 前边
%             fill3([x_corners(2), x_corners(3)], [y_corners(2), y_corners(3)], [z_corners(2), z_corners(3)],'r'); % 右边
%             fill3([x_corners(3), x_corners(4)], [y_corners(3), y_corners(4)], [z_corners(3), z_corners(4)],'r'); % 后边
%             fill3([x_corners(4), x_corners(1)], [y_corners(4), y_corners(1)], [z_corners(4), z_corners(1)],'r'); % 左边
%             
%             fill3([x_corners(1), x_corners(5)], [y_corners(1), y_corners(5)], [z_corners(1), z_corners(5)],'r'); % 底边
%             fill3([x_corners(2), x_corners(6)], [y_corners(2), y_corners(6)], [z_corners(2), z_corners(6)],'r'); % 右底
%             fill3([x_corners(3), x_corners(7)], [y_corners(3), y_corners(7)], [z_corners(3), z_corners(7)],'r'); % 上后
%             fill3([x_corners(4), x_corners(8)], [y_corners(4), y_corners(8)], [z_corners(4), z_corners(8)],'r'); % 左上
%             
%             fill3([x_corners(5), x_corners(6)], [y_corners(5), y_corners(6)], [z_corners(5), z_corners(6)],'r'); % 底边
%             fill3([x_corners(6), x_corners(7)], [y_corners(6), y_corners(7)], [z_corners(6), z_corners(7)],'r'); % 右边
%             fill3([x_corners(7), x_corners(8)], [y_corners(7), y_corners(8)], [z_corners(7), z_corners(8)],'r'); % 后边
%            fill3([x_corners(8), x_corners(5)], [y_corners(8), y_corners(5)], [z_corners(8), z_corners(5)],'r'); % 左边
% %             plot3([x_corners(1), x_corners(2)], [y_corners(1), y_corners(2)], [z_corners(1), z_corners(2)], 'k'); % 前边
% %             plot3([x_corners(2), x_corners(3)], [y_corners(2), y_corners(3)], [z_corners(2), z_corners(3)], 'k'); % 右边
% %             plot3([x_corners(3), x_corners(4)], [y_corners(3), y_corners(4)], [z_corners(3), z_corners(4)], 'k'); % 后边
% %             plot3([x_corners(4), x_corners(1)], [y_corners(4), y_corners(1)], [z_corners(4), z_corners(1)], 'k'); % 左边
% %             
% %             plot3([x_corners(1), x_corners(5)], [y_corners(1), y_corners(5)], [z_corners(1), z_corners(5)], 'k'); % 底边
% %             plot3([x_corners(2), x_corners(6)], [y_corners(2), y_corners(6)], [z_corners(2), z_corners(6)], 'k'); % 右底
% %             plot3([x_corners(3), x_corners(7)], [y_corners(3), y_corners(7)], [z_corners(3), z_corners(7)], 'k'); % 上后
% %             plot3([x_corners(4), x_corners(8)], [y_corners(4), y_corners(8)], [z_corners(4), z_corners(8)], 'k'); % 左上
% %             
% %             plot3([x_corners(5), x_corners(6)], [y_corners(5), y_corners(6)], [z_corners(5), z_corners(6)], 'k'); % 底边
% %             plot3([x_corners(6), x_corners(7)], [y_corners(6), y_corners(7)], [z_corners(6), z_corners(7)], 'k'); % 右边
% %             plot3([x_corners(7), x_corners(8)], [y_corners(7), y_corners(8)], [z_corners(7), z_corners(8)], 'k'); % 后边
% %             plot3([x_corners(8), x_corners(5)], [y_corners(8), y_corners(5)], [z_corners(8), z_corners(5)], 'k'); % 左边
%         end
%     end
% end
% 
% % 设置图形显示为三维
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('货物分布示意图');
% 
% % 设置视角和网格
% grid on;
% axis equal;
% view(3);