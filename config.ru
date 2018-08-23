require "sinatra"
require "sinatra/contrib"
# Reloads the server every time the dev environment is saved
require "sinatra/reloader" if development?
require "pry"

use Rack::Reloader
use Rack::MethodOverride
# Direct the request to the correct controller
