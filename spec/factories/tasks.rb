FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    priority {1}
    limit {Date.new(2020,11,11)}
    status {2}
  end
end
