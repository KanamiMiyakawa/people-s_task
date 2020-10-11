# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
