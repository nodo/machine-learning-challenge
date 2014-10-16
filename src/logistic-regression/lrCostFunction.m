%Compute cost and gradient for logistic regression with regularization
function [J, grad] = lrCostFunction(theta, X, y, lambda)
  % number of training examples
  m = length(y);

  % initialize cost and gradient
  J = 0;
  grad = zeros(size(theta));

  elements = sigmoid(X * theta);
  J = sum(-y .* log(elements) .- (1.-y) .* log( 1 .- elements))/m;

  squares = sum(theta(2:length(theta)) .^ 2);
  J += lambda / (2*m) * squares;

  grad = 1/m * X' * (elements .- y);
  temp = theta;
  temp(1) = 0;
  grad = grad .+ (lambda/m .* temp);
end

