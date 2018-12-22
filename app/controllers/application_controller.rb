class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersInviteHelper
end
