class AddColumnsToBike < ActiveRecord::Migration[7.0]
    def change
        remove_column(:bikes, :current_station_id)
        add_column(:bikes, :current_station_identifier, :integer)
    end
end