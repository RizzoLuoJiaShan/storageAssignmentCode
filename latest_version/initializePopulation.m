
% 生成初始种群（每个个体为货物的坐标安排）
function population = initializePopulation(populationSize, nGoods, coordsRange,Huo_jia,Huo_y,Huo_z)
population = zeros(populationSize, nGoods, 3); % (种群大小 x 货物数 x 3个坐标)
    for i = 1:populationSize
        coords = zeros(nGoods, 3); % 存放坐标的数组
        for j = 1:nGoods
            isValid = false;
            while ~isValid
                % 随机生成坐标，使其位于指定范围内，且坐标为整数
                newCoord = [randi([coordsRange(1,1), coordsRange(1,2)]), ...
                            randi([coordsRange(2,1), coordsRange(2,2)]), ...
                            randi([coordsRange(3,1), coordsRange(3,2)])];
                % 确保没有重复坐标
                if isempty(find(ismember(coords, newCoord, 'rows'), 1))
                    coords(j, :) = newCoord;  % 只有不重复的坐标才能加入
                    isValid = true;
                end
            end
        end
        population(i, :, :) = coords;
  if any(any( population(:, :, 1)  > Huo_jia))==1|| any(any( population(:, :, 2)  > Huo_y))==1 || any(any( population(:, :, 3)  > Huo_z))==1% 判断列中是否有元素大于5
    disp('程序暂停：矩阵第2列存在元素大于5');
    return; % 暂停程序
    % 或者使用 error 抛出错误
    % error('矩阵第2列存在元素大于5，程序终止');
end
    end


end