class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :ticket_number
      t.string :ticket_sucursal
      t.string :ticket_date
      t.string :ticket_calculo

          t.belongs_to :participant

      t.timestamps
    end
    add_index :tickets, :participant_id
  end
end
