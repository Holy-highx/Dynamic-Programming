%% Dynamic Programming 

type = 'min';                  % type of question
tn = double(type == 'max');

for k = n:-1:1                                                       % n --- num of dec stage, k --- current dec stage
    for i = 1:1:Snum{k}                                          % Snum{k} --- num of state in k dec, i --- ith state
    state_start = S{k}(i,:);                                      % ith state variable
    decision = DecF(k,state_start);                        % dec variable
    if isempty(decision)
        f{k}(i,1) =(1 - 2*tn)*1e+6;                             % no dec --> it's nearly imposibble to choose this way
        continue
    end
    state_end = TranF(k,state_start,decision);       % state trans fun 
    state_end_index = State2Index(state_end,S{k+1});
    eval(['[f_temp,index] = ', type ,'(LossF(k,decision,f{k+1}(state_end_index),state_end));']);
    f{k}(i,1) = f_temp(1);
    Strategy{k}{i} = [num2str(decision(index(1),:)),' --> ',Strategy{k+1}{state_end_index(index(1))}]; 
    end
end

f{1}
Strategy{1}