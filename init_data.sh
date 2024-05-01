#!/bin/bash

# Get the current working directory
DATA_FOLDER="/tmp/data/"
DATA_FILE="data.json"

DATA="$DATA_FOLDER$DATA_FILE"
OUTPUT_FILE="/tmp/init.sql"

num_items=$(jq length "$DATA")

table="Data"

# Create the table
SQL="CREATE TABLE IF NOT EXISTS $table (
    id SERIAL PRIMARY KEY,
    shape VARCHAR(100),
    coordinates FLOAT[]
);"

echo "$SQL" >> $OUTPUT_FILE

# Iterate over the items in the JSON array and insert data into the table
for ((i = 0; i < num_items; i++)); do
    coordinates=$(jq --argjson i "$i" '.[$i].coordinates' "$DATA")
    shape=$(jq --argjson i "$i" '.[$i].shape' "$DATA" | tr -d '"')
    id=$(jq --argjson i "$i" '.[$i].id' "$DATA" | tr -d '"')
    # Construct the INSERT SQL statement and execute it
    INSERT_SQL="INSERT INTO $table (id, shape, coordinates) VALUES
    ($id, '$shape', ARRAY$coordinates::FLOAT[]);
    "
    echo $INSERT_SQL >> $OUTPUT_FILE
done