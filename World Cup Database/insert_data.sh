#! /bin/bash

# Set executable permissions
chmod +x insert_data.sh

# Set the PSQL variable
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Empty tables
$PSQL "TRUNCATE TABLE games, teams;"

# Insert teams
awk -F',' 'NR>1{print $3"\n"$4}' games.csv | sort -u | while read -r team; do
    $PSQL "INSERT INTO teams (name) VALUES ('$team');"
done

# Insert games
awk -F',' 'NR>1{print $1","$2","$3","$4","$5","$6","$7}' games.csv | while read -r line; do
    year=$(echo "$line" | cut -d',' -f1)
    round=$(echo "$line" | cut -d',' -f2)
    winner=$(echo "$line" | cut -d',' -f3)
    opponent=$(echo "$line" | cut -d',' -f4)
    winner_goals=$(echo "$line" | cut -d',' -f5)
    opponent_goals=$(echo "$line" | cut -d',' -f6)

    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner';")
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent';")

    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals);"
done
