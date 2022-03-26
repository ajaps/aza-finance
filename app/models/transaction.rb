class Transaction < ApplicationRecord
  validates :customer_id, presence: true
  validates :currency_sent, presence: true
  validates :currency_recieved, presence: true
  validates :amount_sent, numericality: { greater_than_or_equal_to: 0 }
  validates :amount_recieved, numericality: { greater_than_or_equal_to: 0 }

  before_validation :currency_to_uppercase

  private

  def currency_to_uppercase
    self.currency_sent = currency_sent&.upcase
    self.currency_recieved = currency_recieved&.upcase
  end
end
