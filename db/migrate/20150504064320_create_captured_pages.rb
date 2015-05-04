class CreateCapturedPages < ActiveRecord::Migration
  def change
    create_table :captured_pages do |t|
      t.references :captured_version, index: true, null: false
      t.references :target_pages, index: true, null: false
      t.attachment :screenshot

      t.timestamps null: false
    end
  end
end
