require 'json'
require 'rest-client'
require 'bundler'
Bundler.require
require_all"app/models"
require_all"db/migrate"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/citibikes.db')
require_all 'lib'
