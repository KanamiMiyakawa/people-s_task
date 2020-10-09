FactoryBot.define do

  factory :task1, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    priority {1}
    limit {Date.today}
    status {'未着手'}

    factory :task2 do
      task_name {'Factoryで作ったデフォルトのタイトル２'}
      content { 'Factoryで作ったデフォルトのコンテント２' }
      limit {Date.new(2020,1,1)}
    end

    factory :task3 do
      task_name {'Factoryで作ったデフォルトのタイトル３'}
      priority {2}
      limit {Date.new(2020,4,15)}
    end

    factory :task4 do
      task_name {'Factoryで作ったデフォルトのタイトル４'}
      limit {Date.new(2020,10,5)}
    end

    factory :task5 do
      task_name {'Factoryで作ったデフォルトのタイトル５'}
      status {'着手'}
      limit {Date.new(2020,2,28)}
    end
  end

  factory :system_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    priority {2}
    limit {Date.new(2020,11,11)}
    status {'完了'}
  end

end
