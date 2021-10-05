require_relative './config/environment'
require_relative './app/controllers/application_controller'

# if ActiveRecord::Base.connection.migration_context.needs_migration?
# 	raise "Migrations are pending..."
# end

# use Rack::MethodOverride

run ApplicationController