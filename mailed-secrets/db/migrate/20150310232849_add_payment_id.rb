class AddPaymentId < ActiveRecord::Migration
  def change
  	add_column :users, :payment_id, :string
  end
end
