module ApplicationHelper
  def status_select
    Task.statuses.keys.map{ |k| [I18n.t("enums.task.status.#{k}"), k] }
  end

  def options_select
    options_for_select([[t("enums.task.status.pending"), 0],
                        [t("enums.task.status.progress"), 1],
                        [t("enums.task.status.completed"), 2]])
  end
end