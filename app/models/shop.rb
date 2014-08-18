class Shop < ActiveRecord::Base
  has_many :places
  validates :name, presence: true
  before_create { self.token = SecureRandom.hex }
end
