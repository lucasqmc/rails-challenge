class CreateShortLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :short_links do |t|
      t.string :link_hash
      t.text :url

      t.timestamps
    end
  end
end
