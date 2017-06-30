# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20170629221130) do

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "participants", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "email"
    t.string   "celular"
    t.string   "nacimiento"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "status"
    t.string   "ciudad"
    t.string   "password_digest"
    t.string   "added_by"
    t.string   "note"
    t.string   "estado"
  end

  create_table "stores", :force => true do |t|
    t.string   "nombre"
    t.string   "ciudad"
    t.string   "direccion"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "real_value"
    t.string   "razon_social"
    t.string   "cliente"
    t.string   "estado"
    t.integer  "fase"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "ticket_number"
    t.string   "ticket_sucursal"
    t.string   "ticket_date"
    t.string   "ticket_calculo"
    t.integer  "participant_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "ticket_image_file_name"
    t.string   "ticket_image_content_type"
    t.integer  "ticket_image_file_size"
    t.datetime "ticket_image_updated_at"
    t.float    "monto_total"
  end

  add_index "tickets", ["participant_id"], :name => "index_tickets_on_participant_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "email"
    t.string   "surname"
    t.string   "confirm_token"
    t.string   "auth_token"
    t.string   "status"
  end

end
