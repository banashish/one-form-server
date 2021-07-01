class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :kind
      t.boolean :mandatory
      t.integer :order
      t.references :form, foreign_key: true 

      t.timestamps
    end
  end
end
