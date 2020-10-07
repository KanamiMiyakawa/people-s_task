FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  # factory :task do
  #   task_name { 'Factoryで作ったデフォルトのタイトル１' }
  #   content { 'Factoryで作ったデフォルトのコンテント１' }
  #   priority {1}
  #   limit {Date.new(2020,11,11)}
  #   status {2}
  # end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :system_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    priority {2}
    limit {Date.new(2020,11,11)}
    status {3}
  end
end
