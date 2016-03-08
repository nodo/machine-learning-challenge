data = load('../../data/data.csv');
data = data(randperm(size(data,1)), :);

data_t   = data(:, 1:end-2);
labels_t = data(:, end-1);

% PCA
%[X_norm, mu, sigma] = featureNormalize(data_t);
%[U, S, V] = computePCA(X_norm);
%dimensions = 3;
%Z = projectData(X_norm, U, dimensions);
%scatter3(Z(:,1), Z(:,2), Z(:,3),10, labels_t);
%X_rec = recoverData(Z, U, dimensions);
%data_t = X_rec;

N_FOLD    = 10;
K_SIZE    = 30;
FOLD_SIZE = floor(size(data_t, 1) / N_FOLD);
accuracies = zeros(K_SIZE, 1);

for k=1:K_SIZE
    accuracies_folds = zeros(N_FOLD, 1);
    for f=1:N_FOLD
        validation_index = [1:FOLD_SIZE] + FOLD_SIZE*(f-1);
        training_index   = find(~ismember([1:size(data_t,1)], validation_index));

        X = data_t(training_index, :);
        y = labels_t(training_index, :);

        X_new = data_t(validation_index, :);
        y_new = labels_t(validation_index);

        % The value must be 'euclidean', 'cityblock', 'chebychev', or 'minkowski'.
        model = fitcknn(X, y, 'NumNeighbors', k, 'NSMethod','kdtree','Distance','minkowski','Exponent', 1, 'BreakTies', 'nearest', 'Standardize', true);

        predictions = predict(model, X_new);
        accuracy = sum(predictions == y_new)/length(validation_index);
        accuracies_folds(f) = accuracy;
    end
    accuracies(k) = mean(accuracies_folds);
end

plot(1:K_SIZE, accuracies);
print -dpng 'accuracies-min.png'

