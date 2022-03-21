require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:one)
  end

  test "visiting the index" do
    visit quotes_url
    assert_selector "h1", text: "Quotes"
  end

  test "should create quote" do
    visit quotes_url
    click_on "New quote"

    fill_in "Business-hours", with: @quote.business-hours
    fill_in "Elevator-amount", with: @quote.elevator-amount
    fill_in "Elevator-total-price", with: @quote.elevator-total-price
    fill_in "Elevator-unit-price", with: @quote.elevator-unit-price
    fill_in "Excelium", with: @quote.excelium
    fill_in "Final-price", with: @quote.final-price
    fill_in "Installation-fees", with: @quote.installation-fees
    fill_in "Maximum-occupancy", with: @quote.maximum-occupancy
    fill_in "Number-of-apartments", with: @quote.number-of-apartments
    fill_in "Number-of-basements", with: @quote.number-of-basements
    fill_in "Number-of-companies", with: @quote.number-of-companies
    fill_in "Number-of-corporations", with: @quote.number-of-corporations
    fill_in "Number-of-elevators", with: @quote.number-of-elevators
    fill_in "Number-of-floors", with: @quote.number-of-floors
    fill_in "Number-of-parking-spots", with: @quote.number-of-parking-spots
    fill_in "Premium", with: @quote.premium
    fill_in "Standard", with: @quote.standard
    fill_in "Type", with: @quote.type
    click_on "Create Quote"

    assert_text "Quote was successfully created"
    click_on "Back"
  end

  test "should update Quote" do
    visit quote_url(@quote)
    click_on "Edit this quote", match: :first

    fill_in "Business-hours", with: @quote.business-hours
    fill_in "Elevator-amount", with: @quote.elevator-amount
    fill_in "Elevator-total-price", with: @quote.elevator-total-price
    fill_in "Elevator-unit-price", with: @quote.elevator-unit-price
    fill_in "Excelium", with: @quote.excelium
    fill_in "Final-price", with: @quote.final-price
    fill_in "Installation-fees", with: @quote.installation-fees
    fill_in "Maximum-occupancy", with: @quote.maximum-occupancy
    fill_in "Number-of-apartments", with: @quote.number-of-apartments
    fill_in "Number-of-basements", with: @quote.number-of-basements
    fill_in "Number-of-companies", with: @quote.number-of-companies
    fill_in "Number-of-corporations", with: @quote.number-of-corporations
    fill_in "Number-of-elevators", with: @quote.number-of-elevators
    fill_in "Number-of-floors", with: @quote.number-of-floors
    fill_in "Number-of-parking-spots", with: @quote.number-of-parking-spots
    fill_in "Premium", with: @quote.premium
    fill_in "Standard", with: @quote.standard
    fill_in "Type", with: @quote.type
    click_on "Update Quote"

    assert_text "Quote was successfully updated"
    click_on "Back"
  end

  test "should destroy Quote" do
    visit quote_url(@quote)
    click_on "Destroy this quote", match: :first

    assert_text "Quote was successfully destroyed"
  end
end
