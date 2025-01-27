function S_STABILITY = analyze_shelf_stability(Huo, Huo_jia, Huo_z, Huo_y, Huo_load)
    % 根据坐标确定货物所属货架
    Huo_tasks = cell(Huo_jia, 1);
    for i = 1:size(Huo, 2)
        Huo_tasks{Huo(1, i)} = [Huo_tasks{Huo(1, i)}, i];
    end
    % 计算各货架中心位置
    y_center = zeros(1, Huo_jia);
    z_center = zeros(1, Huo_jia);
    P_load = zeros(1, Huo_jia);
    for i = 1:Huo_jia
        Y_A = 0; Z_A = 0;
        Y_B = 0;
        temp = Huo_tasks{i};
        if ~isempty(temp)
            for m = 1:numel(temp)
                Y_A = Y_A + Huo(2, temp(m)) * Huo(4, temp(m));
                Y_B = Y_B + Huo(4, temp(m));
                Z_A = Z_A + Huo(3, temp(m)) * Huo(4, temp(m));
%              Z_A = Z_A + Huo(3, temp(m));
            end
            y_center(i) = Y_A / Y_B;
            z_center(i) = Z_A  / Y_B;
            P_load(i) = Y_B;
        end
    end    
    % 各货架指标得分
    I_COM = zeros(1, Huo_jia);
    I_DIST = zeros(1, Huo_jia);
    I_LOAD = zeros(1, Huo_jia);
    for i = 1:Huo_jia
        temp = Huo_tasks{i};
        if ~isempty(temp)
            I_COM(i) = z_center(i) ;
            I_DIST(i) = abs(y_center(i)-Huo_y / 2);
            I_LOAD(i) = P_load(i) / Huo_load;
        end
    end
    
    % 货架稳定性综合评价分数
    W1 =1/3;
    W2 = 1/3;
    W3 = 1/3;
%     S_STABILITY = 0.513416816 * sum(I_COM./Huo_z)/Huo_jia + 0.486583184 * sum(I_DIST/(Huo_y / 2))/Huo_jia;
 S_STABILITY =sum(I_COM./Huo_z)/Huo_jia;
end