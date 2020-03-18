class Api::V1::BaseController < ApplicationController
  protect_from_forgery
  before_action :load_dates, :set_default_format

  def load_dates
    @start_date ||= Date.today.beginning_of_quarter
    @end_date ||= Date.today.end_of_quarter
  end

  def set_default_format
    request.format = :json
  end
end
