module ApplicationHelper
  def status_select
    Task.statuses.keys.map{ |k| [I18n.t("enums.task.status.#{k}"), k] }
  end
end