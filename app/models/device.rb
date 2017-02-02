class Device < ActiveRecord::Base
  validates :payload, presence: true
  validates :numeric_id, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 2 ** 32,
    only_integer: true
  }

  class << self
    def valid_attributes
      @valid_attributes ||= Set.new(%w(numeric_id longitude latitude location_name))
    end
  end
end

# == Schema Information
#
# Table name: devices
#
#  numeric_id    :integer          not null
#  location      :geography({:srid point, 4326
#  location_name :string
#  payload       :jsonb            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  id            :uuid             not null, primary key
#
