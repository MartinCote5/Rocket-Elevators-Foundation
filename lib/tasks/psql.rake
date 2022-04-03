require 'pg'
require 'faker'
require 'mysql2'

# online psql database

namespace :psql do
  desc "Send out batch messages"
  task create: :environment do
    conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:password@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com/postgres?password=#{ENV["PSQL_PASSWORD"]}")
    # conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:#{ENV["PSQL_PASSWORD"]}@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com:5432/postgres")
    conn.exec( 'CREATE DATABASE martincote')
    conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:password@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com/myriam?password=#{ENV["PSQL_PASSWORD"]}")
    # conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:#{ENV["PSQL_PASSWORD"]}@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com:5432/martincote")
    create_tables conn
  end

  task send: :environment do
    conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:password@codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com/myriam?password=#{ENV["PSQL_PASSWORD"]}")
    truncate_tables(conn)
    factquotes(conn)
    factcontact(conn)
    factelevator(conn)
    dimcustomers(conn)
    factintervention(conn)
  end


  # local psql database

  # namespace :psql do
  #   desc "Send out batch messages"
  #   task create: :environment do
  #     conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:#{ENV["PSQL_PASSWORD"]}@127.0.0.1:5432/postgres")
  #     conn.exec( 'CREATE DATABASE martinlocalpostgres')
  #     conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:#{ENV["PSQL_PASSWORD"]}@127.0.0.1:5432/martinlocalpostgres")
  #     create_tables conn
  #   end

  # task send: :environment do
  #   conn = PG.connect("postgres://#{ENV['PSQL_USERNAME']}:#{ENV["PSQL_PASSWORD"]}@127.0.0.1:5432/martinlocalpostgres")
  #   truncate_tables(conn)
  #   factquotes(conn)
  #   factcontact(conn)
  #   factelevator(conn)
  #   dimcustomers(conn)
  #   factintervention(conn)
  # end



  task count: :environment do
    find_number_of_elevators_per_client
  end

  def create_tables(conn)
    conn.exec("CREATE TABLE factquotes(quote_id serial PRIMARY KEY, creation date NOT NULL, company_name text NOT NULL, email text NOT NULL, elevator_amount integer NOT NULL)")
    conn.exec("CREATE TABLE factcontact (contact_id serial PRIMARY KEY,creation_date date NOT NULL,company_name text NOT NULL,email text  NOT NULL,project_name text NOT NULL)") 
    conn.exec("CREATE TABLE factelevator (serial_number serial PRIMARY KEY,date_Of_commissioning date NOT NULL,building_id serial  NOT NULL,customer_id serial  NOT NULL,building_city text NOT NULL)")
    conn.exec("CREATE TABLE dimcustomers (id serial PRIMARY KEY, creation_date date,company_name text  NOT NULL,full_name_of_the_company_main_contact text  NOT NULL,email_of_the_company_main_contact text  NOT NULL,elevator_amount integer NOT NULL,customer_city text NOT NULL)") 
    conn.exec("CREATE TABLE factintervention (intervention_id serial PRIMARY KEY, employee_id bigint NOT NULL, building_id bigint NOT NULL, battery_id bigint, column_id bigint, elevator_id bigint, start_date_and_time_of_the_intervention timestamp NOT NULL, end_date_and_time_of_the_intervention timestamp, result text NOT NULL, report text, status_of_the_intervention text NOT NULL)")
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
          count += column.elevators.count
        end
      end
      conn.exec("INSERT INTO dimcustomers(creation_date, company_name, full_name_of_the_company_main_contact, email_of_the_company_main_contact, elevator_amount, customer_city)VALUES ('#{customer.created_at}', '#{customer.company_name.gsub(/\'/, '\'\'')}', '#{customer.full_name_of_the_company_contact.gsub(/\'/, '\'\'')}', '#{customer.email_of_the_company_contact}', #{count}, '#{city.gsub(/\'/, '\'\'')}')")
    end
  end
 
  def factintervention(conn)
    employeeTotalCount = Employee.all.count
    
    buildings = Building.all
    for building in buildings
      for building_detail in building.building_details
        if building_detail.information_Key == "status" && building_detail.value == "intervention" 
          employee_id = rand(1..employeeTotalCount)
          building_id = building.id
          start_date_and_time_of_the_intervention = Faker::Time.backward(days: 1095)
          report = Faker::GreekPhilosophers.name
          result = factintervention_result_tab()
          if result == "success"
            status_of_the_intervention = "complete"
            end_date_and_time_of_the_intervention = start_date_and_time_of_the_intervention + rand(1000000)
            conn.exec("INSERT INTO factintervention (employee_id, building_id, start_date_and_time_of_the_intervention, end_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{building_id}, '#{start_date_and_time_of_the_intervention}', '#{end_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
          elsif result == "incomplete"
            status_of_the_intervention = factintervention_status_tab()
            conn.exec("INSERT INTO factintervention (employee_id, building_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{building_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
          elsif result == "failure"
            status_of_the_intervention = "interrupted"
            conn.exec("INSERT INTO factintervention (employee_id, building_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{building_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
          end 
        end 
      end  
    end 

    batteries = Battery.all
    for battery in batteries
      if battery.status == "intervention"
        employee_id = rand(1..employeeTotalCount)
        battery_id = battery.id
        start_date_and_time_of_the_intervention = Faker::Time.backward(days: 1095)
        report = Faker::TvShows::SouthPark.quote
        result = factintervention_result_tab()
        if result == "success"
          status_of_the_intervention = "complete"
          end_date_and_time_of_the_intervention = start_date_and_time_of_the_intervention + rand(1000000)
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, start_date_and_time_of_the_intervention, end_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{battery.building_id}, #{battery_id}, '#{start_date_and_time_of_the_intervention}', '#{end_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        elsif result == "incomplete"
          status_of_the_intervention = factintervention_status_tab()
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{battery.building_id}, #{battery_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        elsif result == "failure"
          status_of_the_intervention = "interrupted"
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{battery.building_id}, #{battery_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        end 
      end 
    end 
    
    columns = Column.all
    for column in columns
      if column.status == "intervention"
        employee_id = rand(1..employeeTotalCount)
        column_id = column.id
        start_date_and_time_of_the_intervention = Faker::Time.backward(days: 1095)
        report = Faker::TvShows::DrWho.quote
        result = factintervention_result_tab()
        if result == "success"
          status_of_the_intervention = "complete"
          end_date_and_time_of_the_intervention = start_date_and_time_of_the_intervention + rand(1000000)
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, column_id, start_date_and_time_of_the_intervention, end_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{column.battery.building_id}, #{column.battery_id}, #{column_id}, '#{start_date_and_time_of_the_intervention}', '#{end_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        elsif result == "incomplete"
          status_of_the_intervention = factintervention_status_tab()
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, column_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{column.battery.building_id}, #{column.battery_id}, #{column_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        elsif result == "failure"
          status_of_the_intervention = "interrupted"
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, column_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{column.battery.building_id}, #{column.battery_id}, #{column_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        end 
      end 
    end  

    elevators = Elevator.all
    for elevator in elevators
      if elevator.status == "intervention"
        employee_id = rand(1..employeeTotalCount)
        elevator_id = elevator.id
        start_date_and_time_of_the_intervention = Faker::Time.backward(days: 1095)
        report = Faker::ChuckNorris.fact
        result = factintervention_result_tab()
        if result == "success"
          status_of_the_intervention = "complete"
          end_date_and_time_of_the_intervention = start_date_and_time_of_the_intervention + rand(1000000)
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, column_id, elevator_id, start_date_and_time_of_the_intervention, end_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{elevator.column.battery.building_id}, #{elevator.column.battery_id}, #{elevator.column_id},#{elevator_id}, '#{start_date_and_time_of_the_intervention}', '#{end_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        elsif result == "incomplete"
          status_of_the_intervention = factintervention_status_tab()
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, column_id, elevator_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{elevator.column.battery.building_id}, #{elevator.column.battery_id}, #{elevator.column_id}, #{elevator_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        elsif result == "failure"
          status_of_the_intervention = "interrupted"
          conn.exec("INSERT INTO factintervention (employee_id, building_id, battery_id, column_id, elevator_id, start_date_and_time_of_the_intervention, result, report, status_of_the_intervention)VALUES (#{employee_id}, #{elevator.column.battery.building_id}, #{elevator.column.battery_id}, #{elevator.column_id}, #{elevator_id}, '#{start_date_and_time_of_the_intervention}', '#{result}', '#{report.gsub(/\'/, '\'\'')}', '#{status_of_the_intervention}')")
        end 
      end 
    end  

  end
  
  def factintervention_result_tab
    result = rand(1..3)
    if result == 1 
      result = "success"
      return result
    elsif result == 2
      result = "failure"
      return result
    elsif result == 3
      result = "incomplete"
      return result
    end
  end

  def factintervention_status_tab
    status_of_the_intervention = rand(1..3)
    if status_of_the_intervention == 1 
      status_of_the_intervention = "pending"
      return status_of_the_intervention
    elsif status_of_the_intervention == 2
      status_of_the_intervention = "inProgress"
      return status_of_the_intervention
    elsif status_of_the_intervention == 3
      status_of_the_intervention = "resumed"
      return status_of_the_intervention
    end
  end

  def truncate_tables(conn)
    conn.exec("TRUNCATE factquotes")
    conn.exec("TRUNCATE factcontact")
    conn.exec("TRUNCATE factelevator")
    conn.exec("TRUNCATE dimcustomers")
    conn.exec("TRUNCATE factintervention")
  end
end