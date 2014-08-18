class OpeningHour < ActiveRecord::Base
  validates :week_day, :open, :close, presence: true
end
