more off;
data = load('../../data/data.csv');
# data = data(randperm(size(data,1)),:);

TRAIN  = data(1:rows(data)*0.5, :);
TEST   = data(rows(data)*0.5+1:rows(data)*0.75, :);
VALID  = data(rows(data)*0.75+1:end, :);

means = mean(TRAIN(1:end-2));
variances = var(TRAIN(1:end-2));

TRAIN(:, 1:end-2) = TRAIN(:, 1:end-2) .- means;
TRAIN(:, 1:end-2) = TRAIN(:, 1:end-2) ./ variances;

TEST(:, 1:end-2) = TEST(:, 1:end-2) .- means;
TEST(:, 1:end-2) = TEST(:, 1:end-2) ./ variances;

VALID(:, 1:end-2) = VALID(:, 1:end-2) .- means;
VALID(:, 1:end-2) = VALID(:, 1:end-2) ./ variances;

K_SIZE = 20;
predictions = zeros(rows(VALID), 1);

accuracxies = zeros(1, K_SIZE);
for k = 1:K_SIZE
  k = 1
  fprintf('Using k=%d - ',k)
  predictions = predict(k,
                        TRAIN(:, 1:end-1),
                        VALID(:, 1:end-1));
  error = sum(predictions != VALID(:, end-1))/length(predictions);
  accuracies(k) = 1-error;
  fprintf('accuracy = %f\n', accuracies(k));
end

plot(1:K_SIZE, accuracies);

[m, idx] = max(accuracies);

predictions = zeros(rows(TEST), 1);
predictions = predict(idx, TRAIN(:, 1:end-1), TEST(:, 1:end-1));
error = sum(predictions != TEST(:, end-1))/length(predictions);
accuracy = 1 - error;

fprintf("Using TEST SET:\n");
fprintf("k = %d\n", idx);
fprintf("accuracy %f\n", accuracy);
