class AddCustomerIdToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :customer_id, :string
  end
end
