function [stacker_tasks, time_total] = calculate_travel_time_for_all_stacker(Huo, num_stacker, a0, v_max, alpha,V_Z,Huo_y,Huo_z)
% 根据坐标分配任务
stacker_tasks = cell(num_stacker, 1);
for i = 1:size(Huo, 2)
    task = ceil(Huo(1, i) / 2);
    stacker_tasks{task} = [stacker_tasks{task}, i];
end

% 计算货物运输时间
time_total = zeros(1, num_stacker);
for i = 1:num_stacker
    temp = stacker_tasks{i};  % 读取任务列表
    CASE = [0 (i * 2 - 0.5) 0];
    stacker_current_position = CASE;  % 堆垛机初始位置及对应缓存区位置
    if isempty(temp)
        time_total(i) = 0;
    else
        for m = 1:numel(temp)
            [time_total_temp, stacker_current_position] = calculate_travel_time(stacker_current_position, Huo(1:3, temp(m)), Huo(4, temp(m)), Huo(5, temp(m)), a0, v_max, alpha,V_Z,Huo_y,Huo_z);
            time_total(i) = time_total(i) + time_total_temp;
            [time_total_temp, stacker_current_position] = calculate_travel_time(stacker_current_position, CASE, 0, 0, a0, v_max, alpha,V_Z,Huo_y,Huo_z);
            time_total(i) = time_total(i) + time_total_temp;
        end
        time_total(i) = time_total(i)/numel(temp);
    end
end

end