require "sinatra"
require "sinatra/contrib"
# Reloads the server every time the dev environment is saved
require "sinatra/reloader" if development?
require "pry"
require_relative "./controllers/post_controller"

use Rack::MethodOverride
use Rack::Reloader
# Direct the request to the correct controller

run PostController
