% Main file for data classification challenge 2014

% initialize screen
clear ; close all; clc

% load data
all_data   = load('../../data/data.csv');

% split data in training_set (50%), validation_set (25%) and testing_set (25%)
train      = all_data(1:2500, :);
validation = all_data(2501:3750, :);
test       = all_data(3751:end, :);


% ==== Red and Whites ====

% X contains the features
X         = train(:, 1:end-2);
t_labels  = train(:, end);

V         = validation(:, 1:end-2);
v_labels  = validation(:, end);

T            = test(:, 1:end-2);
test_labels  = test(:, end);

% Add intercept term to X, V and T
[m, n]   = size(X);
X        = [ones(m,1) X];

[m1, n1] = size(V);
V        = [ones(m1,1) V];

[m2, n2] = size(T);
T        = [ones(m2,1) T];

% initialize theta
initial_theta = zeros(n+1, 1);

% optimization using fminunc
options = optimset('GradObj', 'on', 'MaxIter', 100);

validation_set_results = zeros(25, 2);
i = 1;

% try different models (in this case different values for lambda) and check the performance
% using the validation set.
disp('Training...')
for lambda=0:0.2:5
  [theta, cost] = fminunc(@(t)(lrCostFunction(t, X, t_labels, lambda)), initial_theta, options);
  p = predict(theta, V);

  accuracy = mean(double(p == v_labels));
  fscore = fScore(v_labels, p);
  validation_set_results(i, :) = [lambda, fscore];

  i += 1;
end

% pick the best model
[acc, idx] = max(validation_set_results(:,2));
final_lambda = validation_set_results(idx, 1);

disp('Testing...')
% check how the model generalize using the testing set
[theta, cost] = fminunc(@(t)(lrCostFunction(t, [X; V], [t_labels; v_labels], final_lambda)), initial_theta, options);
p = predict(theta, T);
test_accuracy = mean(double(p == test_labels));

fscore = fScore(test_labels, p);
fprintf('Test Accuracy (lambda = %f): %f\n', final_lambda, test_accuracy * 100);
fprintf('F-Score: %f\n', fscore);

output = zeros(rows(p), 2);
for i=1:rows(p)
  output(i, :) = [i, p(i)];
end
csvwrite("output_type.csv", output);
