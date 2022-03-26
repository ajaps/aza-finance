class Api::V1::TransactionsController < ApplicationController
  def create
    transaction = Transaction.new(transaction_params)

    if transaction.save
      render json: transaction, status: :created
    else
      render json: { error: transaction.errors }, status: :unprocessable_entity
    end
  end

  def index
    transactions = Transaction.all

    render json: transactions, status: :ok
  end

  def show
    transaction = Transaction.find_by(id: params[:id])

    if transaction
      render json: transaction, status: :ok
    else
      render json: { error: "Transaction not found" }, status: :not_found
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:customer_id, :amount_sent, :currency_sent, :amount_recieved, :currency_recieved)
  end
end
