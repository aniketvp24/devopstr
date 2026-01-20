#!/bin/bash    
if [ -d datasets ]; then
    :
else
    mkdir datasets
fi

URL="https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
{
    echo "sepal_length,sepal_width,petal_length,petal_width,class"
    wget -qO- $URL --no-check-certificate | grep -v '^$'
} > datasets/iris.csv

echo "Downloaded dataset from link:"
echo "$URL"

# Dataset summary
awk -F "," '
NR==1 {
	for (i = 1; i <= NF; i++) {
	    header[i] = $i
	}        
	total_cols = NF
	next
}
{
	total_rows++
	for (i = 1; i <= NF; i++) {
		if ($i == "") {
		    missing[i]++
		    total_missing++
		}
	}   
}
END {
	total_cells = total_rows * total_cols
	print "\nSummary:"
	print "Number of rows   :", total_rows
	print "Number of columns:", total_cols
	print "Total cells      :", total_cells
	print "Total missing    :", total_missing+0

	print "\nColumn wise missing:"
	for (i = 1; i <= total_cols; i++) {
		printf "%-15s %d\n", header[i], missing[i]+0
	}
}' datasets/iris.csv

echo "Splitting dataset into train and test..."
TOTAL_ROWS=$(wc -l < datasets/iris.csv)
TRAIN_ROWS=$(( (TOTAL_ROWS-1) * 80/100 ))
TEST_ROWS=$(( TOTAL_ROWS-TRAIN_ROWS-1))

HEADERS=$(head -n 1 datasets/iris.csv)
tail -n +2 datasets/iris.csv | shuf > datasets/.shuffled_iris.csv

{
	echo "$HEADERS"
	head -n $TRAIN_ROWS datasets/.shuffled_iris.csv
} > datasets/train.csv

{
	echo "$HEADERS"
	tail -n $TEST_ROWS datasets/.shuffled_iris.csv
} > datasets/test.csv

rm datasets/.shuffled_iris.csv

echo "Done! Output is saved in datasets folder."
