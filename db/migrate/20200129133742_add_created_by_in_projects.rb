# frozen_string_literal: true

class AddCreatedByInProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :created_by_id, :integer, null: false
  end
end
