FactoryBot.define do

  # factory :model_task, class: Task do
  #   task_name { 'Factoryで作ったデフォルトのタイトル１' }
  #   content { 'Factoryで作ったデフォルトのコンテント１' }
  #   priority {1}
  #   limit {Date.new(2020,11,11)}
  #   status {2}
  # end

  factory :system_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    priority {2}
    limit {Date.new(2020,11,11)}
    status {3}
  end
end
