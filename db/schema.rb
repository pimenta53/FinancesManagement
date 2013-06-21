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

ActiveRecord::Schema.define(:version => 20120219003712) do

  create_table "caixas", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.float    "valor"
    t.string   "estado"
    t.date     "data"
    t.integer  "utilizador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "caixas", ["utilizador_id"], :name => "index_caixas_on_utilizador_id"

  create_table "grupos", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orcamentos", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.float    "valor",      :default => 0.0
    t.date     "data"
    t.boolean  "actual",     :default => true
    t.integer  "grupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orcamentos", ["grupo_id"], :name => "index_orcamentos_on_grupo_id"

  create_table "patrocinios", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.float    "valor"
    t.date     "datainicio"
    t.date     "datafim"
    t.integer  "utilizador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "link"
  end

  add_index "patrocinios", ["utilizador_id"], :name => "index_patrocinios_on_utilizador_id"

  create_table "sub_orcamentos", :force => true do |t|
    t.string   "descricao"
    t.float    "valor"
    t.string   "estado",        :default => "Em Espera"
    t.integer  "orcamento_id"
    t.integer  "utilizador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_orcamentos", ["orcamento_id"], :name => "index_sub_orcamentos_on_orcamento_id"
  add_index "sub_orcamentos", ["utilizador_id"], :name => "index_sub_orcamentos_on_utilizador_id"

  create_table "utilizadors", :force => true do |t|
    t.string   "nome"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.integer  "grupo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "estatuto"
  end

  add_index "utilizadors", ["grupo_id"], :name => "index_utilizadors_on_grupo_id"

end
