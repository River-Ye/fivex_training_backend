require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:task1) { FactoryBot.create(:task) }
  let(:task2) { FactoryBot.create(:task) }
  let!(:task3) { task2 || FactoryBot.create(:task) }
  let(:task_params) { {title: "title_4", content: "content_4"} }
  let(:with_http200) { expect(response).to have_http_status(200)}
  let(:without_http200) { expect(response).not_to have_http_status(200)}
  let(:with_http302) { expect(response).to have_http_status(302)}
  let(:without_http302) { expect(response).not_to have_http_status(302)}
  
  it "#index" do
    get :index
    with_http200
    expect(response).to render_template :index
  end

  it "#new" do
    get :new
    with_http200
    expect(response).to render_template :new
  end

  it "#edit" do
    get :edit, params: { id: task1 }
    with_http200
    expect(response).to render_template :edit
  end

  describe "#create" do
    it "creates record" do
      expect{ post :create, params: { task: task_params }}.to change{ Task.all.size }.by(1)
      expect(flash[:notice]).to eq "新增成功!"
    end

    it "redirect on success" do
      post :create, params: { task: task_params }
      without_http200
      with_http302
      expect(response).to redirect_to(root_path(Task.last))
    end

    it "render :new on fail" do
      allow_any_instance_of(Task).to receive(:save).and_return(false)
      post :create, params: { task: task_params }
      without_http302
      expect(response).to render_template :new
    end
  end

  describe "#update" do
    it "changes record" do
      post :update, params: { task: task_params, id: task2 }
      expect(Task.find(task2.id)[:title]).to eq "title_4"
      expect(Task.find(task2.id)[:content]).to eq "content_4"
    end

    it "redirect on success" do
      post :update, params: { task: task_params, id: task2 }
      without_http200
      with_http302
      expect(response).to redirect_to(root_path(Task.find(task2.id)))
    end

    it "render :edit on fail" do
      allow_any_instance_of(Task).to receive(:update).and_return(false)
      post :update, params: { task: task_params, id: task2 }
      without_http302
      expect(response).to render_template :edit
    end
  end

  describe "#destroy" do
    it "destroy record" do
      expect{ delete :destroy, params: { id: task2 }}.to change{ Task.count }.by(-1)
      with_http302
      expect(response).to redirect_to(root_path(task3.id))
      expect(flash[:notice]).to eq "刪除成功!"
    end

    it "destroy to fail" do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      expect{ delete :destroy, params: { id: task2 }}.to change{ Task.count }.by(0)
      with_http302
      expect(response).to redirect_to(root_path(Task.find(task2.id)))
      expect(flash[:notice]).to eq "刪除失敗!"
    end
  end
end