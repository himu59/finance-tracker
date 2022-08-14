class ApplicationController < ActionController::Base
    before_action :authenticate_user! #Devise will create some helpers to use inside your controllers and views. To set up a controller with user authentication
end
