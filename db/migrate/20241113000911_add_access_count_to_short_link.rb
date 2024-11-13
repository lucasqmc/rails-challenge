class AddAccessCountToShortLink < ActiveRecord::Migration[7.1]
  def change
    add_column :short_links, :access_count, :integer
  end
end
