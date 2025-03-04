% 数据输入（任务名称、任务结束时间、任务开始时间）
tasks1 = {'出发点到货2', '取货2', '出发点到货19', '取货19', '送货15', '货15到8', '取货8', '送货8', '回缓存区', '送货18', '回缓存区', '送货7', '回缓存区', '送货14', '回缓存区'};
end_times1 = [3.466455347, 6.932910693, 10.740603, 16.24551989, 21.75043677, 23.25043677, 27.05812908, 28.82735985, 30.59659062, 33.63505216, 36.67351369, 41.40919981, 46.14488593, 52.14980281, 58.1547197];

tasks2 = {'出发到货1', '取货1', '送货1', '货1到货11', '取货11', '等待货3', '送货3', '回缓存区', '等待货4', '送货4', '回缓存区', '等待货9', '送货9', '回缓存区'};
end_times2 = [3.807692308, 7.615384615, 11.92307692, 13.96157692, 17.42803227, 30.14001369, 34.87569981, 39.61138593, 50.96245666, 55.03937973, 59.11630281, 69.0492135, 70.81844427, 72.58767504];

tasks3 = {'出发到货5', '取货5', '送货5', '货5到货16', '取货16', '送货16', '货16到货12', '取货12', '出发到货17', '取货17', '出发到货4', '取货4', '出发到货20', '取货20', '出发到货9', '取货9'};
end_times3 = [3.966455347, 7.932910693, 12.93782758, 14.43782758, 20.94274446, 23.481206, 27.947706, 33.41416135, 38.38061669, 43.34707204, 47.15476435, 50.96245666, 55.428912, 59.89536735, 64.47229043, 69.0492135];

tasks4 = {'出发到货6', '取货6', '出发到货15', '取货15', '送货13', '货13到货18', '取货18', '等待货10', '送货10', '回缓存区', '送货11', '回缓存区', '送货2', '回缓存区'};
end_times4 = [1.769230769, 3.538461538, 7.346153846, 11.15384615, 24.15384615, 26.85104615, 29.62027692, 39.61138593, 43.688309, 47.76523208, 51.07292439, 54.38061669, 60.38553358, 66.39045046];

tasks5 = {'出发到货7', '取货7', '送货6', '货6到货13', '取货13', '送货19', '货19到货3', '取货3', '出发到货10', '取货10', '出发到货14', '取货14', '送货17', '回缓存区', '送货20', '回缓存区'};
end_times5 = [5.466455347, 10.93291069, 12.70214146, 14.20214146, 17.66859681, 23.90428292, 27.37078292, 30.14001369, 34.87569981, 39.61138593, 42.14984746, 44.688309, 47.72677054, 50.76523208, 55.73168743, 60.69814277];

% 假设开始时间为前一个任务结束时间
start_times1 = [0, cumsum(diff([0, end_times1(1:end-1)]))];
start_times2 = [0, cumsum(diff([0, end_times2(1:end-1)]))];
start_times3 = [0, cumsum(diff([0, end_times3(1:end-1)]))];
start_times4 = [0, cumsum(diff([0, end_times4(1:end-1)]))];
start_times5 = [0, cumsum(diff([0, end_times5(1:end-1)]))];

% 绘制甘特图
figure;

% 绘制每个堆垛机的任务横线
hold on;

% 设置间隔
interval = 0.4; % 每个任务之间的间隔

% 堆垛机1
y_offset1 = 1; % 堆垛机1的起始纵坐标
for i = 1:length(tasks1)
    plot([start_times1(i), end_times1(i)], [y_offset1, y_offset1], 'LineWidth', 6, 'Color', [0 0 1]); % 横线表示任务
    y_offset1 = y_offset1 + interval; % 增加任务间隔
end

% 堆垛机2
y_offset2 = 11; % 堆垛机2的起始纵坐标
for i = 1:length(tasks2)
    plot([start_times2(i), end_times2(i)], [y_offset2, y_offset2], 'LineWidth', 6, 'Color', [0 1 0]); % 横线表示任务
    y_offset2 = y_offset2 + interval; % 增加任务间隔
end

% 堆垛机3
y_offset3 = 21; % 堆垛机3的起始纵坐标
for i = 1:length(tasks3)
    plot([start_times3(i), end_times3(i)], [y_offset3, y_offset3], 'LineWidth', 6, 'Color', [1 0 0]); % 横线表示任务
    y_offset3 = y_offset3 + interval; % 增加任务间隔
end

% 堆垛机4
y_offset4 = 31; % 堆垛机4的起始纵坐标
for i = 1:length(tasks4)
    plot([start_times4(i), end_times4(i)], [y_offset4, y_offset4], 'LineWidth', 6, 'Color', [1 0.5 0]); % 横线表示任务
    y_offset4 = y_offset4 + interval; % 增加任务间隔
end

% 堆垛机5
y_offset5 = 41; % 堆垛机5的起始纵坐标
for i = 1:length(tasks5)
    plot([start_times5(i), end_times5(i)], [y_offset5, y_offset5], 'LineWidth', 6, 'Color', [0.5 0 0.5]); % 横线表示任务
    y_offset5 = y_offset5 + interval; % 增加任务间隔
end

% 设置图表属性
yticks(1:10:41);
yticklabels({'堆垛机1', '堆垛机2', '堆垛机3', '堆垛机4', '堆垛机5'});
xlabel('时间');
title('堆垛机工作流程甘特图');

% 调整坐标轴，确保任务横线清晰可见
xlim([0, max([end_times1, end_times2, end_times3, end_times4, end_times5]) + 10]);
hold off;
axis tight