# Rocket_Elevators_Information_System
Week 7 - Life is a Web Service 

## Project made by:

- Jean-Sébastien Gotty
- Gabriel Stankunas
- Myriam Amara
- Samuel Laforme
- Martin Cote

 
## Name of databases

- Myriam for mysql
- myriam for postgresql


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

Once contact us is completed, a ticket is automatically sent to the freshdesk website.
All the Informations to access the freshdesk account are provide in slack.

## How to use the DropBox API:
When a user become a customer, the file attachement given in the contact us form is transfer in dropbox and can be seen on :
    https://www.dropbox.com/home

To do that, you have to be identified in:
    https://www.dropbox.com/developers/apps/info/dupssio1sb9bcxz

after that tap on : App console, Rocket_Elevator_h22 and Generate a new API_Key

## How to use the SndGrid API:
Each new user by filling out the contact us form, automatically receives an email from the website in their email.


## Here is a explanatory video of our project :

https://www.youtube.com/watch?v=HL3Yxvcg7C0 

## Here is the URL of our website :
https://codeboxxmartincdomain2022.xyz
