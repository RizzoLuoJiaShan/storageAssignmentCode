function [time_total, stacker_current_position] = calculate_travel_time(stacker_pos, target_pos, weight, volume,a0,v_max,alpha,V_Z,Huo_y,Huo_z)
% 输入：堆垛机当前位置 (stacker_pos)，目标位置 (target_pos)
%       目标货物的重量 (weight)，体积 (volume)，加速度时间常数 (tau)，最大速度 (v_max)

% 计算当前位置与目标位置之间的距离
distance = sqrt((stacker_pos(2) - target_pos(2))^2);
% 定义加速和减速阶段的最大可运动距离
d_acc = v_max ^2/(4*a0);  % 加速阶段的距离（根据最大速度和加速时间常数计算）
d_dec = v_max ^2/(4*a0);  % 减速阶段的距离（假设加速和减速过程相同）
time_acc = (log(1+(alpha*v_max)/a0))/alpha;  % 加速时间
% 计算匀速阶段的时间
time_cruise = (sqrt(Huo_y^2) - d_acc - d_dec) / v_max;
% 计算减速阶段的时间
time_dec = (log(1+(alpha*v_max)/a0))/alpha;  % 减速时间
% 总运动时间
Move_max= time_acc + time_cruise + time_dec;
k1=1.5;
k2=2;
k3=target_pos(3)/V_Z;     % 固定取货时间（单位：秒）
beta=1.5;
gamma=1.2;
Load_max=k1* 100^beta + k2 * 100^gamma+Huo_z/V_Z;
if distance > (d_acc + d_dec)
    % 如果目标距离大于加速距离加减速距离，堆垛机会先加速到最大速度，再匀速，最后减速
    % 计算加速阶段时间
    time_acc = (log(1+(alpha*v_max)/a0))/alpha;  % 加速时间
    % 计算匀速阶段的时间
    time_cruise = (distance - d_acc - d_dec) / v_max;
    % 计算减速阶段的时间
    time_dec = (log(1+(alpha*v_max)/a0))/alpha;  % 减速时间
    % 总运动时间
    time_move = time_acc + time_cruise + time_dec;
else
    % 如果目标距离小于加速距离加减速距离，堆垛机只会加速或减速
    % 计算加速阶段时间
    time_move = distance / v_max;  % 在加速阶段的运动时间
end
% 计算取货时间

if target_pos(3)==1
    time_load =0;
else
    time_load =k1* weight^beta + k2 * volume^gamma+k3;  % 取货时间
end
time_total=(time_move+time_load)/(Move_max+Load_max);
stacker_current_position=target_pos;
end
