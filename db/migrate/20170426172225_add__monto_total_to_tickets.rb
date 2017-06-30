class AddMontoTotalToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :monto_total, :double
  end
end
