#! /usr/bin/ruby

require 'active_record'

# this class init the database and provide method to get/save data
class TorreDB
  def db_connection(adapter, db)
    ActiveRecord::Base.logger = Logger.new(File.open('.database.log', 'w'))
    ActiveRecord::Base.establish_connection(
      adapter: adapter,
      database: db
    )
  end

  def initialize(adapter, db)
    # realtime contain the second of a single http reponse
    # site down is true by default if site was up, false if
    # site was down, netw. issue etc.
    db_connection(adapter, db)
    ActiveRecord::Schema.define do
      unless ActiveRecord::Base.connection.tables.include? 'http_res'
        create_table :http_res do |table|
          table.column :real_time, :float
          table.column :site_up, :boolean
        end
      end
    end
  end
end

# record class for response
class HttpRes < ActiveRecord::Base
  belongs_to :http_res
end
