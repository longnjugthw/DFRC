%% NARMA-10 Benchmark Task
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

clear
close all

loop = 10;
train_err = zeros(5,loop);
test_err = zeros(5,loop);

rng(1,'twister');

t1 = [2,5,10,15,30];
for j = 1:5

for i = 1:loop
%% Setup
sequenceLength = 2000;
memoryLength = 10;
nodes = 30;
theta = 0.06;
config.memoryLength = '{10,5}'; %[0,0.5]

[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);

%% Time-multiplexing

config.masking_type = 'Random Mask';  % select between 'Sample and Hold','Binary Mask','Random Mask'
[system_inputSequence] = TimeMultiplexing(inputSequence,nodes,sequenceLength,theta,config);

%% Run Mackey-Glass in Simulink

TFinal = theta * sequenceLength * nodes;
coupling = 2;
decay_rate = 1;
n = 9.65; % Nonlinearity
config.connect_type = num2str(t1(j)); % Connectivity: '30','15','10','5','2'
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config);

%% Training --- ridge regression Wout = BA'(AA'-λI)^-1 / pseudo-inverse Wout = B * pinv(A)

[output_weights,system_train_output_sequence,target_train_output_sequence,system_test_output_sequence,...
    target_test_output_sequence] = train_test(state_matrix, outputSequence, sequenceLength, nodes);

%% Evaluation

config.err_type = 'NRMSE';
    train_error = calculateError(system_train_output_sequence,target_train_output_sequence,config);
    test_error = calculateError(system_test_output_sequence,target_test_output_sequence,config);
    
    train_err(j,i) = train_error;
    test_err(j,i) = test_error;
%% Demultiplexing

% config.plot_type = 'test set';
% [target_plot,system_plot] = demultiplexing(system_train_output_sequence,target_train_output_sequence,...
%     system_test_output_sequence,target_test_output_sequence,config);

%% Plot

% plot(target_plot(850:950),'r');
% hold on;
% plot(system_plot(850:950),'b--')
% 
% xlabel('t')
% ylabel('x(t)')
% legend('target output','system output')


end
end
save '1.mat' test_error

% x1 = train_error';
% x2 = test_error';
% boxplot([x1,x2],'Notch','on','Labels',{'mu = 5','mu = 6'})