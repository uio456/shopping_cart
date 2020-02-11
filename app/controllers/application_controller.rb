class ApplicationController < ActionController::Base
  include CartsHelper

  def create_fail_error_message(record)
    "Could not create #{record.class}" \
    " because #{record.errors.full_messages.join(', ')}"
  end

end
