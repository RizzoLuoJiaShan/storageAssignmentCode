

% 变异操作：随机改变某个货物的位置，并保证坐标为整数
function population = mutate(population, mutationRate,coordsRange, weights, volumes, turnoverRates, correlationMatrix,Huo_jia,num_stacker,a0, v_max, alpha,Huo_y,Huo_z ,V_Z)
for i = 1:size(population, 1)

    for n=1:size(population, 2)
        Huo=[squeeze(population(i,n,:))' weights(n) volumes(n) turnoverRates(n)]';
        [stacker_tasks, time_total] = calculate_travel_time_for_all_stacker(Huo, num_stacker, a0, v_max, alpha,V_Z,Huo_y,Huo_z);
        % disp(['任务总时间', num2str(max(time_total)), 's']);
        %% 货架稳定性分析
        S_STABILITY = analyze_shelf_stability(Huo, Huo_jia, Huo_z, Huo_y,1000000);
        % disp(['货架稳定性评价分数为', num2str(max(S_STABILITY ))]);
        %% 周转性与便利性分析
        S_convenience = analyze_turnover_and_convenience(Huo,correlationMatrix, Huo_jia,Huo_y,Huo_z,1);
        % disp(['周转性与便利性分析', num2str(max(S_convenience ))]);
        score(n) =0.4338*max(S_STABILITY )+0.2405*S_convenience+0.3257*max(time_total);
%         score(n)=S_convenience ;
    end

    [~, colIndices] = find(score> mean(score));

    if rand() < mutationRate
        mutateIdx = randi([1, size(colIndices, 2)]);  % 随机选择一个货物
        % 随机变异，确保坐标为整数，并且不与其他货物重复
        newCoord = [randi([coordsRange(1,1), coordsRange(1,2)]), ...
            randi([coordsRange(2,1), coordsRange(2,2)]), ...
            randi([coordsRange(3,1), coordsRange(3,2)])];
        % 检查是否与其他货物重复
        coords = squeeze(population(i, :, :));
        while any(ismember(coords, newCoord, 'rows'))
                newCoord = [randi([coordsRange(1,1), coordsRange(1,2)]), ...
                randi([coordsRange(2,1), coordsRange(2,2)]), ...
                randi([coordsRange(3,1), coordsRange(3,2)])];
        end
        population(i, colIndices(mutateIdx), :) = newCoord;  % 更新变异后的坐标
    end  
end
end
