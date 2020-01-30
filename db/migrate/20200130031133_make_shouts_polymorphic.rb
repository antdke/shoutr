class MakeShoutsPolymorphic < ActiveRecord::Migration[6.0]
  # referencing shout and text shout inside of this migrations to prevent unexpected behavior and being interrupted by validations
  class Shout < ApplicationRecord
    belongs_to :content, polymorphic: true
  end
  class TextShout < ApplicationRecord; end
  
  def change
    # adding additional columns to the table
    change_table(:shouts) do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_type, :content_id]
    end 

    # to make sure that our changes are reversible
    reversible do |dir|
      # for resetting changes; makes sure we cache and store appropriate columns
      Shout.reset_column_information 
      # create TextShouts for all our existing shouts & updating shouts to have appropriate content type and content id
      Shout.find_each do |shout|
        dir.up do
          # create the body of the text shouts from the existing bodies of shouts
          text_shout = TextShout.create(body: shout.body)
          # update shouts to have proper content id and content type
          shout.update(content_id: text_shout.id, content_type: "TextShout")
        end
        dir.down do
          # update the shout and set the body to shout.content.body
          shout.update(body: shout.content.body)
          shout.content.destroy
        end
      end 
    end 
    
    # removing the existing body columns
    remove_column :shouts, :body, :string
  end
end
