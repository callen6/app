class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :unique_id
      t.string :title
      t.string :thumbnail
      t.string :description
      t.string :url
    end
  end
end
