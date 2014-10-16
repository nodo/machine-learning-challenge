function X_rec = recoverData(Z, U, K)
    U_reduce = U(:, 1:K);
    X_rec = Z * U_reduce';
end