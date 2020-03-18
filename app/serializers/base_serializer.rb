class BaseSerializer < ActiveModel::Serializer
  def start_date
    @start_date ||= Date.today.beginning_of_quarter
  end

  def end_date
    @end_date ||= Date.today.end_of_quarter
  end
end