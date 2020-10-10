require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる１' do
        task = Task.new(task_name: '', content: '失敗テスト', priority: '1', limit: '2020-11-11', status: '着手')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる２' do
        task = Task.new(task_name: '失敗テスト', content: '', priority: '1', limit: '2020-11-11', status: '着手')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: '成功テスト', content: '成功テスト', priority: '1', limit: '2020-11-11', status: '着手')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    before do
      @task1 = FactoryBot.create(:search_test1)
      @task2 = FactoryBot.create(:search_test2)
      @task3 = FactoryBot.create(:search_test3)
      @task4 = FactoryBot.create(:search_test4)
      @task5 = FactoryBot.create(:search_test5)
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_searched('銭形')).to include(@task2).and include(@task4)
        expect(Task.title_searched('銭形')).not_to include(@task1)
        expect(Task.title_searched('銭形')).not_to include(@task3)
        expect(Task.title_searched('銭形')).not_to include(@task5)
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_searched('着手')).to include(@task4)
        expect(Task.status_searched('着手')).not_to include(@task1)
        expect(Task.status_searched('着手')).not_to include(@task2)
        expect(Task.status_searched('着手')).not_to include(@task3)
        expect(Task.status_searched('着手')).not_to include(@task5)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_searched('ルパン').status_searched('未着手')).to include(@task1)
        expect(Task.title_searched('ルパン').status_searched('未着手')).not_to include(@task2)
        expect(Task.title_searched('ルパン').status_searched('未着手')).not_to include(@task3)
        expect(Task.title_searched('ルパン').status_searched('未着手')).not_to include(@task4)
        expect(Task.title_searched('ルパン').status_searched('未着手')).not_to include(@task5)
      end
    end
  end
end
