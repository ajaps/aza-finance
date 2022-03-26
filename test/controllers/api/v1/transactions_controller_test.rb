require "test_helper"

class Api::V1::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    body = {
      transaction: {
        customer_id: "customer-2",
        amount_sent: 23.21,
        currency_sent: "usd",
        currency_recieved: "ngn",
        amount_recieved: 20,
      }
    }
    post api_v1_transactions_url(body)

    assert_response :success
  end

  test "should get index" do
    get api_v1_transactions_url
    
    assert_response :success
  end

  test "should get show" do
    transaction = Transaction.last
    get api_v1_transaction_url(id: transaction.id)

    assert_response :success
  end
end

