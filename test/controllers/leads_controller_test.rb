require "test_helper"

class LeadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lead = leads(:one)
  end

  test "should get index" do
    get leads_url
    assert_response :success
  end

  test "should get new" do
    get new_lead_url
    assert_response :success
  end

  test "should create lead" do
    assert_difference("Lead.count") do
      post leads_url, params: { lead: { attached_file_stored_as_a_binary_file: @lead.attached_file_stored_as_a_binary_file, company_name: @lead.company_name, date_of_the_contact_request: @lead.date_of_the_contact_request, department_in_charge_of_the_elevators: @lead.department_in_charge_of_the_elevators, e_mail: @lead.e_mail, full_name_of_the_contact: @lead.full_name_of_the_contact, message: @lead.message, phone: @lead.phone, project_description: @lead.project_description, project_name: @lead.project_name } }
    end

    assert_redirected_to lead_url(Lead.last)
  end

  test "should show lead" do
    get lead_url(@lead)
    assert_response :success
  end

  test "should get edit" do
    get edit_lead_url(@lead)
    assert_response :success
  end

  test "should update lead" do
    patch lead_url(@lead), params: { lead: { attached_file_stored_as_a_binary_file: @lead.attached_file_stored_as_a_binary_file, company_name: @lead.company_name, date_of_the_contact_request: @lead.date_of_the_contact_request, department_in_charge_of_the_elevators: @lead.department_in_charge_of_the_elevators, e_mail: @lead.e_mail, full_name_of_the_contact: @lead.full_name_of_the_contact, message: @lead.message, phone: @lead.phone, project_description: @lead.project_description, project_name: @lead.project_name } }
    assert_redirected_to lead_url(@lead)
  end

  test "should destroy lead" do
    assert_difference("Lead.count", -1) do
      delete lead_url(@lead)
    end

    assert_redirected_to leads_url
  end
end
