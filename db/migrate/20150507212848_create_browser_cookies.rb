class CreateBrowserCookies < ActiveRecord::Migration
  def change
    create_table :browser_cookies do |t|
      t.string :name
      t.string :value
      t.references :target_page, index: true, null: false

      t.timestamps null: false
    end
  end
end
