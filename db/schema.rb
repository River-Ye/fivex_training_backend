ActiveRecord::Schema.define(version: 2019_11_19_022715) do
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end