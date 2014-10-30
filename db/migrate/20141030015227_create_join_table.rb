class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :schemes do |t|
      t.index :user_id
      t.index :scheme_id
    end
  end
end
