class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :nombre
      t.string :apellido
      t.string :email
      t.string :celular
      t.integer :sobres
      t.integer :ticket_number
      t.string :sucursal
      t.string :nacimiento

      t.timestamps
    end
  end
end
