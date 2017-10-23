require 'bundler'
Bundler.require
require_all"app/models"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/citibikes.db')
require_all 'lib'
