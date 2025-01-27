function [particlePosition] = IniparticleVelocity(stacker_tasks,store_tasks)
Stacker1=cell(5,1);Sore1= cell(5, 1);
Stacker2=cell(5,1);Sore2= cell(5, 1);
conditionMet = false;
for m=1:size(stacker_tasks,1)
    Stacker1{m}=stacker_tasks{m}(randperm(length(stacker_tasks{m})));
end
for m=1:size(store_tasks,1)
    Store1{m}=store_tasks{m}(randperm(length(store_tasks{m})));
end

particlePosition{1}= Stacker1;
particlePosition{2}= Store1;
end

