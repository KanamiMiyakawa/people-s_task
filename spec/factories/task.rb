FactoryBot.define do

  #一覧表示機能用
  factory :index_test1, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    priority {'中'}
    limit {Date.today}
    status {'未着手'}

    factory :index_test2 do
      task_name {'Factoryで作ったデフォルトのタイトル２'}
      content { 'Factoryで作ったデフォルトのコンテント２' }
      priority {'緊急'}
      limit {Date.new(2020,1,1)}
    end

    factory :index_test3 do
      task_name {'Factoryで作ったデフォルトのタイトル３'}
      priority {'不急'}
      limit {Date.new(2020,4,15)}
    end

    factory :index_test4 do
      task_name {'Factoryで作ったデフォルトのタイトル４'}
      priority {'高'}
      limit {Date.new(2020,10,5)}
    end

    factory :index_test5 do
      task_name {'Factoryで作ったデフォルトのタイトル５'}
      status {'着手'}
      priority {'低'}
      limit {Date.new(2020,2,28)}
    end
  end

  #詳細表示機能用
  factory :system_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    priority {'高'}
    limit {Date.new(2020,11,11)}
    status {'完了'}
  end

  #検索機能用
  factory :search_test1, class: Task do
    task_name { 'Factory生成タイトル１・ルパン' }
    content { 'Factory生成コンテント１'}
    priority {'緊急'}
    limit {Date.today}
    status {'未着手'}

    factory :search_test2 do
      task_name { 'Factory生成タイトル２・銭形' }
      status {'未着手'}
    end

    factory :search_test3 do
      task_name { 'Factory生成タイトル１・ルパン' }
      status {'完了'}
    end

    factory :search_test4 do
      task_name { 'Factory生成タイトル２・銭形' }
      status {'着手'}
    end

    factory :search_test5 do
      task_name { 'Factory生成タイトル３・不二子' }
      status {'未着手'}
    end
  end

end
