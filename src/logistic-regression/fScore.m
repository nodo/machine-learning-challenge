% calculates F-score given the labels and predictions
function fscore = fScore(labels, predictions)
  n_tp = 0;
  n_tn = 0;
  n_fp = 0;
  n_fn = 0;
  for i=1:rows(predictions)
    if (labels(i) == 1 && predictions(i) == labels(i))
      n_tp += 1;
    elseif (labels(i) == 0 && predictions(i) == labels(i))
      n_tn += 1;
    elseif (labels(i) == 1 && predictions(i) == 0)
      n_fn += 1;
    elseif (labels(i) == 0 && predictions(i) == 1)
      n_fp += 1;
    end
  end
  fscore = computeFScore(n_tp, n_tn, n_fp, n_fn);
end
