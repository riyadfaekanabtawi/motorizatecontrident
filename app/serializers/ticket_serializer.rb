class TicketSerializer < ActiveModel::Serializer
  attributes :id, :ticket_calculo, :ticket_date, :ticket_number, :ticket_sucursal, :ticket_image
end
