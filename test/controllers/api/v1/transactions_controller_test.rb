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

  test "should update successfully" do
    transaction = Transaction.last

    transaction_params = {
      id: transaction.id,
      transaction: {
        customer_id: "customer-10",
      },
    }
    
    put api_v1_transaction_url(transaction_params)

    response_body = JSON.parse(response.body)

    assert response_body["data"]["customer_id"] == transaction_params[:transaction][:customer_id]
    assert_response :success
  end

  test "should fail if validation fails on update" do
    transaction = Transaction.last

    params = {
      id: transaction.id,
      transaction: {
        amount_sent: -1,
      },
    }
    
    put api_v1_transaction_url(params)

    response_body = JSON.parse(response.body)

    assert response_body["error"] == "Could not update record"
    assert_response :bad_request
  end
  
  test "should delete transaction successfully" do
    transaction = Transaction.last
    delete api_v1_transaction_url(id: transaction.id)

    response_body = JSON.parse(response.body)

    assert response_body["message"] == "Transaction deleted successfully"
    assert_response :success
  end
end

