require 'rails_helper'

RSpec.describe Task, type: :model do  
  it "is accessible" do
    task = Task.create
    expect(task).to eq Task.last
  end

  it "has title and content columns" do
    columns = Task.column_names
    expect(columns).to include("title")
    expect(columns).to include("content")
  end
end