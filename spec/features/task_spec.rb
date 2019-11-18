require 'rails_helper'

RSpec.feature "Task CRUD", type: :feature do
  let(:last_date) { Task.last }
  let!(:task1) { create(:task) }

  scenario "使用者可以新增任務" do
    visit root_path
    click_link "新增任務"
    fill_in "標題", with: "運動"
    fill_in "內容", with: "跑步 5 mins"
    click_button "Create Task"

    expect(page).to have_text("新增成功!")
    expect(last_date.title).to have_content("運動")
  end

  scenario "使用者可以檢視任務" do
    visit "/tasks/#{task1.id}"
    
    expect(page).to have_text("標題:")
    expect(page).to have_text("內容:")
    expect(page).to have_text(task1.title)
  end

  scenario "使用者可以修改任務" do
    visit "tasks/#{task1.id}/edit"
    fill_in "標題", with: "看書"
    fill_in "內容", with: "3 本書"
    click_button "Update Task"

    expect(page).to have_text("更新成功!")
    expect(last_date.title).not_to have_content(task1.title)
    expect(last_date.title).to have_content("看書")
  end

  scenario "使用者可以刪除任務" do
    visit root_path
    
    expect{ click_link "刪除" }.to change(Task, :count).by(-1)
    expect(Task.find_by(id: task1.id)).to be_blank
    expect(page).to have_text("刪除成功!")
  end
end