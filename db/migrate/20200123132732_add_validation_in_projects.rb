# frozen_string_literal: true

class AddValidationInProjects < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :name, :string, null: false
    change_column :projects, :details, :text, null: false
  end
end
