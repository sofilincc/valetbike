class AddNameToBikes < ActiveRecord::Migration[7.0]
    def change
        add_column(:bikes, :name, :string)
    end
end