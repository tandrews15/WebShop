require 'test_helper'

class OrderedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ordered_item = ordered_items(:one)
  end

  test "should get index" do
    get ordered_items_url
    assert_response :success
  end

  test "should get new" do
    get new_ordered_item_url
    assert_response :success
  end

  test "should create ordered_item" do
    assert_difference('OrderedItem.count') do
      post ordered_items_url, params: { ordered_item: { item_id: @ordered_item.item_id, order_id: @ordered_item.order_id, quantity: @ordered_item.quantity } }
    end

    assert_redirected_to ordered_item_url(OrderedItem.last)
  end

  test "should show ordered_item" do
    get ordered_item_url(@ordered_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_ordered_item_url(@ordered_item)
    assert_response :success
  end

  test "should update ordered_item" do
    patch ordered_item_url(@ordered_item), params: { ordered_item: { item_id: @ordered_item.item_id, order_id: @ordered_item.order_id, quantity: @ordered_item.quantity } }
    assert_redirected_to ordered_item_url(@ordered_item)
  end

  test "should destroy ordered_item" do
    assert_difference('OrderedItem.count', -1) do
      delete ordered_item_url(@ordered_item)
    end

    assert_redirected_to ordered_items_url
  end
end
