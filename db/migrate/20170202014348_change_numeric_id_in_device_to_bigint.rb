class ChangeNumericIdInDeviceToBigint < ActiveRecord::Migration[5.0]
  def change
    change_column(:devices, :numeric_id, :bigint)
  end
end
