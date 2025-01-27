% 模拟退火扰动
function population = simulateAnnealing(population, T, alpha, coordsRange,Huo_jia,Huo_y,Huo_z)
    for i = 1:size(population, 1)
        if rand() < 0.5  % 随机选择是否应用模拟退火
            % 随机选择两个货物进行交换，并确保坐标为整数
            idx1 = randi([1, size(population, 2)]);
            idx2 = randi([1, size(population, 2)]);
            temp = population(i, idx1, :);
            population(i, idx1, :) = population(i, idx2, :);
            population(i, idx2, :) = temp;
        end
    end
    if any(any( population(:, :, 1)  > Huo_jia))==1|| any(any( population(:, :, 2)  > Huo_y))==1 || any(any( population(:, :, 3)  > Huo_z))==1% 判断列中是否有元素大于5
    disp('程序暂停：矩阵第2列存在元素大于5');
    return; % 暂停程序
    % 或者使用 error 抛出错误
    % error('矩阵第2列存在元素大于5，程序终止');
end
end
