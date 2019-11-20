require 'rails_helper'

RSpec.describe Task, type: :model do  
  it "should has validates" do
    task = Task.create
    expect(task).not_to be_valid
    expect(task.errors.full_messages).to include("Title 不能為空白", "Content 不能為空白")
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
  end
end