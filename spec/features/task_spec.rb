require 'rails_helper'

RSpec.feature "Task", type: :feature do
  let(:last_date) { Task.last }
  let!(:task1) { create(:task, end_time: Time.zone.parse("2030-11-22 15:00")) }
  let(:task2) { create(:task, end_time: Time.zone.parse("2030-11-22 18:00")) }
  let(:task3) { create(:task, end_time: Time.zone.parse("2030-11-22 20:00")) }

  context "新增" do
    scenario "欄位 title、content、start_time、end_time 為必填" do
      visit root_path
      click_link "新增任務"
      click_button "新增任務"

      expect(page).to have_content("標題 不能為空白")
      expect(page).to have_content("內容 不能為空白")
      expect(page).to have_content("開始時間 不能為空白")
      expect(page).to have_content("結束時間 不能為空白")
      expect(current_path).to eq "/tasks"
    end

    scenario "使用者可以新增任務" do
      visit root_path
      click_link "新增任務"
      fill_in "標題", with: "運動"
      fill_in "內容", with: "跑步 5 mins"
      fill_in "開始時間", with: Time.zone.parse("2019-11-22 10:00")
      fill_in "結束時間", with: Time.zone.parse("2019-11-22 14:00")
      click_button "新增任務"

      expect(page).to have_text("新增成功!")
      expect(last_date.title).to have_content("運動")
      expect(last_date.content).to have_content("跑步 5 mins")
      expect(last_date.start_time).to have_content("2019-11-22 10:00")
      expect(last_date.end_time).to have_content("2019-11-22 14:00")
    end
  end

  context "檢視" do
    scenario "使用者可以檢視任務" do
      visit "/tasks/#{task1.id}"
      
      expect(page).to have_text("標題:")
      expect(page).to have_text("內容:")
      expect(page).to have_text("開始時間:")
      expect(page).to have_text("結束時間:")
      expect(page).to have_text("狀態:")
      expect(page).to have_text(task1.title)
      expect(page).to have_text(task1.content)
      expect(page).to have_text(task1.start_time.strftime('%Y-%m-%d %H:%M'))
      expect(page).to have_text(task1.end_time.strftime('%Y-%m-%d %H:%M'))
      expect(page).to have_text(I18n.t("enums.task.status")[:"#{task1.status}"])
    end
  end

  context "修改" do
    scenario "使用者修改欄位 title、content、start_time、end_time 為必填" do
      visit "tasks/#{task1.id}/edit"
      fill_in "標題", with: ""
      fill_in "內容", with: ""
      fill_in "開始時間", with: ""
      fill_in "結束時間", with: ""
      click_button "更新任務"
  
      expect(page).to have_content("標題 不能為空白")
      expect(page).to have_content("內容 不能為空白")
      expect(page).to have_content("開始時間 不能為空白")
      expect(page).to have_content("結束時間 不能為空白")
      expect(page).not_to have_content(task1.title)
      expect(page).not_to have_content(task1.content)
      expect(page).not_to have_content(task1.start_time.strftime('%Y-%m-%d %H:%M'))
      expect(page).not_to have_content(task1.end_time.strftime('%Y-%m-%d %H:%M'))
      expect(page).not_to have_text("更新成功!")
    end

    scenario "使用者可以修改任務" do
      visit "tasks/#{task1.id}/edit"
      fill_in "標題", with: "看書"
      fill_in "內容", with: "3 本書"
      select "完成", from: "task_status"
      click_button "更新任務"

      expect(page).to have_text("更新成功!")
      expect(last_date.title).not_to have_content(task1.title)
      expect(last_date.title).to have_content("看書")
      expect(last_date.content).to have_content("3 本書")
      expect(last_date.status).to have_content(I18n.t("enums.task.status").key("完成").to_s)
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
    scenario "任務列表以結束時間排序" do
      task2
      task3
      visit root_path

      within "tbody>tr:nth-child(1)" do
        expect(page).to have_text("2030-11-22 20:00")
      end
  
      within "tbody>tr:nth-child(2)" do
        expect(page).to have_text("2030-11-22 18:00")
      end
  
      within "tbody>tr:nth-child(3)" do
        expect(page).to have_text("2030-11-22 15:00")
      end
    end
  end

  context "查詢功能" do
    scenario "使用者可以使用 title、status 查詢" do
      task2
      task3
      visit root_path
      fill_in "search_title", with: "title"
      select "完成", from: "search_status"
      click_button "搜尋"

      expect(page).not_to have_text(task1.title)
      expect(page).not_to have_text(task2.title)
      expect(page).to have_text(task3.title)
    end
  end
end