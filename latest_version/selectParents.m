% 选择操作：根据适应度选择父代
function parents = selectParents(population, fitness,Huo_jia,Huo_y,Huo_z)
    % 轮盘赌选择
    totalFitness = sum(fitness);
    probabilities = fitness / totalFitness;
    cumulativeProbabilities = cumsum(probabilities);
    
    parents = zeros(size(population));
    for i = 1:size(population, 1)
        r = rand();
        for j = 1:size(population, 1)
            if r <= cumulativeProbabilities(j)
                parents(i, :, :) = population(j, :, :);
                break;
            end
        end
    end
end