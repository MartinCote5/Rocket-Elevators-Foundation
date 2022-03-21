require "application_system_test_case"

class LeadsTest < ApplicationSystemTestCase
  setup do
    @lead = leads(:one)
  end

  test "visiting the index" do
    visit leads_url
    assert_selector "h1", text: "Leads"
  end

  test "should create lead" do
    visit leads_url
    click_on "New lead"

    fill_in "Attached file stored as a binary file", with: @lead.attached_file_stored_as_a_binary_file
    fill_in "Company name", with: @lead.company_name
    fill_in "Date of the contact request", with: @lead.date_of_the_contact_request
    fill_in "Department in charge of the elevators", with: @lead.department_in_charge_of_the_elevators
    fill_in "E mail", with: @lead.e_mail
    fill_in "Full name of the contact", with: @lead.full_name_of_the_contact
    fill_in "Message", with: @lead.message
    fill_in "Phone", with: @lead.phone
    fill_in "Project description", with: @lead.project_description
    fill_in "Project name", with: @lead.project_name
    click_on "Create Lead"

    assert_text "Lead was successfully created"
    click_on "Back"
  end

  test "should update Lead" do
    visit lead_url(@lead)
    click_on "Edit this lead", match: :first

    fill_in "Attached file stored as a binary file", with: @lead.attached_file_stored_as_a_binary_file
    fill_in "Company name", with: @lead.company_name
    fill_in "Date of the contact request", with: @lead.date_of_the_contact_request
    fill_in "Department in charge of the elevators", with: @lead.department_in_charge_of_the_elevators
    fill_in "E mail", with: @lead.e_mail
    fill_in "Full name of the contact", with: @lead.full_name_of_the_contact
    fill_in "Message", with: @lead.message
    fill_in "Phone", with: @lead.phone
    fill_in "Project description", with: @lead.project_description
    fill_in "Project name", with: @lead.project_name
    click_on "Update Lead"

    assert_text "Lead was successfully updated"
    click_on "Back"
  end

  test "should destroy Lead" do
    visit lead_url(@lead)
    click_on "Destroy this lead", match: :first

    assert_text "Lead was successfully destroyed"
  end
end
