function S_convenience = analyze_turnover_and_convenience(Huo, r, Huo_jia,Huo_y,Huo_z,nGoods)
I_Tr = 0;
I_fa = 0;
for i=1:nGoods
    I_Tr =  I_Tr+ sqrt(Huo(2,i)^2)/(sqrt(Huo_y^2));
end
for i = 1:nGoods
    for j = 1:nGoods
        if i ~= j&&Huo(1,i)==Huo(1,j)
            I_fa = I_fa + r(i, j);
        end
    end
end
w4 =1/2;
w5 =1/2;
S_convenience = w4 * I_fa./(nGoods*8) + w5 * I_Tr./nGoods/2;
end