class UseUuidInMeasurements < ActiveRecord::Migration[5.0]
  def change
    change_table :measurements do |t|
      t.uuid :uuid, null: false, default: 'uuid_generate_v4()'
      t.rename :id, :original_id
      t.rename :uuid, :id
    end

    reversible do |dir|
      execute 'ALTER TABLE measurements DROP CONSTRAINT measurements_pkey;'

      dir.up do
        execute 'ALTER TABLE measurements ADD PRIMARY KEY (id);'
      end

      dir.down do
        execute 'ALTER TABLE measurements ADD PRIMARY KEY (original_id);'
      end
    end
  end
end
