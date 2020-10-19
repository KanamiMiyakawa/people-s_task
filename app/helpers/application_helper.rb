module ApplicationHelper
  def expired_or_not(task)
    if task.task_expired_at < Time.zone.today+2 && task.status != "完了"
      "task_expired_index_td"
    end
  end
end
