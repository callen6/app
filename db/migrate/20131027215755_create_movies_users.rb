class CreateMoviesUsers < ActiveRecord::Migration
  def change
    create_table :movies_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :movie, index: true
    end
  end
end
