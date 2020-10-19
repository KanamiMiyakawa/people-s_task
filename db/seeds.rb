# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#公式ラベル管理者を作成
#必ず最初に実行してください！
# label_manager = User.create!(
#   name: 'official_label_manager',
#   email: 'official@example.com',
#   password: 'password',
#   password_confirmation: 'password',
#   admin: true
# )
# labels = ["趣味","生活","仕事","勉強","人間関係"]
# labels.each do |official_label|
#   Label.create!(
#     label_name: "#{official_label}",
#     official: true,
#     user_id: label_manager.id
#   )
# end



# Heroku投入用データ
# 管理ユーザー、1人
# 一般ユーザー、9人
# 公式ラベル、５件
# 一般ユーザーそれぞれにユーザー作成ラベル1つ、タスク2件作成
label_manager = User.create!(
  name: 'official_label_manager',
  email: 'official@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

1.upto(9){|n|
  User.create!(
    name: "user_#{n}",
    email: "user_#{n}@example.com",
    password: 'password',
    password_confirmation: 'password',
  )
}

labels = ["趣味","生活","仕事","勉強","人間関係"]
labels.each do |official_label|
  Label.create!(
    label_name: "#{official_label}",
    official: true,
    user_id: label_manager.id
  )
end

User.where(admin:false).each do |user|
  Label.create!(
    label_name: "user_label_1",
    user_id: user.id
  )
  1.upto(2){|n|
    Task.create!(
      task_name: "task_#{n}",
      priority: "中",
      limit: Date.today,
      status: "未着手",
      content: "test_#{n}",
      user_id: user.id
    )
  }
end

#fakerによる生成のあとの検索で、Bitmap Index Scanが行われていることを確認
#seed実行前にlocale.rbの日本語設定をコメントアウトすること
# require 'faker'
# 1000.times do |n|
#   task_name = Faker::Games::Pokemon.name
#   Task.create!(task_name: task_name,
#                content: "content_#{n}",
#                priority: "高",
#                limit: Date.today,
#                status: "着手",
#                )
# end
