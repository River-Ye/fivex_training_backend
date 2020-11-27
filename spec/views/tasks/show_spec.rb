require 'rails_helper'

RSpec.describe "tasks/show.html.erb",type: :view do
  before do
    @task = create(:task)
  end

  it "render content when" do
    render
    expect(rendered).to include("標題", 
                                "內容", 
                                "開始時間", 
                                "結束時間", 
                                "狀態")
  end

  it "has link" do
    render
    expect(rendered).to include("首頁")
  end
end