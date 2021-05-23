class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.monetize :amount
      t.string :state, comment: "for aasm"
      t.datetime :paid_at
      t.datetime :expired_at
      t.belongs_to :user, foreign_key: true
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
end
