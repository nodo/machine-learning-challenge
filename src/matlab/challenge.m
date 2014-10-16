% load data
data  = load('../../data/data.csv');
train  = data(:, 1:end-2);
labels = data(:, end-1);

test_ids  = load('../../data/challenge.csv');
ids  = test_ids(:, 1);
test = test_ids(:, 2:end);

k = 1;
model = fitcknn(train, labels, 'NumNeighbors', k, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize', true);
predictions = predict(model, test);

final = [ids predictions];
dlmwrite('../../output/output_qualities.txt',final,' ');
