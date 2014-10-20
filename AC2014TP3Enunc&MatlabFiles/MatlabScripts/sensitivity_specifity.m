function [sensibility, specificity] = sensitivity_specifity(TruePositive, FalsePositive, TrueNegative, FalseNegative)

sensibility = TruePositive / (TruePositive + FalseNegative);
specificity = TrueNegative / (TrueNegative + FalsePositive);

end