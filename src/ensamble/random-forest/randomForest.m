
data       = load('../../../data/data.csv');
test_data = load('../../../data/test.csv');
train  = data(:, 1:end-2);
labels = data(:, end-1);
test      = test_data(:, 1:end-2);
qualities = test_data(:, end-1);
rows      = size(test, 1);
NUMBER_OF_MODELS = 10;

forest = zeros(0,0,0);
for model_id = 1:NUMBER_OF_MODELS

    % randomly select the number of neighbours
    k = randi([1,10]);
    model = fitcknn(train, labels, 'NumNeighbors', k, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize', true);
    predictions = predict(model, test);
    forest(model_id, :, :) = predictions;
end

forest_predictions = zeros(size(test_data, 1),1);
for i = 1:size(test_data, 1)
    forest_predictions(i) = mode(forest(:, i, :));
end

accuracy = sum(forest_predictions == qualities)/rows

