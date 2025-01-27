% 交叉操作：部分匹配交叉
function offspring = crossover(parents, crossoverRate,coordsRange,Huo_jia,Huo_y,Huo_z)
offspring = parents;
    for i = 1:2:size(parents, 1)-1
        if rand() < crossoverRate
            crossoverPoint = randi([1, size(parents, 2)]); % 交叉点
            temp = offspring(i, crossoverPoint:end, :);
            offspring(i, crossoverPoint:end, :) = offspring(i+1, crossoverPoint:end, :);
            offspring(i+1, crossoverPoint:end, :) = temp;
            
            % 在交叉后，检查并修复重复坐标
            offspring(i, :, :) = ensureUniqueCoords(squeeze(offspring(i, :, :)),coordsRange);
            offspring(i+1, :, :) = ensureUniqueCoords(squeeze(offspring(i+1, :, :)),coordsRange);
        end
    end
    if any(any(offspring(:, :, 1)  > Huo_jia))==1|| any(any(offspring(:, :, 2)  > Huo_y))==1 || any(any(offspring(:, :, 3)  > Huo_z))==1% 判断列中是否有元素大于5
    disp('程序暂停：矩阵第2列存在元素大于5');
    return; % 暂停程序
    % 或者使用 error 抛出错误
    % error('矩阵第2列存在元素大于5，程序终止');
end
end
