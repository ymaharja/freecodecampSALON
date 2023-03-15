#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ WELCOME TO FREECODECAMP SALON~~~~~\n"
 
SERVICES(){
  echo "Here are the services we offer:"
  echo -e "\n1) Hair cut\n2) Nails \n3) Make up \n4) Facials"
  
  echo -e "\n Which service would you like:"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUSTOMER_INFO ;;
    2) CUSTOMER_INFO ;;
    3) CUSTOMER_INFO ;;
    4) CUSTOMER_INFO ;;
    *) SERVICES "Please enter a valid option." ;;
  esac

}

CUSTOMER_INFO(){
echo -e "\nPlease enter your phone Number:"
read CUSTOMER_PHONE

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

if [[ -z $CUSTOMER_ID ]]
then 
echo "Please enter your full name"
read CUSTOMER_NAME
INSERT_CUSTOMERS=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
fi

APPOINTMENT $SERVICE_ID_SELECTED
}

APPOINTMENT(){

  echo -e "\n What time would you like to set up the appointment?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED" )

  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME."

}

SERVICES
