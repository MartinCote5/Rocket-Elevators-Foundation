require "application_system_test_case"

class InterventionsTest < ApplicationSystemTestCase
  setup do
    @intervention = interventions(:one)
  end

  test "visiting the index" do
    visit interventions_url
    assert_selector "h1", text: "Interventions"
  end

  test "should create intervention" do
    visit interventions_url
    click_on "New intervention"

    fill_in "Battery", with: @intervention.battery_id
    fill_in "Building", with: @intervention.building_id
    fill_in "Column", with: @intervention.column_id
    fill_in "Customer", with: @intervention.customer_id
    fill_in "Elevator", with: @intervention.elevator_id
    fill_in "Employee", with: @intervention.employee_id
    fill_in "End date and time of the intervention", with: @intervention.end_date_and_time_of_the_intervention
    fill_in "Report", with: @intervention.report
    fill_in "Result", with: @intervention.result
    fill_in "Start date and time of the intervention", with: @intervention.start_date_and_time_of_the_intervention
    fill_in "Status", with: @intervention.status
    click_on "Create Intervention"

    assert_text "Intervention was successfully created"
    click_on "Back"
  end

  test "should update Intervention" do
    visit intervention_url(@intervention)
    click_on "Edit this intervention", match: :first

    fill_in "Battery", with: @intervention.battery_id
    fill_in "Building", with: @intervention.building_id
    fill_in "Column", with: @intervention.column_id
    fill_in "Customer", with: @intervention.customer_id
    fill_in "Elevator", with: @intervention.elevator_id
    fill_in "Employee", with: @intervention.employee_id
    fill_in "End date and time of the intervention", with: @intervention.end_date_and_time_of_the_intervention
    fill_in "Report", with: @intervention.report
    fill_in "Result", with: @intervention.result
    fill_in "Start date and time of the intervention", with: @intervention.start_date_and_time_of_the_intervention
    fill_in "Status", with: @intervention.status
    click_on "Update Intervention"

    assert_text "Intervention was successfully updated"
    click_on "Back"
  end

  test "should destroy Intervention" do
    visit intervention_url(@intervention)
    click_on "Destroy this intervention", match: :first

    assert_text "Intervention was successfully destroyed"
  end
end
