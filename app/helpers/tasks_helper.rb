module TasksHelper
  def official_or_user_label(label)
    if label.official?
      "official_label official_label_task_new"
    else
      "user_label"
    end
  end
end
