class AddColumnsToStations < ActiveRecord::Migration[7.0]
    def change
        add_column(:stations, :has_kiosk, :integer)
        add_column(:stations, :needs_maintenance, :integer)
        add_column(:stations, :dock_count, :integer)
        add_column(:stations, :docked_bike_count, :integer)
    end
  end
  