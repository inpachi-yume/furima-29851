class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nickname,         null: false
      t.string :email,            null: false,uniqueness:true
      t.string :password,         null: false,uniqueness:true
      t.string :last_name,        null: false
      t.string :first_name,       null: false
      t.string :last_name_kana,   null: false
      t.string :first_name_kana,  null: false
      t.datetime :birth_date,     null: false

      t.timestamps
    end
  end
end
