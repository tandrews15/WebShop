require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    check "Confirmed" if @order.confirmed
    fill_in "Payment", with: @order.payment_id
    fill_in "Shipping address", with: @order.shipping_address
    fill_in "Shipping notes", with: @order.shipping_notes
    fill_in "User", with: @order.user_id
    fill_in "User notes", with: @order.user_notes
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    check "Confirmed" if @order.confirmed
    fill_in "Payment", with: @order.payment_id
    fill_in "Shipping address", with: @order.shipping_address
    fill_in "Shipping notes", with: @order.shipping_notes
    fill_in "User", with: @order.user_id
    fill_in "User notes", with: @order.user_notes
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
