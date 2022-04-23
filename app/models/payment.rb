class Payment < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories

  validates :name, presence: true, length: { minimum: 3, maximum: 250 }
  validates :amount, numericality: { greater_than: 0 }
end
