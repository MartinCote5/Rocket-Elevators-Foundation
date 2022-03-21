require "test_helper"

class QuotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote = quotes(:one)
  end

  test "should get index" do
    get quotes_url
    assert_response :success
  end

  test "should get new" do
    get new_quote_url
    assert_response :success
  end

  test "should create quote" do
    assert_difference("Quote.count") do
      post quotes_url, params: { quote: { business-hours: @quote.business-hours, elevator-amount: @quote.elevator-amount, elevator-total-price: @quote.elevator-total-price, elevator-unit-price: @quote.elevator-unit-price, excelium: @quote.excelium, final-price: @quote.final-price, installation-fees: @quote.installation-fees, maximum-occupancy: @quote.maximum-occupancy, number-of-apartments: @quote.number-of-apartments, number-of-basements: @quote.number-of-basements, number-of-companies: @quote.number-of-companies, number-of-corporations: @quote.number-of-corporations, number-of-elevators: @quote.number-of-elevators, number-of-floors: @quote.number-of-floors, number-of-parking-spots: @quote.number-of-parking-spots, premium: @quote.premium, standard: @quote.standard, type: @quote.type } }
    end

    assert_redirected_to quote_url(Quote.last)
  end

  test "should show quote" do
    get quote_url(@quote)
    assert_response :success
  end

  test "should get edit" do
    get edit_quote_url(@quote)
    assert_response :success
  end

  test "should update quote" do
    patch quote_url(@quote), params: { quote: { business-hours: @quote.business-hours, elevator-amount: @quote.elevator-amount, elevator-total-price: @quote.elevator-total-price, elevator-unit-price: @quote.elevator-unit-price, excelium: @quote.excelium, final-price: @quote.final-price, installation-fees: @quote.installation-fees, maximum-occupancy: @quote.maximum-occupancy, number-of-apartments: @quote.number-of-apartments, number-of-basements: @quote.number-of-basements, number-of-companies: @quote.number-of-companies, number-of-corporations: @quote.number-of-corporations, number-of-elevators: @quote.number-of-elevators, number-of-floors: @quote.number-of-floors, number-of-parking-spots: @quote.number-of-parking-spots, premium: @quote.premium, standard: @quote.standard, type: @quote.type } }
    assert_redirected_to quote_url(@quote)
  end

  test "should destroy quote" do
    assert_difference("Quote.count", -1) do
      delete quote_url(@quote)
    end

    assert_redirected_to quotes_url
  end
end
