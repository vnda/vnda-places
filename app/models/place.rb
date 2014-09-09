class Place < ActiveRecord::Base
  validates :name, :address_line_1, :city, :postal_code, :categories, :state_id,
            :shop_id, presence: true
  belongs_to :shop
  belongs_to :state
  has_many :opening_hours
  accepts_nested_attributes_for :opening_hours

  def build_opening_hours
    existing = opening_hours.map(&:week_day)
    (0..6).reject { |wd| existing.include?(wd) }
          .each { |wd| opening_hours.build(week_day: wd) }
  end

  def opening_hours_attributes=(attrs_hash)
    existing = opening_hours.index_by { |oh| oh.week_day.to_s }
    vals = attrs_hash.values.map!(&:stringify_keys)
    vals.each do |attrs|
      has_key = existing.key?(attrs['week_day'])
      is_blank = attrs.values_at('open', 'close').all?(&:blank?)

      if is_blank
        existing[attrs['week_day']].mark_for_destruction if has_key
      elsif has_key
        existing[attrs['week_day']].assign_attributes(attrs)
      else
        opening_hours.build(attrs)
      end
    end
  end

  def serializable_hash(*)
    hash = attributes.symbolize_keys
      .slice(:id, :name, :address_line_1, :address_line_2, :alt_phone,
             :categories, :city, :description, :district, :email, :fax,
             :home_page, :images, :lat, :lon, :main_phone, :mobile_phone, :name,
              :videos, :only_cash, :postal_code)
      .merge(state: state.uf)
  end

  def self.select_for_serialization
    includes(:state, :opening_hours)
  end
end
