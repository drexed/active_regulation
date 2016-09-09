ActiveRecord::Schema.define(version: 1) do

  create_table :users, force: :cascade do |t|
    t.string :name
    t.datetime :contained_at
    t.datetime :expires_at
    t.datetime :inactivated_at
    t.datetime :invisible_at
    t.datetime :suspended_at
    t.datetime :quarantined_at
    t.timestamps null: false
  end

end
