class AddInvoiceNumberToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :invoice_number, :integer
  end
end
