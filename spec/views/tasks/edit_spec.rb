require 'rails_helper'

RSpec.describe "tasks/edit.html.erb",type: :view do
  before do
    @task = Task.create(title: 'test title', content: 'content')
  end

  it "render partial" do
    render
    expect(response).to render_template(partial: "_form")
  end

  it "has link" do
    render
    expect(rendered).to include("首頁")
  end
end