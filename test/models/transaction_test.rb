require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "customer_id must be present" do
    invalid_transaction = Transaction.new(amount_sent: 1, currency_sent: "usd", currency_recieved: "NGN", amount_recieved: 200.4366)
    valid_transaction = Transaction.new(amount_sent: 1, currency_sent: "usd", currency_recieved: "NGN", amount_recieved: 200.4366, customer_id: "customer-1")
    
    assert_not invalid_transaction.valid?
    assert valid_transaction.valid?
  end

  test "amount_sent must be present" do
    invalid_transaction = Transaction.new(currency_sent: "usd", currency_recieved: "NGN", amount_recieved: 200.4366, customer_id: "customer-1")
    valid_transaction = transactions(:valid_transaction)
    
    assert_not invalid_transaction.valid?
    assert valid_transaction.valid?
  end

  test "amount_recieved must be equal or greater than 0(zero)" do
    invalid_transaction = Transaction.new(amount_sent: 1, currency_sent: "usd", currency_recieved: "NGN", amount_recieved: -200.4366, customer_id: "customer-1")
    valid_transaction = transactions(:valid_transaction)
    
    assert_not invalid_transaction.valid?
    assert valid_transaction.valid?
  end

  test "currency should be in upcase" do
    currency = "usd"
    transaction = Transaction.new(amount_sent: 1, currency_sent: currency, currency_recieved: "NGN", amount_recieved: 200.4366, customer_id: "customer-1")
    transaction.valid?

    assert transaction.currency_sent == currency.upcase
    assert_not transaction.currency_sent == currency
  end
end
