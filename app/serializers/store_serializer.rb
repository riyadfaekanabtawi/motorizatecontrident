class StoreSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :ciudad, :direccion, :photo, :real_value
end
