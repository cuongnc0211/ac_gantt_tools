class User::BaseController < ApplicationController
  before_action :authenticate_user!
  layout "user/application"

  helper_method :all_projects, :all_members, :load_dates

  def all_projects
    @projects ||= Project.all
  end

  def all_members
    @members ||= Member.all
  end

  def load_dates
    @start_date = Date.today.beginning_of_quarter
    @end_date = Date.today.end_of_quarter
  end
end
