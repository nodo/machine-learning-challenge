# calculates F-score given numbers of true/false positives/negatives
f_score <- function(n_tp, n_tn, n_fp, n_fn) {
  if (n_tp == 0) {
    # techincally F-score can't be calculated if there are no true positives
    # in this context it is defined to be 0
    return(0)
  }
  precision <- n_tp / (n_tp + n_fp)
  recall <- n_tp / (n_tp + n_fn)
  fscore <- 2 * precision * recall / (precision + recall)
  return(fscore)
}

# calculates the F-scores and weights for all true classes
# takes in columns with matching predicted and true class labels
# returns a table with columns 'true_classes', 'fscores' and 'weights'
# 'fscores' are class-wise F-scores
# 'weights' are the number of instances in this true class
evaluate <- function(pred_class, true_class) {
  # contingency table with true labels as columns and predicted labels as rows
  c_table <- as.data.frame(table(pred_class, true_class))
  fscores <- vector()
  weights <- vector()
  true_classes <- sort(unique(true_class))
  n_all <- sum(c_table$Freq)
  for (class in true_classes) {
    # true and false positives
    pos <- c_table[c_table[,'pred_class'] == class,]
    n_tp <- sum(pos[pos[,'true_class'] == class,]$Freq)
    n_fp <- sum(pos[pos[,'true_class'] != class,]$Freq)
    # true and false negatives
    neg <- c_table[c_table[,'true_class'] == class,]
    n_fn <- sum(neg[neg[,'pred_class'] != class,]$Freq)
    n_tn <- n_all - n_tp - n_fp - n_fn
    fscores <- c(fscores, f_score(n_tp, n_tn, n_fp, n_fn))
    weights <- c(weights, sum(neg$Freq))
  }
  return(data.frame(true_classes, weights, fscores))
}

# calculates the total average F-score for the classification challenge
# the total average F-score is a weighed sum of the individual F-scores
# weights are the number of instances in the true classes
# takes in columns with matching predicted and true class labels
evaluate_all <- function(pred_types, true_types, pred_qualities, true_qualities) {
  type <- evaluate(pred_types, true_types)
  quality <- evaluate(pred_qualities, true_qualities)
  avg_fscore <- sum(type$weights * type$fscores) + sum(quality$weights * quality$fscores)
  weight <- sum(type$weights) + sum(quality$weights)
  return(avg_fscore/weight)
}
