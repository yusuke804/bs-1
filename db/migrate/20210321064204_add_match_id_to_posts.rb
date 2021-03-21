class AddMatchIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :match, foreign_key: true, foreign_key: { to_table: :users }
  end
end
