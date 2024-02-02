require './config/environment'

RSpec.configure do |config|
    config.include Rack::Test::Methods

    def app
        Sinatra::Application
    end
end