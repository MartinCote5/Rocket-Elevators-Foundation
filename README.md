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

## Usefull command

`rails mysql:faker` Is to fill the mysql database with fake data. Warning: it can take a while before it's finished.
`rails psql:create` Is to create the postgresql database. The command requires that the postgres database is present on the postgresql server and is required to send data to the warehouse.
`rails psql:send` Is the task that is used to fill the data warehouse with the informations inside the mysql server.

## Here is a explanatory video of our project :

https://www.youtube.com/watch?v=6scoOEdhiXQ

## Here is the URL of our website :
https://codeboxxmartincdomain2022.xyz
