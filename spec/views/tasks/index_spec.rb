require 'rails_helper'

RSpec.describe "tasks/index.html.erb", type: :view do    
  it "can render" do
    task1 = create(:task)
    task2 = create(:task)
    @tasks = [task1, task2]
    render
    
    expect(rendered).to include(task1.title, task2.title)
    expect(rendered).to include(task1.content, task2.content)
  end
end