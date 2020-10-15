## ラベルの仕様

ラベルは公式ラベルとユーザー作成ラベルの2種類に分けられ、  
公式ラベルはすべてのユーザーが使用でき、ユーザー作成ラベルは作成したユーザーのみ使用できる  

**必ず最初にseed.rbを実行し、管理ユーザーである"official_label_manager"と初期の公式ラベルを作成してください**  


公式ラベルは、管理画面のユーザー一覧から作成、削除ができる  
管理画面から作成すると自動的に"official_label_manager"のuser_idに紐づけられ、公式ラベルとして扱われる  

ユーザー作成ラベルは、管理画面ではないユーザー詳細ページから作成、削除ができる  
この画面から作成すると、ログインユーザーが管理ユーザーだったとしてもユーザー作成ラベルとして扱われる  

"official_label_manager"は削除できないようにmodelで制限が掛けられている  
必然的に"official_label_manager"は最初かつ最後の管理ユーザーになる  

---

## Model

#### UserModel

| カラム名        | データ型 |
| --------------- | -------- |
| name            | string   |
| email           | string   |
| password_digest | string   |
| admin           | boolean  |


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
| official   | boolean  |
| user_id    | integer  |


#### LabellingModel

| カラム名 | データ型 |
| -------- | -------- |
| task_id  | integer  |
| label_id | integer  |

---


### herokuへのデプロイ手順

```
#herokuにログイン
$ heroku login --interactive<br>

#プリコンパイル
$ rails assets:precompile RAILS_ENV=production<br>

$ git add .<br>
$ git commit -m ""<br>

#herokuにアプリ作成
$ heroku create<br>

#必要があればbuild packを読み込む
$ heroku buildpacks:set heroku/ruby<br>
$ heroku buildpacks:add --index 1 heroku/nodejs<br>

#herokuにアップロード
$ git push heroku master<br>

#db:migrateを忘れずに
$ heroku run rails db:migrate<br>
```


---

### アソシエーションの概要

- userとtaskを1対多
- userとlabelを1対多
- taskとlabelを多対多で紐づけ、中間テーブルにlabellingsを設置

---

### 技術的な課題

 - すでにラベル付けのされているタスクの編集画面に移動した際、チェックボックスのすでに関連付けられているラベルに、あらかじめチェックが入れられない
 - 公式ラベルとユーザー作成ラベルの順番が入り混じる。boolean型でもorderできるのだろうか？
