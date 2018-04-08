# Profit-Prediction-using-Decision-Tree-and-ROC
Using decision tree and ROC to build Big Tree, Pruned Tree, and Best Threshold Pruned tree, and FPR, FNR, Accuracy, Expected Value
# Business Background
• There are 1,000,000 customers, of which 490,000 are likely to stay another year and 510,000 are likely to leave. The carrier does not know which customer is likely to stay or leave.

• A customer that stays will provide a NPV of $1,000 to the carrier. The NPV from a customer who leaves is $0.

• The firm has three strategies:

a. Do nothing. Let the customers who are likely to leave, do so.

b. Offer every customer a discount of $400 on a new phone. A customer whowas going to stay will continue to stay and enjoy the discount. A customer who was likely to leave will now stay with a 0.50 probability. The discount is wasted on customers who end up leaving any way.

c. Construct a prediction model to predict whether a customer will leave or stay. Use the prediction model to offer the discount only to the customers who are predicted to leave. The behavior of the customers who are predicted to leave and receive a discount remains as described above.

• Consider LEAVE to be the Negative Class and STAY to be the Positive class. Denote the FPR by α and FNR by β. Find the expected value of each of the three strategies. Write the expected value of strategy (c) in the form of:v–a.α–b.βwhere a is the False Positive Cost and b is the False Negative Cost.
# Calculation Process
• Split data:

Use seed.set (3478) and split data into training data (13340 observations) and test data (6660 observations).

• Big Tree:

Use train data to build the fit model, set xval=10, cp=0, minsplit=2, then use test data to build confusion matrix, calculate false negative rate, false positive rate (leave as negative, stay as positive) and accuracy rate, results can be seen in the table in R program.

• Pruned Tree:

Keep the fit calculated above, find the best cp to minimize the xval error, the best cp is 0.002298851. Apply the best cp to post prune the decision tree, then plot this pruned tree, use test data to build the confusion matrix, find error and accuracy rate.

• Best Threshold Pruned Tree

First use predict () to predict the probability of each observation whether it will leave or stay in training data set, then use prediction () to get TP, FP rate in each leaf node. Finally use performance () and plot to show the ROC curve, through performance (... ‘auc’) we can find that the area under curve is quite good, so the model is usable. Then we build cost formula, use performance () and plot the cost curve. Through observation, we can find the best cutoff to minimize the cost. And we use predict () to build another probability data frame based on test data set, if the probability is lower than cutoff, the label is leave, otherwise is stay. The last step is to build the third confusion matrix. And we extract error rate and accuracy rate in each matrix to build a table.

Profit formula:

Cost: 400*[(1-α)*510000+β*490]

Revenue: 1000*490000+1000*(1-α)*510000*0.5
# The Tree
