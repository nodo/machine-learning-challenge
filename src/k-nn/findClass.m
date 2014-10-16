function class = findClass(X, p, k)
  m_distance = intmax;
  idx = -1;
  for i=1:rows(X)
      d = distance(X(i,1:end-2), p);
      if (d < m_distance)
         m_distance = d;
         idx = i;
      end
  end
  class = X(idx, end-1);
end

function d = distance(x1, x2)
  d = norm( x1 - x2 , 2 );
end
