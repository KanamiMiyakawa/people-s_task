FactoryBot.define do

  factory :task1, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    priority {1}
    limit {Date.today}
    status {2}

    factory :task2 do
      task_name {'Factoryで作ったデフォルトのタイトル２'}
      content { 'Factoryで作ったデフォルトのコンテント２' }
    end

    factory :task3 do
      task_name {'Factoryで作ったデフォルトのタイトル３'}
      priority {2}
    end

    factory :task4 do
      task_name {'Factoryで作ったデフォルトのタイトル４'}
      limit {Date.new(2020,11,11)}
    end

    factory :task5 do
      task_name {'Factoryで作ったデフォルトのタイトル５'}
      status {3}
    end
  end

  factory :system_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    priority {2}
    limit {Date.new(2020,11,11)}
    status {3}
  end

end
