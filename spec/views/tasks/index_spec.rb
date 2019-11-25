require 'rails_helper'

RSpec.describe "tasks/index.html.erb", type: :view do    
  it "can render" do
    task1 = create(:task)
    task2 = create(:task)
    @tasks = [task1, task2]
    render
    
    expect(rendered).to include(task1.title, task2.title)
    expect(rendered).to include(task1.content, task2.content)
    expect(rendered).to include(task1.start_time.strftime('%Y-%m-%d %H:%M'), 
                                task2.start_time.strftime('%Y-%m-%d %H:%M'))
    expect(rendered).to include(task1.end_time.strftime('%Y-%m-%d %H:%M'), 
                                task2.end_time.strftime('%Y-%m-%d %H:%M'))
    expect(rendered).to include(I18n.t("enums.task.status")[:"#{task1.status}"], 
                                I18n.t("enums.task.status")[:"#{task2.status}"])
  end
end