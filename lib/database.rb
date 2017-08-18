#! /usr/bin/ruby

require 'active_record'

# this class init the database and provide method to get/save data
class TorreDB
   def initialize(adapter, db)
    ActiveRecord::Base.logger = Logger.new(File.open('.database.log', 'w'))
    ActiveRecord::Base.establish_connection(
      adapter: adapter,
      database: db
    )
    # realtime contain the second of a single http reponse
    # site down is true by default if site was up, false if something went wrong. site was down, netw. issue etc.
    ActiveRecord::Schema.define do
      unless ActiveRecord::Base.connection.tables.include? 'http_res'
        create_table :http_res do |table|	
          table.column :real_time, :float
          table.column :realtime_index, :integer
          table.column :site_down, :boolean
        end
      end
    end
  end
end

class HttpRes < ActiveRecord::Base
  belongs_to :http_res  
end

TorreDB.new('sqlite3', 'torre.db')

track_listing = [
  nil,
  1,
  2,
  3,
  4,
]

track_listing.each_with_index do |value, index|
  HttpRes.create(:realtime_index => index, :real_time => value) unless index === 0 # skip zero index
end

p httpR.all
