
data       = load('../../../data/data.csv');
test_data = load('../../../data/test.csv');
train  = data(:, 1:end-2);
labels = data(:, end-1);
test      = test_data(:, 1:end-2);
qualities = test_data(:, end-1);
rows      = size(test, 1);
NUMBER_OF_MODELS = 200;
probes = NUMBER_OF_MODELS / 10;

TRY = 3;
accuracies = zeros(probes, TRY);
for t = 1:TRY
    for m = 1:probes
        forest = zeros(0,0,0);
        for model_id = 1:NUMBER_OF_MODELS

            % randomly select the number of neighbours
            k = randi([1,1]);
            number_of_features = randi([1, size(test, 2)]);
            rand_perm = randperm(size(test,2));
            features = rand_perm(1:number_of_features);

            train_m = train(:, features);
            test_m  = test(:, features);

            model = fitcknn(train_m, labels, 'NumNeighbors', k, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize', true);
            predictions = predict(model, test_m);
            forest(model_id, :, :) = predictions;
        end
        forest_predictions = zeros(size(test_data, 1),1);

        for i = 1:size(test_data, 1)
            forest_predictions(i) = mode(forest(:, i, :));
        end

        accuracy = sum(forest_predictions == qualities)/rows;
        accuracies(m, t) = accuracy;
    end
end

v = 1:probes;
v = v .* 10;
boxplot(accuracies', 'labels',v);
