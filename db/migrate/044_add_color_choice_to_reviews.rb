class AddColorChoiceToReviews < ActiveRecord::Migration
    def self.up
       add_column :reviews, :color, :string
    end

    def self.down
      remove_column :reviews, :color
    end
  end