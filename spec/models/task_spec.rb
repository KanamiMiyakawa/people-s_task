require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる１' do
        task = Task.new(task_name: '', content: '失敗テスト', priority: '1', limit: '2020-11-11', status: '1')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる２' do
        task = Task.new(task_name: '失敗テスト', content: '', priority: '1', limit: '2020-11-11', status: '1')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: '成功テスト', content: '成功テスト', priority: '1', limit: '2020-11-11', status: '1')
        expect(task).to be_valid
      end
    end
  end
end
