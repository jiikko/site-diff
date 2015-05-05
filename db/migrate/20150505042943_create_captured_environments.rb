class CreateCapturedEnvironments < ActiveRecord::Migration
  def change
    create_table :captured_environments do |t|
      t.string :name
      t.references :captured_page, index: true, null: false
      t.attachment :screenshot

      t.timestamps null: false
    end
  end
end
