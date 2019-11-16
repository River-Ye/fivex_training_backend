require 'rails_helper'

RSpec.describe "tasks/show.html.erb",type: :view do
  before do
    @task = Task.create(title: 'test title', content: 'content')
  end

  it "render content when" do
    render
    expect(rendered).to include("content")
  end

  it "has link" do
    render
    expect(rendered).to include("首頁")
  end
end