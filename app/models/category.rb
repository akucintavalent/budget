class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments

  validates :name, presence: true, length: { minimum: 3, maximum: 250 }
  validates :icon, presence: true
end
