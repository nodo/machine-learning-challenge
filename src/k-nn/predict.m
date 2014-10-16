function pred = predict(k, dataset, test_set)
  pred = zeros(rows(test_set), 1);
  for i=1:rows(test_set)
    pred(i) = findClassFast(dataset, test_set(i, 1:end-1), k);
  end
end
