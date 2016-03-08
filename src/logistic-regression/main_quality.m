% Main file for data classification challenge 2014

% initialize screen
clear ; close all; clc

% load data
all_data   = load('../../data/data.csv');
num_labels = 7;

% split data in training_set (50%), validation_set (25%) and testing_set (25%)
train      = all_data(1:2500, :);
validation = all_data(2501:3750, :);
test       = all_data(3751:end, :);


% ==== Quality ==== 

% X contains the features
X         = train(:, 1:end-2);
t_labels  = train(:, end-1);

V         = validation(:, 1:end-2);
v_labels  = validation(:, end-1);

T            = test(:, 1:end-2);
test_labels  = test(:, end-1);

validation_set_results = zeros(50, 2);
disp("training...")
t = cputime;
i = 1;
for lambda=0:0.2:10
  [all_theta] = oneVsAll(X, t_labels, num_labels, lambda);
  pred = predictOneVsAll(all_theta, V);

  accuracy = mean(double(pred == v_labels));
  %fscore = multiClassFScore(v_labels, pred);
  validation_set_results(i, :) = [lambda, accuracy];
  i += 1;
end
printf('Total cpu time: %f seconds\n', cputime-t);

% pick the best model
[acc, idx] = max(validation_set_results(:,2));
final_lambda = validation_set_results(idx, 1);
printf('Final Lambda: %f\n', final_lambda);

disp('Testing...')
[all_theta] = oneVsAll([X; V], [t_labels; v_labels], num_labels, final_lambda);
p = predictOneVsAll(all_theta, T);


test_accuracy = mean(double(p == test_labels));
%fscore = multiClassFScore(test_labels, p);

fprintf('Test Accuracy (lambda = %f): %f\n', final_lambda, test_accuracy * 100);
%fprintf('F-Score: %f\n', fscore);

output = zeros(rows(p), 2);
for i=1:rows(p)
  output(i, :) = [i, p(i)];
end
csvwrite("output_quality.csv", output);

