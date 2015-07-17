class AdminController < ApplicationController
  include Authority::Controller
  before_filter :authenticate_user!

  add_crumb "Admin", '/admin'
  layout 'admin'
  authorize_actions_for AdminAuthorizer, actions: {show: :manage}
end
