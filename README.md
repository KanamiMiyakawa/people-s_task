## Model

#### UserModel

| カラム名        | データ型 |
| --------------- | -------- |
| name            | string   |
| email           | string   |
| password_digest | string   |

#### TaskModel

| カラム名  | データ型 |
| --------- | -------- |
| task_name | string   |
| priority  | integer  |
| limit     | date     |
| status    | integer  |
| content   | string   |
| user_id   | integer  |



#### LabelModel


| カラム名   | データ型 |
| ---------- | -------- |
| label_name | string   |
| user_id    | integer  |


#### LabellingModel

| カラム名 | データ型 |
| -------- | -------- |
| task_id  | integer  |
| label_id | integer  |




### herokuへのデプロイ手順
heroku login --interactive<br>
rails assets:precompile RAILS_ENV=production<br>
git add .<br>
git commit -m ""<br>
heroku create<br>
heroku buildpacks:set heroku/ruby<br>
heroku buildpacks:add --index 1 heroku/nodejs<br>
git push heroku master<br>
heroku run rails db:migrate<br>



### データ構造

userとtaskを1対多で紐づけ、indexではそのuserが投稿したtaskだけ表示
taskとlabelを多対多で紐づけ、中間テーブルにlabellingsを設置
userとlabelも1対多で紐づける



### その他

要件から、絞り込みは３種類できなければならない、同時に2種類以上で検索するのはまた今度
	・ステータス
	・タスク名
	・ラベル

絞り込みは一つのページ内で切り替えられればよいが（たぶんjavascripsでいける）
難しければ違うページとして表示させればよい

ラベル付けをいつどのようにするのかという問題
練習なので、多少ごちゃごちゃしても多機能を目指してもいいと思う

label単独で作成するページを作る
task作成と更新時には、作成済みのlabelをチェックボックスで表示し
かつラベルの新規作成用の欄も用意する
（mofmof課題のaccepts_nested_attributes_forで出来ると思う）
