class ApplicationController < ActionController::Base
  before_action :init_cart

 include CartHelper
end
