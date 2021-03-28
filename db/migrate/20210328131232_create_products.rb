class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table   :products do |t|
      t.string     :title,            null: false
      t.integer    :category_id,      null: false
      t.text       :info,             null: false
      t.integer    :quality_id,       null: false
      t.integer    :location_id,      null: false
      t.integer    :price,            null: false
      t.integer    :delivery_date_id, null: false
      t.integer    :delivery_fee_id,  null: false
      t.references :user,             null: false, foreign_key: true
      t.timestamps
    end
  end
end
