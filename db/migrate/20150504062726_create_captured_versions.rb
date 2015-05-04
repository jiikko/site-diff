class CreateCapturedVersions < ActiveRecord::Migration
  def change
    create_table :captured_versions do |t|
      t.integer :name, default: 1
      t.references :site, null: false

      t.timestamps null: false
    end
  end
end
