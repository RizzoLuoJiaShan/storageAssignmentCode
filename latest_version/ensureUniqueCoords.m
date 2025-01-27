function coords = ensureUniqueCoords(coords, coordsRange)
    % 获取唯一坐标及其索引
    [uniqueCoords, ~, idx] = unique(coords, 'rows');
    % 如果存在重复坐标
    while length(uniqueCoords) < size(coords, 1)
        % 查找重复坐标的索引
        [~, ~, idx] = unique(coords, 'rows', 'stable');
        duplicateIndices = find(histc(idx, unique(idx)) > 1);
        % 对每个重复坐标重新生成，直到不再重复
        for i = 1:length(duplicateIndices)
            isUnique = false;
            while ~isUnique
                % 重新生成新的坐标
                newCoord = [randi([coordsRange(1,1), coordsRange(1,2)]), ...
                            randi([coordsRange(2,1), coordsRange(2,2)]), ...
                            randi([coordsRange(3,1), coordsRange(3,2)])];
                % 检查新坐标是否唯一
                if isempty(find(ismember(coords, newCoord, 'rows'), 1))
                    coords(duplicateIndices(i), :) = newCoord;
                    isUnique = true;
                end
            end
        end
        % 更新唯一坐标集
        [uniqueCoords, ~, idx] = unique(coords, 'rows');
    end
end