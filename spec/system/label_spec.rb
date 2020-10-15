require 'rails_helper'

RSpec.describe 'ラベリング機能', type: :system do
  describe '公式ラベル作成・削除機能' do
    before do
      @official_label_manager = FactoryBot.create(:official_label_manager)
      visit new_session_path
      #official_label_managerでログイン
      fill_in "session_email", with: "official@example.com"
      fill_in "session_password", with: "password"
      click_on 'login_button'
      visit admin_users_path
    end
    context '管理ユーザーが公式ラベルを作成した場合' do
      it 'ユーザー一覧画面に表示される' do
        click_on '公式ラベルを作成'
        fill_in "label_label_name", with: "official_label_1"
        click_on '登録する'
        #自動でユーザー一覧に遷移
        expect(page).to have_content 'official_label_1'
      end
    end
    context '管理ユーザーが公式ラベルを削除した場合' do
      it 'ユーザー一覧に表示されない' do
        FactoryBot.create(:official_label_1, user: @official_label_manager)
        FactoryBot.create(:official_label_2, user: @official_label_manager)
        visit admin_users_path
        page.first(".label_delete_link").click
        page.driver.browser.switch_to.alert.accept
        #削除していないラベルはある
        expect(page).to have_content 'official_label_1'
        #削除したラベルがない
        expect(page).to_not have_content 'official_label_2'
      end
    end
  end

  describe 'ユーザー作成ラベルの作成・削除機能' do
    before do
      @official_label_manager = FactoryBot.create(:official_label_manager)
      @user1 = FactoryBot.create(:user1)
      @user2 = FactoryBot.create(:user2)
      visit new_session_path
      #user1でログイン
      fill_in "session_email", with: "fac1@example.com"
      fill_in "session_password", with: "password"
      click_on 'login_button'
    end
    context '一般ユーザーがラベルを作成した場合' do
      it 'そのユーザーのユーザー詳細に表示される' do
        click_on 'ラベル追加'
        fill_in "label_label_name", with: "user_label_1"
        click_on '登録する'
        #自動でユーザー詳細に遷移
        expect(page).to have_content 'user_label_1'
      end
      it '別のユーザーのユーザー詳細には表示されない' do
        FactoryBot.create(:user_label_1, user: @user1)
        visit user_path(@user1.id)
        #user1では表示されている
        expect(page).to have_content 'user_label_1'
        #user2でログイン
        click_button 'ログアウト'
        fill_in "session_email", with: "fac2@example.com"
        fill_in "session_password", with: "password"
        click_on 'login_button'
        #ユーザー詳細にいること確認
        expect(page).to have_content 'ユーザー詳細'
        #さきほど表示されていたラベルが表示されない
        expect(page).to_not have_content 'user_label_1'
      end
    end
    context '一般ユーザーがラベルを削除した場合' do
      it 'ユーザー詳細に表示されない' do
        FactoryBot.create(:user_label_1, user: @user1)
        FactoryBot.create(:user_label_2, user: @user1)
        visit user_path(@user1.id)
        page.first(".user_label_delete_link").click
        page.driver.browser.switch_to.alert.accept
        #削除していないラベルはある
        expect(page).to have_content 'user_label_2'
        #削除したラベルがない
        expect(page).to_not have_content 'user_label_1'
      end
    end
  end

  describe 'タスクのラベル付け機能' do
    before do
      #ユーザー作成
      @official_label_manager = FactoryBot.create(:official_label_manager)
      @user1 = FactoryBot.create(:user1)
      #ラベル作成
      @official_label_1 = FactoryBot.create(:official_label_1, user: @official_label_manager)
      @official_label_2 = FactoryBot.create(:official_label_2, user: @official_label_manager)
      @user_label_1 = FactoryBot.create(:user_label_1, user: @user1)
      @user_label_2 = FactoryBot.create(:user_label_2, user: @user1)
      #user1でログイン
      visit new_session_path
      fill_in "session_email", with: "fac1@example.com"
      fill_in "session_password", with: "password"
      click_on 'login_button'
    end
    context 'ラベルを付けてタスクを作成した場合' do
      it 'タスク詳細にラベルが表示されている' do
        click_button 'タスク作成'
        fill_in "タスク名", with: 'labelling_task_1'
        fill_in "詳細", with: 'labelling_content_1'
        select '低', from: '優先順位'
        page.find('#task_limit').set("2021-01-01")
        choose '未着手'
        check("task_label_ids_#{@official_label_1.id}")
        check("task_label_ids_#{@user_label_1.id}")
        click_on '登録'
        #タスク詳細に遷移
        expect(page).to have_content 'official_label_1' && 'user_label_1'
      end
    end
    context 'ラベル付きのタスクを編集した場合' do
      it 'タスク詳細に編集前のラベルがなく、編集後のラベルがある' do
        @task = FactoryBot.create(:index_test1, user: @user1)
        #ラベルを２つ付与
        FactoryBot.create(:labelling, task: @task, label: @official_label_1)
        FactoryBot.create(:labelling, task: @task, label: @user_label_1)
        visit task_path(@task)
        #ラベルがついていることを確認
        expect(page).to have_content 'official_label_1' && 'user_label_1'
        #さきほどとは別のラベルを付与
        click_on '編集'
        check("task_label_ids_#{@official_label_2.id}")
        check("task_label_ids_#{@user_label_2.id}")
        click_on '更新する'
        #さきほどのラベルがない
        expect(page).to_not have_content 'official_label_1' && 'user_label_1'
        #編集時に付与したラベルがある
        expect(page).to have_content 'official_label_2' && 'user_label_2'
      end
    end
  end

  describe 'ラベル検索機能' do
    before do
      #ユーザー作成
      @official_label_manager = FactoryBot.create(:official_label_manager)
      @user = FactoryBot.create(:user1)
      #ラベル作成
      @task_1 = FactoryBot.create(:search_test1, user: @user)
      @task_2 = FactoryBot.create(:search_test2, user: @user)
      @task_3 = FactoryBot.create(:search_test3, user: @user)
      @task_4 = FactoryBot.create(:search_test4, user: @user)
      @task_5 = FactoryBot.create(:search_test5, user: @user)
      #ラベル作成
      @label_1 = FactoryBot.create(:official_label_1, user: @official_label_manager)
      @label_2 = FactoryBot.create(:user_label_1, user: @user)
      #ラベリング
      FactoryBot.create(:labelling, task: @task_1, label: @label_1)
      FactoryBot.create(:labelling, task: @task_2, label: @label_2)
      FactoryBot.create(:labelling, task: @task_3, label: @label_2)
      FactoryBot.create(:labelling, task: @task_4, label: @label_2)
      #userでログイン
      visit new_session_path
      fill_in "session_email", with: "fac1@example.com"
      fill_in "session_password", with: "password"
      click_on 'login_button'
      visit tasks_path
    end
    context 'ラベルのみで検索した場合' do
      it 'タスク一覧に検索したラベル名のみが表示' do
        #@label_1で検索
        select "#{@label_1.label_name}", from: 'label_id'
        click_button '検索'
        within '.task_tbody' do
          #@task_1と@label_1がある
          expect(page).to have_content "#{@task_1.task_name}" && "#{@label_1.label_name}"
          #@label_2がない
          expect(page).to_not have_content "#{@label_2.label_name}"
        end
      end
    end
    context 'ラベルとタイトルで検索した場合' do
      it 'タスク一覧に検索したラベル、タイトル名のみ表示' do
        #「ルパン」、@label_2で検索
        fill_in "title", with: "ルパン"
        select "#{@label_2.label_name}", from: 'label_id'
        click_button '検索'
        within '.task_tbody' do
          #「ルパン」、@label_2がある
          expect(page).to have_content "ルパン" && "#{@label_2.label_name}"
          #他のタイトル、@label_1がない
          expect(page).to_not have_content "銭形" && "不二子" && "#{@label_1.label_name}"
        end
      end
    end
    context 'ラベルとタイトルとステータスで検索した場合' do
      it 'タスク一覧に検索したラベル、タイトル、ステータスのみ表示' do
        #「銭形」、「着手」、@label_2で検索
        fill_in "title", with: "銭形"
        select "#{@label_2.label_name}", from: 'label_id'
        select '着手', from: 'status'
        click_button '検索'
        within '.task_tbody' do
          #「銭形」、「着手」、@label_2がある
          expect(page).to have_content "銭形" && "#{@label_2.label_name}" && "着手"
          #他のタイトル、ステータス、@label_1がない
          expect(page).to_not have_content "銭形" && "不二子" && "#{@label_1.label_name}" && "未着手" && "完了"
        end
      end
    end
  end
end
