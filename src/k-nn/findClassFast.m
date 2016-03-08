% assume that last column of X is the label
function class = findClassFast(X, p, k)
  for i=1:length(p)
    X(:, i) = X(:, i) - p(i);
  end

  N = sqrt(sum(abs(X(:, 1:end-1)).^2,2));
  [ordered, index] = sort(N);

  counters = zeros(7,1);
  for i=1:k
    counters(X(index(i), end)) += 1;
   end

  #  maj = majority(counters);
  [sorted_counters, index_counters] = sort(counters, 'descend');
  if (sorted_counters(1) > sorted_counters(2))
     class = index_counters(1);
  else
    # random tie-breaking
    maj = majority(counters);
    class = maj(randperm(length(maj)))(1);

  # most frequent element, 'mode' choses the smallest as tie-breaker
  # ix(1) == mode(X(index(1:k), end));
  end
end

