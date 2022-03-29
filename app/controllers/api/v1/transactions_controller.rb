class Api::V1::TransactionsController < ApplicationController
  before_action :find_transaction, only: %w[ show update destroy ]

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
    render json: @transaction, status: :ok
  end

  def update
   if @transaction.update(transaction_params)
    render json: { data: @transaction }, status: :ok
   else
    render json: { error: "Could not update record" }, status: 400
   end
  end

  def destroy
    if @transaction.destroy
      render json: { message: "Transaction deleted successfully" }, status: 200 
    else
      render json: { error: "Could not delete transaction" }, status: 400 
    end
  end

  private

  def find_transaction
    @transaction = Transaction.find_by(id: params[:id])

    return if @transaction

    render json: { error: "Transaction not found" }, status: :not_found
  end

  def transaction_params
    params.require(:transaction).permit(:customer_id, :amount_sent, :currency_sent, :amount_recieved, :currency_recieved)
  end
end
