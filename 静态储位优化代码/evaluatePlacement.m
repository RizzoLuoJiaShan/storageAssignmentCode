% 评价函数：计算货物放置方案的评价分数（示例函数，可根据实际情况修改）
function score = evaluatePlacement(placement, weights, volumes, turnoverRates, correlationMatrix,Huo_jia,num_stacker,a0, v_max, alpha,Huo_y,Huo_z ,V_Z,nGoods)
    score = 0;

 % 检查是否有重复的坐标，若有，增加惩罚分数
    [uniqueCoords, ~, idx] = unique(placement, 'rows');
    if length(uniqueCoords) < size(placement, 1)
        % 存在重复坐标，增加惩罚分数
        score = score + 100000000000;  % 可以根据问题调整惩罚权重
    end

Huo=[placement weights volumes turnoverRates]';
[stacker_tasks, time_total] = calculate_travel_time_for_all_stacker(Huo, num_stacker, a0, v_max, alpha,V_Z,Huo_y,Huo_z);
% disp(['任务总时间', num2str(max(time_total)), 's']);

%% 货架稳定性分析
S_STABILITY = analyze_shelf_stability(Huo, Huo_jia, Huo_z, Huo_y,1000000);
% disp(['货架稳定性评价分数为', num2str(max(S_STABILITY ))]);
% 
%% 周转性与便利性分析
S_convenience = analyze_turnover_and_convenience(Huo,correlationMatrix, Huo_jia,Huo_y,Huo_z,nGoods);
% disp(['周转性与便利性分析', num2str(max(S_convenience ))]);
w1=1/3;
w2=1/3;
w3=1/3;
score =0.4338*max(S_STABILITY )+0.2405*S_convenience+0.3257*max(time_total);

% score =S_convenience+(max(time_total));
% disp(['评价得分为：',num2str(score)])
end