# Rocket_Elevators_Information_System
Week 5 - Using and managing databases

## Project made by:

- Jean-Sébastien Gotty
- Gabriel Stankunas
- Myriam Amara
- Samuel Laforme
- Martin Cote

 
## Name of databases

- db/development for mysql
- rocket_elevators for postgresql


## To be able to connect to the database, our application use environments variables:
 
- `DATABASE_USERNAME` The username of mysql database
- `DATABASE_PASSWORD` The password of mysql database
- `PSQL_USERNAME` Usename to postgres database
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
 
To setup your environment variables for the project, follow theses instructions: [how to setup environment variables](https://www.twilio.com/blog/2018/01/how-to-set-environment-variables.html).

## Useful command

`rails mysql:faker` Is to fill the mysql database with fake data. Warning: it can take a while before it's finished.
`rails psql:create` Is to create the postgresql database. The command requires that the postgres database is present on the postgresql server and is required to send data to the warehouse.
`rails psql:send` Is the task that is used to fill the data warehouse with the informations inside the mysql server.



## How to use Twilio:

to test Twilio enter the following command in the terminal : 

- `rails c`

In the building tab, in the first column we already set the "technical_contact_phone_for_the_building" to your phone number in the database. Now to test it, change an elevator status to get a sms from twilio :

- `e = Elevator.find(1)` Is to set the variable "e" to the elevator of your choice, in this case we want the first one!

- `e.status = "intervention" ` Is to change the status of the elevator for the SMS condition 

- `e.save!` Is to save your change in the database, the SMS should be sent now!

## How to use Slack:

when the status of an elevator changes, a message is sent to the slack “elevator_operations” channel to leave a written record:
 
 - `e = Elevator.find(1)` Is to set the variable "e" to the elevator of your choice, in this case we want the first one!

- `e.status = "active" or "inactive" ` Is to change the status of the elevator for the message condition 

- `e.save!` Is to save your change in the database, the message should be sent!

## Here is a explanatory video of our project :



## Here is the URL of our website :
https://codeboxxmartincdomain2022.xyz
