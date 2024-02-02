require 'dotenv'

Dotenv.load()

require './config/environment'

use Rack::MethodOverride

require './app/controllers/application_controller'

# if ActiveRecord::Base.connection.migration_context.needs_migration?
# 	raise "Migrations are pending..."
# end


run ApplicationController