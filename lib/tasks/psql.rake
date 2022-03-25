require 'pg'
require 'faker'
require 'mysql2'

namespace :psql do
  desc "Send out batch messages"
  task create: :environment do
    conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:password@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com/postgres?password=#{ENV["PSQL_PASSWORD"]}")
    conn.exec( 'CREATE DATABASE myriam')
    conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:password@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com/myriam?password=#{ENV["PSQL_PASSWORD"]}")
    create_tables conn
  end

  task send: :environment do
    conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:password@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com/myriam?password=#{ENV["PSQL_PASSWORD"]}")
    truncate_tables(conn)
    factquotes(conn)
    factcontact(conn)
    factelevator(conn)
    dimcustomers(conn)
  end

  task count: :environment do
    find_number_of_elevators_per_client
  end

  def create_tables(conn)
    conn.exec("CREATE TABLE factquotes(quote_id serial PRIMARY KEY, creation date NOT NULL, company_name text NOT NULL, email text NOT NULL, elevator_amount integer NOT NULL)")
    conn.exec("CREATE TABLE factcontact (contact_id serial PRIMARY KEY,creation_date date NOT NULL,company_name text NOT NULL,email text  NOT NULL,project_name text NOT NULL)") 
    conn.exec("CREATE TABLE factelevator (serial_number serial PRIMARY KEY,date_Of_commissioning date NOT NULL,building_id serial  NOT NULL,customer_id serial  NOT NULL,building_city text NOT NULL)")
    conn.exec("CREATE TABLE dimcustomers (id serial PRIMARY KEY, creation_date date,company_name text  NOT NULL,full_name_of_the_company_main_contact text  NOT NULL,email_of_the_company_main_contact text  NOT NULL,elevator_amount integer NOT NULL,customer_city text NOT NULL)") 
  end 

  def factquotes(conn)
    quotes = Quote.select(:id, :created_at, :company_name, :email, :elevator_amount)
    quotes.each do |quote|
      conn.exec("INSERT INTO factquotes(quote_id, creation, company_name, email, elevator_amount) VALUES(#{quote.id}, '#{quote.created_at}', '#{quote.company_name.gsub(/\'/, '\'\'')}', '#{quote.email}', #{quote.elevator_amount})")
    end
  end

  def factcontact(conn)
    leads = Lead.select(:id, :created_at, :company_name, :e_mail, :project_name)
    leads.each do |lead|
      conn.exec("INSERT INTO factcontact(contact_id, creation_date, company_name, email, project_name)VALUES (#{lead.id}, '#{lead.created_at}', '#{lead.company_name.gsub(/\'/, '\'\'')}', '#{lead.e_mail}', '#{lead.project_name}')")
    end
  end

  def factelevator(conn)
    elevators = Elevator.select(:serial_number, :date_of_commissioning, :column_id)
    elevators.each do |elevator|
      column = Column.find(elevator.column_id)
      battery = Battery.find(column.battery_id)
      building = Building.find(battery.building_id)
      address = Address.find(building.address_id)
      conn.exec("INSERT INTO factelevator(serial_number, date_Of_commissioning, building_id, customer_id, building_city)VALUES (#{elevator.serial_number}, '#{elevator.date_of_commissioning.strftime('%FT%R')}', #{building.id}, #{building.customer_id}, '#{address.city}')")
    end
  end

  def dimcustomers(conn)
    customers = Customer.all
    for customer in customers
      count = 0
      buildings = customer.building
      city = customer.address.city
      for building in buildings
        battery = building.battery
        columns = battery.columns
        for column in columns
          count += column.elevator.count
        end
      end
      conn.exec("INSERT INTO dimcustomers(creation_date, company_name, full_name_of_the_company_main_contact, email_of_the_company_main_contact, elevator_amount, customer_city)VALUES ('#{customer.created_at}', '#{customer.company_name.gsub(/\'/, '\'\'')}', '#{customer.full_name_of_the_company_contact.gsub(/\'/, '\'\'')}', '#{customer.email_of_the_company_contact}', #{count}, '#{city.gsub(/\'/, '\'\'')}')")
    end
  end
 
  def truncate_tables(conn)
    conn.exec("TRUNCATE factquotes")
    conn.exec("TRUNCATE factcontact")
    conn.exec("TRUNCATE factelevator")
    conn.exec("TRUNCATE dimcustomers")
  end
end