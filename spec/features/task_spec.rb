require 'rails_helper'

RSpec.feature "Task CRUD", type: :feature do
  let(:last_date) { Task.last }
  let!(:task1) { create(:task) }

  context "新增" do
    scenario "欄位 title、content 為必填" do
      visit root_path
      click_link "新增任務"
      click_button "新增任務"

      expect(page).to have_text("Title 不能為空白", "Content 不能為空白")
      expect(current_path).to eq "/tasks"
    end

    scenario "使用者可以新增任務" do
      visit root_path
      click_link "新增任務"
      fill_in "標題", with: "運動"
      fill_in "內容", with: "跑步 5 mins"
      click_button "新增任務"

      expect(page).to have_text("新增成功!")
      expect(last_date.title).to have_content("運動")
      expect(last_date.content).to have_content("跑步 5 mins")
    end
  end

  context "檢視" do
    scenario "使用者可以檢視任務" do
      visit "/tasks/#{task1.id}"
      
      expect(page).to have_text("標題:")
      expect(page).to have_text("內容:")
      expect(page).to have_text(task1.title)
    end
  end

  context "修改" do
    scenario "使用者修改欄位 title、content 為必填" do
      visit "tasks/#{task1.id}/edit"
      fill_in "標題", with: ""
      fill_in "內容", with: ""
      click_button "更新任務"
  
      expect(page).to have_content("Title 不能為空白", "Content 不能為空白")
      expect(page).not_to have_content(task1.title)
      expect(page).not_to have_content(task1.content)
      expect(page).not_to have_text("更新成功!")
    end

    scenario "使用者可以修改任務" do
      visit "tasks/#{task1.id}/edit"
      fill_in "標題", with: "看書"
      fill_in "內容", with: "3 本書"
      click_button "更新任務"
  
      expect(page).to have_text("更新成功!")
      expect(last_date.title).not_to have_content(task1.title)
      expect(last_date.title).to have_content("看書")
      expect(last_date.content).to have_content("3 本書")
    end
  end

  context "刪除" do
    scenario "使用者可以刪除任務" do
      visit root_path
      
      expect{ click_link "刪除" }.to change(Task, :count).by(-1)
      expect(Task.find_by(id: task1.id)).to be_blank
      expect(page).to have_text("刪除成功!")
    end
  end

  context "排序方式" do
    let!(:task2) { create(:task) }
    let!(:task3) { create(:task) }

    scenario "任務列表以建立時間排序" do
      visit root_path

      within "tbody>tr:nth-child(1)" do
        expect(page).to have_text("#{task3.title}")
      end
  
      within "tbody>tr:nth-child(2)" do
        expect(page).to have_text("#{task2.title}")
      end
  
      within "tbody>tr:nth-child(3)" do
        expect(page).to have_text("#{task1.title}")
      end
    end
  end
end