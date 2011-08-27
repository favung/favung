class Admin::ApplicationController < ApplicationController
  before_filter :is_admin?

  private
  def is_admin?
    unless current_user && current_user.admin?
      raise "Access Denied"
    end
  end
end
