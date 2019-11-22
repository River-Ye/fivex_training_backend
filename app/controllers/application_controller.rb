class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["http_auth_username"], password: ENV["http_auth_password"] if Rails.env.production?
end