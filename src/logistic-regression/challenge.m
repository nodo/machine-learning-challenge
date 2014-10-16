% initialize screen
clear ; close all; clc

% load data
data  = load('../../data/data.csv');
train  = data(:, 1:end-2);
labels = data(:, end);

test_ids  = load('../../data/challenge.csv');
ids  = test_ids(:, 1);
test = test_ids(:, 2:end);

[m, n] = size(train);
train  = [ones(m,1) train];

[m1, n1] = size(test);
test  = [ones(m1, 1) test];

%initialize theta
initial_theta = zeros(n+1, 1);

% optimization using fminunc
options = optimset('GradObj', 'on', 'MaxIter', 500);

% found running 'main_type.m'
lambda = 0.4;

[theta, cost] = fminunc(@(t)(lrCostFunction(t, train, labels, lambda)), initial_theta, options);
p = predict(theta, test);

final = [ids p];
save ../../output/output_types.txt final
