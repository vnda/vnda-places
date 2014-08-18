class OpeningHour < ActiveRecord::Base
  validates :week_day, :open, :close, presence: true

  default_scope -> { order(:week_day) }

  def serializable_hash(*)
    {
      'week_day' => week_day,
      'open' => open.strftime('%H:%M'),
      'close' => close.strftime('%H:%M'),
    }
  end
end
