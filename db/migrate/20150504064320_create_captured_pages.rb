class CreateCapturedPages < ActiveRecord::Migration
  def change
    create_table :captured_pages do |t|
      t.references :captured_version, index: true, null: false
      t.references :target_page, index: true, null: false

      t.timestamps null: false
    end
  end
end
