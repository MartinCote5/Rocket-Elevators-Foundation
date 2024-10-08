# Rocket_Elevators_Information_System
Week 9 - Consolidation



## This week project made by:
- Martin Cote

## Whole Project made by:

- Jean-Sébastien Gotty
- Gabriel Stankunas
- Myriam Amara
- Samuel Laforme
- Martin Cote

 
## Name of databases

- MartinCote for mysql
- martin for postgresql


## To be able to connect to the database, our application use environments variables:
 
- `DATABASE_USERNAME` The username of mysql database
- `DATABASE_PASSWORD` The password of mysql database
- `PSQL_USERNAME` Username to postgres database
- `PSQL_PASSWORD` Password to postgres database
- `DROPBOX_KEY` Dropbox api key
- `AWS_REGION` Region of the aws account
- `AWS_ACCESS_KEY_ID` Key id for the aws account
- `AWS_SECRET_ACCESS_KEY` Secret access key for the aws account
- `SENDGRID_API_KEY` Key for sengrid
- `GOOGLE_MAP` Key for the google map api
- `TWILIO_ACCOUNT_SID` Key for the twilio api 
- `SLACK_WEBHOOK` Key for the slack api
- `FRESHDESK_API_KEY` Key for the freshdesk api
 
## Freshdesk connection website information 
- first go to the https://rocketelevators-supportdesk.freshdesk.com/support/home
- then click on Login on the top right corner
- email address : martin.cote2@hotmail.com
- password : avion012



## Useful command

- `rails mysql:faker` Is to fill the mysql database with fake data. Warning: it can take a while before it's finished.
- `rails psql:create` Is to create the postgresql database. The command requires that the postgres database is present on the postgresql server and is required to send data to the warehouse.
- `rails psql:send` Is the task that is used to fill the data warehouse with the informations inside the mysql server.



## How to use Twilio:

To test Twilio enter the following command in the terminal : 

- `rails c`

In the building tab, in the first column we already set the "technical_contact_phone_for_the_building" to your phone number in the database. Now to test it, change an elevator status to get a sms from twilio :

- `e = Elevator.find(1)` Is to set the variable "e" to the elevator of your choice, in this case we want the first one!

- `e.status = "intervention" ` Is to change the status of the elevator for the SMS condition 

- `e.save!` Is to save your change in the database, the SMS should be sent now!


## How to use the Slack API:

To test the slack API enter the following command in the terminal : 

- `rails c`

Now change an elevator status to get a message in the chanel elevator_operations on slack :

- `e = Elevator.find(1)` Is to set the variable "e" to the elevator of your choice. You can take a number between 1 and 391.

- `e.status` Is to look at the current status of the elevator.

- `e.status = "intervention", "active", "inactive" ` Those are the the possible status of each elevator. You can choose any of those to change the  current status.

- `e.save!` Is to save your change in the database, the message in the right slack channel should be sent now!

## How to use the FreshDesk API:

Once either the contact us, quote or intervention section is completed, a ticket is automatically sent to the freshdesk website.
All the Informations to access the freshdesk account are provide in slack.



## How to use the DropBox API:
When a user become a customer, the file attachement given in the contact us form is transfer in dropbox and can be seen on :
    https://www.dropbox.com/home

To do that, you have to be identified in:
    https://www.dropbox.com/developers/apps/info/dupssio1sb9bcxz

after that tap on : App console, Rocket_Elevator_h22 and Generate a new API_Key

## How to use the SendGrid API:
Each new user by filling out the contact us form, automatically receives an email from the website in their email.




## OTHER REPOSITORY:

-My repository with my work on the REST API containing the code for the 3 acces point :

-https://github.com/MartinCote5/RocketElevatorRestApi/tree/main



-a collection for postman to test my 3 get and put request : 

-https://www.postman.com/collections/5d3f43a20db118ff8e78




## Here is a explanatory video of our project :

-https://youtu.be/Mw0LUl3LTfQ

## Here is the URL of our website :
-https://codeboxxmartincdomain2022.xyz
