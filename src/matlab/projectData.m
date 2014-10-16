function Z = projectData(X, U, K)
    U_reduce = U(:, 1:K);
    Z = X * U_reduce;
end