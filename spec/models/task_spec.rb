require 'rails_helper'

RSpec.describe Task, type: :model do  
  it "should has validates" do
    task = Task.create
    expect(task).not_to be_valid
    expect(task.errors.full_messages).to include("標題 不能為空白",
                                                 "內容 不能為空白",
                                                 "開始時間 不能為空白",
                                                 "結束時間 不能為空白")
    expect(Task.count).to be 0
  end

  it "should start_time > end_time" do
    task = Task.create(title: 'title_1',
                       content: 'content_1',
                       start_time: DateTime.parse('2019-11-22 09:00'),
                       end_time: DateTime.parse('2019-11-22 08:00'))
    
    expect(task.errors.full_messages).to include("結束時間 必須大於開始時間")
    expect(Task.count).to be 0
  end
  
  it "is accessible" do
    task = create(:task)
    expect(task).to be_valid
    expect(task).to eq Task.last
  end

  it "has title and content columns" do
    columns = Task.column_names
    expect(columns).to include("title")
    expect(columns).to include("content")
    expect(columns).to include("start_time")
    expect(columns).to include("end_time")
  end
end