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
      FactoryBot.create(:user1)
      FactoryBot.create(:user2)
      visit new_session_path
    end
    context 'ログインする' do
      it '自分の詳細画面に遷移する' do
        #user1でログイン
        fill_in "session_email", with: "fac1@example.com"
        fill_in "session_password", with: "password"
        click_on 'login_button'
        expect(page).to have_content 'ユーザー詳細'
      end
    end
    context '一般ユーザーが他人の詳細画面に飛ぶ' do
      it 'タスク一覧に飛ばされる' do
        #user1でログイン
        fill_in "session_email", with: "fac1@example.com"
        fill_in "session_password", with: "password"
        click_on 'login_button'
        #user2の詳細ページにアクセス
        visit user_path(1)
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
end
