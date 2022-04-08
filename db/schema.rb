# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_08_202818) do
  create_table "addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type_of_address"
    t.string "status"
    t.string "entity"
    t.string "number_and_street"
    t.string "suite_or_apartment"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.float "longitude"
    t.float "latitude"
    t.index ["customer_id"], name: "fk_rails_d5f9efddd3"
  end

  create_table "batteries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "building_id"
    t.string "battery_type"
    t.string "status"
    t.string "employeeId"
    t.date "date_of_commissioning"
    t.date "date_of_last_inspection"
    t.string "certificate_of_operations"
    t.string "information"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "fk_rails_fc40470545"
  end

  create_table "building_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "building_id"
    t.string "information_Key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_building_details_on_building_id"
  end

  create_table "buildings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "address_id"
    t.string "full_name_of_the_building_administrator"
    t.string "email_of_the_administrator_of_the_building"
    t.string "phone_number_of_the_building_administrator"
    t.string "full_name_of_the_technical_contact_for_the_building"
    t.string "technical_contact_email_for_the_building"
    t.string "technical_contact_phone_for_the_building"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "buildingId"
    t.string "information_key"
    t.string "value"
    t.index ["address_id"], name: "fk_rails_6dc7a885ab"
    t.index ["customer_id"], name: "fk_rails_c29cbe7fb8"
  end

  create_table "columns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "battery_id"
    t.string "column_type"
    t.string "number_of_floors_served"
    t.string "status"
    t.string "information"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battery_id"], name: "fk_rails_021eb14ac4"
  end

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "company_name"
    t.bigint "address_id"
    t.string "full_name_of_the_company_contact"
    t.string "company_contact_phone"
    t.string "email_of_the_company_contact"
    t.text "company_description"
    t.string "full_name_of_service_technical_authority"
    t.string "technical_authority_phone_for_service"
    t.string "technical_manager_email_for_service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "fk_rails_3f9404ba26"
    t.index ["user_id"], name: "fk_rails_9917eeaf5d"
  end

  create_table "elevators", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "column_id"
    t.integer "serial_number"
    t.string "model"
    t.string "elevator_type"
    t.string "status"
    t.date "date_of_commissioning"
    t.date "date_of_last_inspection"
    t.text "certificate_of_inspection"
    t.text "information"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "fk_rails_69442d7bc2"
  end

  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_dcfd3d4fc3"
  end

  create_table "interventions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "building_id"
    t.bigint "battery_id"
    t.bigint "column_id"
    t.bigint "elevator_id"
    t.bigint "employee_id"
    t.timestamp "start_date_and_time_of_the_intervention"
    t.timestamp "end_date_and_time_of_the_intervention"
    t.string "result"
    t.text "report"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author"
  end

  create_table "leads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "full_name_of_the_contact"
    t.string "company_name"
    t.string "e_mail"
    t.string "phone"
    t.string "project_name"
    t.text "project_description"
    t.string "department_in_charge_of_the_elevators"
    t.text "message"
    t.binary "attached_file_stored_as_a_binary_file", size: :long
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
  end

  create_table "long_lat_in_addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "buildingType"
    t.integer "number_of_floors"
    t.integer "number_of_basements"
    t.integer "number_of_apartments"
    t.integer "number_of_parking_spots"
    t.integer "elevator_amount"
    t.integer "number_of_companies"
    t.integer "maximum_occupancy"
    t.integer "number_of_corporations"
    t.integer "business_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "range"
    t.string "company_name"
    t.text "email"
    t.string "full_name_of_the_contact"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "admin"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "batteries", "buildings"
  add_foreign_key "building_details", "buildings"
  add_foreign_key "buildings", "addresses"
  add_foreign_key "buildings", "customers"
  add_foreign_key "columns", "batteries"
  add_foreign_key "customers", "addresses"
  add_foreign_key "customers", "users"
  add_foreign_key "elevators", "columns"
  add_foreign_key "employees", "users"
end
