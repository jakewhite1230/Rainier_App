class AddPlanToUsers < ActiveRecord::Migration
  def change
    add_column :tenants, :plan, :string
  end
end
