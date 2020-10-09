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
        choose '未着手'
        click_on '登録'
        expect(page).to have_content 'task2'
      end
    end
  end
  describe '一覧表示機能' do
    1.upto(5){
      |n| task = FactoryBot.create(("task"+n.to_s).intern)
      sleep 1
    }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント２'
        expect(page).to have_content '2'
        expect(page).to have_content '着手'
        expect(page).to have_content '2020-02-28'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it 'あるタスクの作成日時が次に並んでいるタスクより必ず大きい' do
        within '.task_tbody' do
          #作成日時のテキストを配列にして取得
          created_times = all('.task_created_at').map(&:text)
          count = created_times.length
          num = 0
          while num < (count-1) do
            #テキストを時間に戻し、次のタスクと比較
            expect(created_times[num].to_time).to be >= created_times[num+1].to_time
            num += 1
          end
        end
      end
    end
    context 'タスクが期限(limit)の降順に並んでいる場合' do
      it 'あるタスクの期限(limit)が次に並んでいるタスクより必ず大きい' do
        click_link '終了期限でソートする'
        within '.task_tbody' do
          #期限(limit)のテキストを配列にして取得
          task_limits = all('.task_limit').map(&:text)
          count = task_limits.length
          num = 0
          while num < (count-1) do
            #テキストを次のタスクのテキストと大小比較、そのまま比較できる
            expect(task_limits[num]).to be >= task_limits[num+1]
            num += 1
          end
        end
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
