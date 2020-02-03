# frozen_string_literal: true

class AddManagerInProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :manager_id, :integer, null: false
  end
end
