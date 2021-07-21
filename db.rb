require 'sequel'

module MyDB
    DB ||= Sequel.sqlite('testing.db')

    unless DB.table_exists?(:users)
        DB.create_table :users do
        primary_key :user_id
        column :name, String
        column :age, Integer
        column :password, String
        end
    end

    unless DB.table_exists?(:sessions)
        DB.create_table :sessions do
        foreign_key :user_id, :users
        column :total_time, Float
        column :total_correct, Integer
        column :total_exercises, String
        column :avg_time, Float
        DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
        end
    end

    class User < Sequel::Model
        one_to_many :sessions
    end

    class Session < Sequel::Model
        many_to_one :users
    end
end