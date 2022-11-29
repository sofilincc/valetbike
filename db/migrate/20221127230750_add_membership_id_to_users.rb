class AddMembershipIdToUsers < ActiveRecord::Migration[7.0]
    def change
        add_column(:users, :membership_id, :integer, index:true)
    end
end