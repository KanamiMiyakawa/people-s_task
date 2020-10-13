require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it 'ログインしてタスク一覧が表示される' do
        visit new_user_path
        fill_in "user_name", with: 'test1'
        fill_in "user_email", with: 'test1@example.com'
        fill_in "user_password", with: 'password'
        fill_in "user_password_confirmation", with: 'password'
        click_on '登録する'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログインせずにタスク一覧に飛ぼうとする' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能' do
    before do
      @user1 = FactoryBot.create(:user1)
      @user2 = FactoryBot.create(:user2)
      @admin1 = FactoryBot.create(:admin1)
      visit new_session_path
      #user1でログイン
      fill_in "session_email", with: "fac1@example.com"
      fill_in "session_password", with: "password"
      click_on 'login_button'
    end
    context 'ログインする' do
      it '自分の詳細画面に遷移する' do
        #ログイン後、自動でユーザー詳細ページに飛ぶ
        expect(page).to have_content 'ユーザー詳細'
      end
    end
    context '一般ユーザーが他人の詳細画面に飛ぶ' do
      it 'タスク一覧に遷移する' do
        #user2の詳細ページにアクセス
        visit user_path(@user2.id)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトできる' do
      it 'ログイン画面に遷移する' do
        click_button 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
    context '管理画面にアクセスできない' do
      it 'タスク一覧に遷移' do
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '管理画面機能' do
    before do
      @admin1 = FactoryBot.create(:admin1)
      @user1 = FactoryBot.create(:user1)
      @user2 = FactoryBot.create(:user2)
      visit new_session_path
      #admin1でログイン
      fill_in "session_email", with: "fac_ad1@example.com"
      fill_in "session_password", with: "password"
      click_on 'login_button'
      visit admin_users_path
    end
    context '管理ユーザーは管理画面にアクセスできる' do
      it '管理画面のユーザー一覧が表示されている' do
        expect(page).to have_content 'ユーザー一覧（管理画面）'
      end
    end
    context '管理ユーザーはユーザーの新規作成ができる' do
      it '管理画面のユーザー一覧に遷移し、作成したユーザーが一覧に表示されている' do
        click_on 'ユーザーを新規作成'
        fill_in "user_name", with: 'made_by_admin1'
        fill_in "user_email", with: 'made1@example.com'
        fill_in "user_password", with: 'password'
        fill_in "user_password_confirmation", with: 'password'
        click_on '登録する'
        #自動でユーザー一覧に遷移
        expect(page).to have_content 'made_by_admin1'
      end
    end
    context '管理ユーザーはユーザーの詳細画面にアクセスできる' do
      it '管理画面のユーザー詳細が表示されている' do
        visit admin_user_path(@user1.id)
        expect(page).to have_content 'ユーザー詳細（管理画面）' && 'factory_guy_1'
      end
    end
    context '管理ユーザーはユーザーの編集ができる' do
      it '編集した後の内容が一覧に表示されている' do
        visit edit_admin_user_path(@user1.id)
        fill_in "user_name", with: 'edited_by_admin1'
        fill_in "user_email", with: 'edited1@example.com'
        fill_in "user_password", with: 'password'
        fill_in "user_password_confirmation", with: 'password'
        choose '管理者'
        click_on '更新する'
        #自動でユーザー一覧に遷移
        expect(page).to have_content 'edited_by_admin1' && 'edited1@example.com'
        expect(page).to have_content('管理者', count: 2)
      end
    end
    context '管理ユーザーはユーザーの削除ができる' do
      it '削除したユーザー名が一覧にない' do
        page.first(".user_destroy").click
        page.driver.browser.switch_to.alert.accept
        #ユーザー一覧に遷移
        expect(page).to have_content 'ユーザー一覧（管理画面）'
        expect(page).to_not have_content 'factory_guy_2'
      end
    end
  end
end
