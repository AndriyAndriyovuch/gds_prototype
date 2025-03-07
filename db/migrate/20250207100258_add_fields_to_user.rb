# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :phone_number, :string, null: false
  end
end
