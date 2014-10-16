# Predict the type of the wine

The task is predicting the type of the wine: White (label 0) or Red (label 1). Visualizing the data using dimensionality reduction is possible to see that the two classes are easily separable.

<div style="text-align:center">
<img src="misc/types.png" width="400"></img>
</div>


In order to predict the type of the wine using  logistic regression use the following command:
	
	cd src/logistic-regression
    octave main_type.m

In this case the accuracy is pretty high (99.1% with cross validation). The approach is to run a cross validation with different values for lambda (the regularization term) and pick the best model.

# Predict they quality

This task is about predicting the quality of wine using a scale between 1 and 7. Visualizing the data in 3d shows how much more complex this task is:

<div style="text-align:center">
<img src="misc/qualities.png" width="400"></img>
</div>


## Logistic regression

Using logistic regression does not lead to good results. In order to run the logistic regression with a one vs all classifier use the following command:
	
	cd src/logistic-regression
	octave main_quality.m
	
It is also possible to do an exaustive feature selection. It takes a lot of time and it doesn't lead to significant improvement. In order to use it run:

	cd src/logistic-regression
	octave main_quality_fs.m
	
## Matlab K-NN

You can find the a matlab program that classifies the quality of wines in the "matlab" folder. The code uses a manual cross validation; the crucial line is:

	model = fitcknn(X, y, 
	               'NumNeighbors', k, 
	               'NSMethod','kdtree',
	               'Distance','minkowski',
	               'BreakTies', 'nearest', 
	               'Standardize', true);
	               
You can find more information about this model here:

[http://www.mathworks.se/help/stats/fitcknn.html](http://www.mathworks.se/help/stats/fitcknn.html)

In order to run the code you have to execute with matlab:

	matlabknn.m

The program tries a lot of values of "k" and outputs the chart of the accuracies, which should be something like this:

<div style="text-align:center">
<img src="misc/accuracies.png" width="400"></img>
</div>

## K-NN

This is my version of the K-NN classifier in octave, it utilizes a nice vectorization strategy to compute the euclidean distance between points.

The tie-breaking is done either random or using the smallest value.

In order to run it, it necessary to use the following commands:

	cd src/k-nn
	octave k-nn.m

## PCA

In the matlab folder it is possible to find the implementation of PCA, the following snippet of code shows how to use it:

	% Normalize the training set
	[X_norm, mu, sigma] = featureNormalize(data_t);

	[U, S, V] = computePCA(X_norm);

	dimensions = 3;
	Z     = projectData(X_norm, U, dimensions);
	X_rec = recoverData(Z, U, dimensions);

