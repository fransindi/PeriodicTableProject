PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
elif [[ $1 =~ [0-9]+ ]]
  then
  ELEMENT_ID=$1
  ELEMENT_NAME=$($PSQL "select name from elements where atomic_number=$ELEMENT_ID")
  ELEMENT_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$ELEMENT_ID")
  ELEMENT_TYPE=$($PSQL "select t.type from properties p join types t on p.type_id = t.type_id where atomic_number=$ELEMENT_ID")
  ELEMENT_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ELEMENT_ID")
  ELEMENT_MELT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ELEMENT_ID")
  ELEMENT_BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ELEMENT_ID")
  echo "The element with atomic number $ELEMENT_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELT celsius and a boiling point of $ELEMENT_BOIL celsius."
elif [[ $1 =~ ^[A-Z][a-z]{0,2}$ ]]
  then
  CHECK_SYMBOL=$($PSQL "select * from elements where symbol='$1'")
  if [[ $CHECK_SYMBOL ]]
    then
    ELEMENT_SYMBOL=$1
    ELEMENT_ID=$($PSQL "select atomic_number from elements where symbol='$ELEMENT_SYMBOL'")
    ELEMENT_NAME=$($PSQL "select name from elements where atomic_number=$ELEMENT_ID")
    ELEMENT_TYPE=$($PSQL "select t.type from properties p join types t on p.type_id = t.type_id where atomic_number=$ELEMENT_ID")
    ELEMENT_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ELEMENT_ID")
    ELEMENT_MELT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ELEMENT_ID")
    ELEMENT_BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ELEMENT_ID")
    echo "The element with atomic number $ELEMENT_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELT celsius and a boiling point of $ELEMENT_BOIL celsius."
  fi
elif [[ $1 =~ [a-zA-Z]* ]]
then
  CHECK_NAME=$($PSQL "select * from elements where name = '$1'")
  if [[ $CHECK_NAME ]]
  then
    ELEMENT_NAME=$1
    ELEMENT_ID=$($PSQL "select atomic_number from elements where name='$ELEMENT_NAME'")
    ELEMENT_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$ELEMENT_ID")
    ELEMENT_TYPE=$($PSQL "select t.type from properties p join types t on p.type_id = t.type_id where atomic_number=$ELEMENT_ID")
    ELEMENT_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ELEMENT_ID")
    ELEMENT_MELT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ELEMENT_ID")
    ELEMENT_BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ELEMENT_ID")
    echo "The element with atomic number $ELEMENT_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELT celsius and a boiling point of $ELEMENT_BOIL celsius."
  else
  echo 'I could not find that element in the database.'
  fi
fi