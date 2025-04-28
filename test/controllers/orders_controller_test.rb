require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_index_url
    assert_response :success
  end

  test "should get show" do
    get orders_show_url
    assert_response :success
  end

  test "should get new" do
    get orders_new_url
    assert_response :success
  end

  test "should get create" do
    get orders_create_url
    assert_response :success
  end

  test "should get update" do
    get orders_update_url
    assert_response :success
  end

  test "should get destroy" do
    get orders_destroy_url
    assert_response :success
  end

  test "should get process_order" do
    get orders_process_order_url
    assert_response :success
  end

  test "should get ship_order" do
    get orders_ship_order_url
    assert_response :success
  end

  test "should get deliver_order" do
    get orders_deliver_order_url
    assert_response :success
  end

  test "should get cancel_order" do
    get orders_cancel_order_url
    assert_response :success
  end
end
