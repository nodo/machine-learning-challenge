data = load('../../data/data.csv');

train        = data(1:3750, 1:end-2);
train_labels = data(1:3750, end-1);

test        = data(3751:end, 1:end-2);
test_labels = data(3751:end, end-1);

means = mean(train);
variances = var(train);

train = train .- means;
train = train ./ variances;

test = test .- means;
test = test ./ variances;

model = fitcknn(train, train_labels, 'NumNeighbors', 10);
rloss = resubLoss(model);

rloss


