class Measurement < ActiveRecord::Base
  validates :captured_at, :location, :device_id, :payload, presence: true
  validates :device_id, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 2 ** 32,
    only_integer: true
  }
end

# == Schema Information
#
# Table name: measurements
#
#  id          :integer          not null, primary key
#  captured_at :datetime         not null
#  location    :geography({:srid not null, point, 4326
#  device_id   :integer          not null
#  payload     :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
