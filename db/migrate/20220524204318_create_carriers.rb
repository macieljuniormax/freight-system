class CreateCarriers < ActiveRecord::Migration[7.0]
  def change
    create_table :carriers do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :email_domain
      t.string :registration_number
      t.string :adress

      t.timestamps
    end
  end
end
