import os
import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import OneHotEncoder
from sklearn import preprocessing
from sklearn.metrics import f1_score

home_folder = os.path.expanduser("~")  # Data saved in home directory
data_filename = os.path.join(home_folder, "crimes_city_of_london_with_ic.csv")

# Reads only the following features from the csv file
features = pd.read_csv(data_filename, usecols=["crime_type", "number_ss_outcome_suspect_arrested",
                                              "number_ss_outcome_offender_given_drugs_possession_warning",
                                              "number_ss_outcome_suspect_summonsed_to_court", "number_poi"])

# Reads the labels column that should be predicted
labels = pd.read_csv(data_filename, usecols=["outcome_type"])

# Splits the features and labels datasets into train and test data sets
X_train, X_test, y_train, y_test = train_test_split(features, labels, random_state=14)

# Creates a random forest as a classifier
clf = RandomForestClassifier(random_state=14)

# For encoding the categorical crime_type feature and outcome_type labels into numbers
crime_type_encoder = LabelEncoder()
lb = preprocessing.LabelBinarizer()

# Transforming outcome_types into numbers for training and test datasets
labels_new_train = lb.fit_transform(y_train["outcome_type"].values)
labels_new_test = lb.fit_transform(y_test["outcome_type"].values)



# Transfoming crime_types into numbers in training and test datasets
crime_type_encoder.fit(X_train["crime_type"].values)
crime_type_train = crime_type_encoder.transform(X_train["crime_type"].values)
crime_type_test = crime_type_encoder.transform(X_test["crime_type"].values)

# Reshaping the encoded crime_types in training and test datasets as a preparation for next step
crime_type_reshaped = crime_type_train.reshape(16246, 1)
crime_type_test_reshaped = crime_type_test.reshape(5416, 1)

# Encodes categorical integer crime_types using a one-hot aka one-of-K scheme
# It transforms the m m possible crime_types into m binary features, with only one set pro sample.
onehot = OneHotEncoder()
crime_type_train_expanded = onehot.fit_transform(crime_type_reshaped).todense()
crime_type_test_expanded = onehot.fit_transform(crime_type_test_reshaped).todense()

# Fetches and prepares the other features from the training dataset to be merged with the encoded crime_type features
number_poi_train = X_train["number_poi"].values
number_poi_train = number_poi_train.reshape(16246, 1)
number_ss_outcome_offender_given_drugs_possession_warning_train = X_train[
    "number_ss_outcome_offender_given_drugs_possession_warning"].values
number_ss_outcome_offender_given_drugs_possession_warning_train = number_ss_outcome_offender_given_drugs_possession_warning_train.reshape(
    16246, 1)
number_ss_outcome_suspect_arrested_train = X_train["number_ss_outcome_suspect_arrested"].values
number_ss_outcome_suspect_arrested_train = number_ss_outcome_suspect_arrested_train.reshape(16246, 1)
number_ss_outcome_suspect_summonsed_to_court_train = X_train["number_ss_outcome_suspect_summonsed_to_court"].values
number_ss_outcome_suspect_summonsed_to_court_train = number_ss_outcome_suspect_summonsed_to_court_train.reshape(16246,
                                                                                                                1)
# Fetches and prepares the other features from the test dataset to be merged with the encoded crime_type features
number_poi_test = X_test["number_poi"].values
number_poi_test = number_poi_test.reshape(5416, 1)
number_ss_outcome_offender_given_drugs_possession_warning_test = X_test[
    "number_ss_outcome_offender_given_drugs_possession_warning"].values
number_ss_outcome_offender_given_drugs_possession_warning_test = number_ss_outcome_offender_given_drugs_possession_warning_test.reshape(
    5416, 1)
number_ss_outcome_suspect_arrested_test = X_test["number_ss_outcome_suspect_arrested"].values
number_ss_outcome_suspect_arrested_test = number_ss_outcome_suspect_arrested_test.reshape(5416, 1)
number_ss_outcome_suspect_summonsed_to_court_test = X_test["number_ss_outcome_suspect_summonsed_to_court"].values
number_ss_outcome_suspect_summonsed_to_court_test = number_ss_outcome_suspect_summonsed_to_court_test.reshape(5416, 1)


# concatenates the encoded crime_type features with the other fetched features horizontally for training data set
final_train = np.hstack(
    [crime_type_train_expanded, number_poi_train, number_ss_outcome_offender_given_drugs_possession_warning_train,
     number_ss_outcome_suspect_summonsed_to_court_train])  # (21750,16)

# fits the random forest again for (as I couldn't access the fitted tree after after cross validation)
clf.fit(final_train, labels_new_train)

# i) fits the random forest using the train dataset ii) validates it by cross validation and iii) prints the average score
scores = cross_val_score(clf, final_train, labels_new_train, scoring='accuracy')
print("Accuracy of training data: {0:.1f}%".format(np.mean(scores) * 100))


# concatenates the encoded crime_type features with the other fetched features horizontally for test data set
final_test = np.hstack(
    [crime_type_test_expanded, number_poi_test, number_ss_outcome_offender_given_drugs_possession_warning_test,
     number_ss_outcome_suspect_summonsed_to_court_test])

# i) predicts the test set using the trained random forest ii) prints the accuracy of the prediction iii)
y_predicted = clf.predict(final_test)
y_accurancy = np.mean(labels_new_test == y_predicted) * 100
print("Accuracy of test data: {0:.1f}%".format(y_accurancy))

print('Weighted F1-score ' + str(f1_score(y_predicted, labels_new_test,
                                          average='weighted')))  # Calculate metrics globally by counting the total true positives, false negatives and false positives.


# from sklearn import tree
# zaehler = 0
# for baum in clf.estimators_:
#     zaehler += 1
#     tree.export_graphviz(baum, out_file='/home/aser/Documents/tree'+str(zaehler)+'.dot')
