function [sensitivity, specificity] = sensitivity_specificity(TruePositive, FalsePositive, TrueNegative, FalseNegative)

sensitivity = TruePositive / (TruePositive + FalseNegative);
specificity = TrueNegative / (TrueNegative + FalsePositive);

end