# Instructions

## Part 1: Fix the database

There are some mistakes in the database that need to be fixed or changed. See the user stories below for what to change.

## Part 2: Create your git repository

You need to make a small bash program. The code needs to be version controlled with git, so you will need to turn the suggested folder into a git repository.

## Part 3: Create the script

Lastly, you need to make a script that accepts an argument in the form of an atomic number, symbol, or name of an element and outputs some information about the given element. In your script, you can create a PSQL variable for querying the database like this: 

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
