# PostGresQuadTreeData

### Summary
The intended purpose of this repo is to create a docker container with a postgresql database. The database will hold "boundaries" made up of 3 attributes(shape, coordinates, id)

### Files/Directories Structure

#### "data" Directory
- Holds json files that holds "boundaries" to be put into the database

#### Dockerfile
- Creates a postgresql data using postgres:latest as the image base
- Copies data.json from data directory into image
- Runs init_data.sh script to initialize database with the data held in data.json 



