% returns an array containing the indexes of the most frequent
% elements, it doens't do tiebraking
function m = majority(v)
  [order, index] = sort(v, 'descend');

  i = 2;
  result = zeros(length(v),1);
  result(1) = index(1);
  while (order(i) == order(i-1) && i < length(v))
    result(i) = index(i);
    i += 1;
  end

  m = result(result(:) != 0);
end
