function [time_total, stacker_current_position] = calculate_travel_time(stacker_pos, target_pos,a0,v_max,alpha,V_Z,Huo_y,Huo_z)
% ���룺�Ѷ����ǰλ�� (stacker_pos)��Ŀ��λ�� (target_pos)
%       Ŀ���������� (weight)����� (volume)�����ٶ�ʱ�䳣�� (tau)������ٶ� (v_max)

% ���㵱ǰλ����Ŀ��λ��֮��ľ���
distance = sqrt((stacker_pos(2) - target_pos(2))^2);
% ������ٺͼ��ٽ׶ε������˶�����
d_acc = v_max ^2/(4*a0);  % ���ٽ׶εľ��루��������ٶȺͼ���ʱ�䳣�����㣩
d_dec = v_max ^2/(4*a0);  % ���ٽ׶εľ��루������ٺͼ��ٹ�����ͬ��
time_acc = (log(1+(alpha*v_max)/a0))/alpha;  % ����ʱ��
% �������ٽ׶ε�ʱ��
time_cruise = (sqrt(Huo_y^2) - d_acc - d_dec) / v_max;
% ������ٽ׶ε�ʱ��
time_dec = (log(1+(alpha*v_max)/a0))/alpha;  % ����ʱ��
% ���˶�ʱ��
Move_max= time_acc + time_cruise + time_dec;
k1=1.5;
k2=2;
k3=target_pos(3)/V_Z;     % �̶�ȡ��ʱ�䣨��λ���룩
beta=1.5;
gamma=1.2;
Load_max=k1* 100^beta + k2 * 100^gamma+Huo_z/V_Z;
if distance > (d_acc + d_dec)
    % ���Ŀ�������ڼ��پ���Ӽ��پ��룬�Ѷ�����ȼ��ٵ�����ٶȣ������٣�������
    % ������ٽ׶�ʱ��
    time_acc = (log(1+(alpha*v_max)/a0))/alpha;  % ����ʱ��
    % �������ٽ׶ε�ʱ��
    time_cruise = (distance - d_acc - d_dec) / v_max;
    % ������ٽ׶ε�ʱ��
    time_dec = (log(1+(alpha*v_max)/a0))/alpha;  % ����ʱ��
    % ���˶�ʱ��
    time_move = time_acc + time_cruise + time_dec;
else
    % ���Ŀ�����С�ڼ��پ���Ӽ��پ��룬�Ѷ��ֻ����ٻ����
    % ������ٽ׶�ʱ��
    time_move = distance / v_max;  % �ڼ��ٽ׶ε��˶�ʱ��
end

time_total=time_move+abs(stacker_pos(3) - target_pos(3))./1.3;
end
