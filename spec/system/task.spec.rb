require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タスク名", with: 'task2'
        fill_in "詳細", with: 'taskcontent2'
        select '1', from: '優先順位'
        page.find('#task_limit').set("2021-01-01")
        choose 'task_status_1'
        click_on '登録'
        expect(page).to have_content 'task2'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:system_task)
        visit tasks_path
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:system_task)
         visit task_path(task.id)
         expect(page).to have_content 'Factoryで作ったデフォルトのコンテント２'
       end
     end
  end
end