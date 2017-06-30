class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :apellido, :email, :celular, :sobres, :ticket_number, :sucursal, :nacimiento, :added_by
end
