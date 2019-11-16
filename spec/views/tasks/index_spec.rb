require 'rails_helper'

RSpec.describe "tasks/index.html.erb", type: :view do
  it "can render" do
    @task = Task.create(title: 'test title', content: 'content')
    @tasks = Array.new(2, @task)
    render
    expect(rendered).to include("title")
    expect(rendered).to include("test title")
  end
end