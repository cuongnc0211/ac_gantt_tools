class User::BaseController < ApplicationController
  before_action :authenticate_user!
  layout "user/application"

  helper_method :all_projects, :all_members

  def all_projects
    @projects ||= Project.all
  end

  def all_members
    @members ||= Member.all
  end
end
