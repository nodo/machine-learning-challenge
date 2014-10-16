% Predict whether the label is 0 or 1 using learned logistic regression parameters theta
function p = predict(theta, X)
  % Number of training examples
  m = size(X, 1);
  p = zeros(m, 1);

  for i = [1:m]
    if (h(theta, X(i, :)') >= 0.5)
      p(i) = 1;
    else
      p(i) = 0;
    end
  end
end

function res = h(theta, x)
  res = sigmoid(theta'*x);
end
