% main file for data classification challenge 2014
more off;

% initialize screen
clear ; close all; clc

% load data
all_data   = load('../../data/data.csv');
num_labels = 7;

% split data in training_set (50%), validation_set (25%) and testing_set (25%)
train      = all_data(1:2500, :);
validation = all_data(2501:3750, :);
test       = all_data(3751:end, :);


% ==== Quality ==== Can I use type as a feature?
X         = train(:, 1:end-2);
t_labels  = train(:, end-1);

V         = validation(:, 1:end-2);
v_labels  = validation(:, end-1);

T            = validation(:, 1:end-2);
test_labels  = validation(:, end-1);


feature_sets = powerset(1:columns(X)-2);
results = zeros(size(feature_sets)(2), 2);

for f_idx=2:size(feature_sets)(2)
  fprintf('Using feature index: %d\n', f_idx);
  selected_features = cell2mat(feature_sets(f_idx))

  X_tmp = X(:, selected_features);
  V_tmp = V(:, selected_features);
  T_tmp = T(:, selected_features);

  i = 1;
  validation_set_results = zeros(25, 2);
  for lambda=0:0.5:3
    [all_theta] = oneVsAll(X_tmp, t_labels, num_labels, lambda);
    pred = predictOneVsAll(all_theta, V_tmp);
    accuracy = mean(double(pred == v_labels));
    validation_set_results(i, :) = [lambda, accuracy];
    i += 1;
  end

  % pick the best model
  [acc, idx] = max(validation_set_results(:,2));
  final_lambda = validation_set_results(idx, 1);

  disp('Testing...')
  [all_theta] = oneVsAll([X_tmp; V_tmp], [t_labels; v_labels], num_labels, final_lambda);
  p = predictOneVsAll(all_theta, T_tmp);
  test_accuracy = mean(double(p == test_labels));

  results(f_idx, :) = [test_accuracy, lambda];
  fprintf('Test Accuracy (lambda = %f): %f\n', final_lambda, test_accuracy * 100);
end
