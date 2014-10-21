function [sensibility, specificity] = sensitivity_specificity(TruePositive, FalsePositive, TrueNegative, FalseNegative)

sensibility = TruePositive / (TruePositive + FalseNegative);
specificity = TrueNegative / (TrueNegative + FalsePositive);

end