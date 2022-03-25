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
 
To setup your environment variables for the project, follow theses instructions: [how to setup environment variables](https://www.twilio.com/blog/2018/01/how-to-set-environment-variables.html).

## Useful command

`rails mysql:faker` Is to fill the mysql database with fake data. Warning: it can take a while before it's finished.
`rails psql:create` Is to create the postgresql database. The command requires that the postgres database is present on the postgresql server and is required to send data to the warehouse.
`rails psql:send` Is the task that is used to fill the data warehouse with the informations inside the mysql server.





## How to use Twilio:

to test Twilio enter the following command in the terminal : 

- `rails c`

First set your phone number to a "technical_contact_phone_for_the_building" column in the Building tab with these command :

- `b = Building.find(1)` Is to set the variable "b" to the building of your choice with the number in parenthesis 
 
- `b.technical_contact_phone_for_the_building = "enter_your_phone_number_here"` Is the set your phone number to the desired building in the right column.

- `b.save!` Is to save your change in the database



Now change an elevator status to get a sms from twilio :

- `e = Elevator.find(1)` Is to set the variable "e" to the elevator of your choice, make sure to set the right number according to the "id" of the building. the next step is optional but it is a way to verify it

- `e.column.battery.building` Is to look at  which building the elevator is owned, the "id" number should match your "b" variable find parenthesis

- `e.status = "intervention" ` Is to change the status of the elevator for the SMS condition 

- `e.save!` Is to save your change in the database, the SMS should be sent now!






## Here is a explanatory video of our project :

https://www.youtube.com/watch?v=6scoOEdhiXQ

## Here is the URL of our website :
https://codeboxxmartincdomain2022.xyz
