require 'csv'

user_csv = File.read(Rails.root.join('lib', 'user.csv'))
employee_csv = File.read(Rails.root.join('lib', 'employee.csv'))
user_parsed_csv = CSV.parse(user_csv, :headers => true, :encoding => 'ISO-8859-1')
employee_parsed_csv = CSV.parse(employee_csv, :headers => true, :encoding => 'ISO-8859-1')

user_parsed_csv.each do |row|
    user = User.create!(email: row['email'], password: "Codeboxx1!", role: "employee")
    puts "user is : #{user.email}"
end

employee_parsed_csv.each do |row|
    employee = Employee.create!(user_id: row['user_id'], first_name: row['first_name'], last_name: row['last_name'], title: row['title'])
    puts "employee is : #{employee.first_name}"
end
