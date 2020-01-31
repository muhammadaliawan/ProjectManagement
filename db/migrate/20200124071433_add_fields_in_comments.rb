# frozen_string_literal: true

class AddFieldsInComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :commenter_id, :integer, null: false
  end
end
