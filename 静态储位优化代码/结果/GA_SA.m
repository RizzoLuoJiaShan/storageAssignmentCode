clear all;
close all;
clc
load T-GA-SA.mat
figure;plot( bestScore_idx(1:end),bestScore(1:end),'ro-','linewidth',1)
hold on
load N-GA-SA.mat
plot( bestScore_idx(1:end),bestScore(1:end),'bo-','linewidth',1)
legend('T-GA-SA','N-GA-SA')
grid on
axis([0 20000 0 1])