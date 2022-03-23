require 'net/http'
require 'excon'
require 'json'

namespace :mysql do
  desc "TODO"
  task faker: :environment do
    user_gen
    quote_gen
    lead_gen
    customer_gen
    building_gen
  end

  desc "Ask api to send back long/lat"
  task coordonate: :environment do
    addresses = Address.first
    #for address in addresses
    response = HTTParty.post('https://rocketelevator.me/building', body: {address: addresses.number_and_street, city: addresses.city})
    p JSON.parse(response.body)
    #end
  end

  def user_gen
    for i in 0..200
        email = rand(100) < 75 ? Faker::Internet.unique.free_email : Faker::Internet.unique.email
        role = rand(100) < 95 ? "user" : "employee"

        date = Faker::Date.backward(days:1095)
        User.create!(email: email, password: "Codeboxx1!", role: role, created_at: date, updated_at: date)
        if role == "employee"
            user_id = i + 12
            Employee.create!(user_id: user_id, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, title: Faker::Military.army_rank, created_at: date, updated_at: date )
        end
        #p "Generating a user"
    end
  end

  def quote_gen
    Quote.destroy_all
    for i in 0..rand(800..1200)
        date = Faker::Date.backward(days:1095)
        nbr_floors = rand(2..100)
        case rand(1..4)
        when 1
          Quote.create!(buildingType: 1, number_of_floors: nbr_floors, number_of_basements: rand(0..4), number_of_apartments: (rand(2..10) * nbr_floors), range: rand(1..3), elevator_amount: rand(1..100), created_at: date, updated_at: date, company_name: Faker::Company.name, email: Faker::Internet.unique.email)
        when 2
            Quote.create!(buildingType: 2, number_of_floors: nbr_floors, number_of_basements: rand(0..20), number_of_parking_spots: rand(1000..5000), elevator_amount: rand(1..100), number_of_companies: rand(1..69), range: rand(1..3), created_at: date, updated_at: date, company_name: Faker::Company.name, email: Faker::Internet.unique.email)
        when 3
            Quote.create!(buildingType: 3, number_of_floors: nbr_floors, number_of_basements: rand(0..20), number_of_parking_spots: rand(1000..5000), maximum_occupancy: rand(5000..25000), number_of_corporations: rand(5..50), range: rand(1..3), elevator_amount: rand(1..100), created_at: date, updated_at: date, company_name: Faker::Company.name, email: Faker::Internet.unique.email)
        when 4
            Quote.create!(buildingType: 4, number_of_floors: nbr_floors, number_of_basements: rand(0..20), number_of_parking_spots: rand(1000..5000), number_of_companies: rand(1..69), maximum_occupancy: rand(5000..25000), number_of_corporations: rand(5..50),elevator_amount: rand(1..100), business_hours: rand(6..21), range: rand(1..3), created_at: date, updated_at: date, company_name: Faker::Company.name, email: Faker::Internet.unique.email)
        end
        #p "Generating a quote"
    end
  end

  def lead_gen
    for i in 0..rand(500..900)
      date = Faker::Date.backward(days:1095)    
      Lead.create!(
        full_name_of_the_contact: Faker::Name.unique.name,
        company_name: Faker::Company.unique.name,
        e_mail: Faker::Internet.email,
        phone: Faker::PhoneNumber.cell_phone,
        project_name: Faker::Ancient.hero,
        project_description: Faker::Quote.yoda,
        department_in_charge_of_the_elevators: Faker::Commerce.department,
        message: Faker::Quote.most_interesting_man_in_the_world,
        created_at: date,
        updated_at: date
      )
      #p "Generating a lead"
    end
  end

  def address_gen
    date = Faker::Date.backward(days:1095)
    type = random_building_type

    real_address = get_real_address
    ad = Address.create!(
      type_of_address: type,
      status: get_active, 
      entity: Faker::DcComics.heroine, # Why we have this address
      number_and_street: real_address['address1'],
      suite_or_apartment: real_address['address2'],
      city: real_address['city'],
      postal_code: real_address['postalCode'],
      country: Faker::Address.country,
      notes: Faker::Construction.heavy_equipment,
      created_at: date,
      updated_at: date
    )
    #p "Generating an address"
    return ad
  end

  def customer_gen
    users = User.select('id, created_at, updated_at').where('role = 0')
    users.each do |user|
      if rand(100) > 75
        ad = address_gen
        customer = Customer.create!(
          user_id: user.id,
          company_name: Faker::Company.name,
          address_id: ad.id,
          full_name_of_the_company_contact: Faker::Name.name,
          company_contact_phone: Faker::PhoneNumber.phone_number,
          email_of_the_company_contact: Faker::Internet.email,
          company_description: "",
          full_name_of_service_technical_authority: Faker::Name.name,
          technical_authority_phone_for_service: Faker::PhoneNumber.phone_number,
          technical_manager_email_for_service: Faker::Internet.email,
          created_at: user.created_at,
          updated_at: user.updated_at
        )
        ad.update(customer_id: customer.id)
        p "Generating a customer"
      end
    end
  end

  def building_gen
    c = Customer.count
    serial = 0
    for i in 0..rand(700..1000)
      ad = address_gen
      building = Building.create!(
        customer_id: rand(1..c),
        address_id: ad.id,
        full_name_of_the_building_administrator: Faker::Name.name,
        email_of_the_administrator_of_the_building: Faker::Internet.email,
        phone_number_of_the_building_administrator: Faker::PhoneNumber.phone_number,
        full_name_of_the_technical_contact_for_the_building: Faker::Name.name,
        technical_contact_email_for_the_building: Faker::Internet.email,
        technical_contact_phone_for_the_building: Faker::PhoneNumber.phone_number,
        created_at: ad.created_at,
        updated_at: ad.updated_at
      )
      #p "Generating a building"
      for y in 0..rand(0..5)
        building_details_gen(building)
      end
      serial = battery_gen building, serial
    end
  end

  def building_details_gen(building)
    BuildingDetail.create!(
      building_id: building.id,
      information_Key: Faker::GreekPhilosophers.name,
      value: Faker::Emotion.adjective,
      created_at: building.created_at,
      updated_at: building.updated_at
    )
    #p "Generating building details"
  end

  def battery_gen(building,serial)
    employee_count = Employee.count
    date = Faker::Date.backward(days:4095)
    battery = Battery.create!(
      building_id: building.id,
      battery_type: random_building_type,
      status: get_active,
      employeeId: rand(1..employee_count),
      date_of_commissioning: date,
      date_of_last_inspection: date,
      certificate_of_operations: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      information: Faker::ChuckNorris.fact,
      notes: Faker::Quote.matz,
      created_at: date,
      updated_at: date
    )
    #p "Generating a battery"
    for i in 0..rand(1..3)
      serial = column_gen(battery, serial)
    end
    return serial
  end

  def column_gen(battery, serial)
    date = Faker::Date.backward(days:1095)
    column = Column.create!(
      battery_id: battery.id,
      column_type: random_building_type,
      number_of_floors_served: rand(10..30),
      status: get_active,
      information: Faker::TvShows::SouthPark.quote,
      notes: Faker::TvShows::DrWho.quote,
      created_at: date,
      updated_at: date
    )
    #p "Generating a column"
    for i in 0..rand(1..3)
      serial = elevator_gen column, serial
    end
    return serial
  end

  def elevator_gen(column, serial)
    date = Faker::Date.backward(days:1095)
    Elevator.create!(
      column_id: column.id,
      elevator_type: random_building_type,
      serial_number: "#{serial}",
      model: Faker::Code.nric,
      status: get_active,
      date_of_commissioning: date,
      date_of_last_inspection: date,
      certificate_of_inspection: Faker::Crypto.sha256,
      information: Faker::Company.bs,
      notes: Faker::Artist.name,
      created_at: date,
      updated_at: date
    )
    #p "Generating an elevator"
    return serial + 1
  end

  def random_building_type
    case rand(1..4)
    when 1
      type = "Residential"
    when 2
      type = "Commercial"
    when 3
      type = "Corporate"
    when 4
      type = "Hybrid"
    end
  end

  def get_active
    if rand(100) < 85
      return "active"
    else
      return "inactive"
    end
  end

  def get_real_address
    url = 'https://rocketelevator.me/building'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    address = JSON.parse(response)
    return address
  end
end
