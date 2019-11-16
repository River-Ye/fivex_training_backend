require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:all) do
    @task1 = Task.create(title: 'title_1', content: 'content_1')
    @task2 = Task.create(title: 'title_2', content: 'content_2')
  end
  
  it "#index" do
    get :index
    expect(response).to have_http_status(200)
    expect(response).to render_template :index
  end

  it "#new" do
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template :new
  end

  it "#edit" do
    get :edit, params: { id: @task1[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template :edit
  end

  describe "#create" do
    before(:all) do
      @task_params = { title: 'title', content: 'content' }
    end

    it "creates record" do
      expect{ post :create, params: { task: @task_params } }.to change{ Task.all.size }.by(1)
      expect(flash[:notice]).to eq '新增成功!'
    end

    it "redirect on success" do
      post :create, params: { task: @task_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path(Task.last))
    end

    it "render :new on fail" do
      allow_any_instance_of(Task).to receive(:save).and_return(false)
      post :create, params: { task: @task_params }
      expect(response).not_to have_http_status(302)
      expect(response).to render_template :new
    end
  end

  describe "#update" do
    before(:all) do
      @task_params = { title: 'title_3', content: 'content_3' }
    end

    it "changes record" do
      post :update, params: { task: @task_params, id: @task2[:id] }
      expect(Task.find(@task2[:id])[:title]).to eq "title_3"
      expect(Task.find(@task2[:id])[:content]).to eq "content_3"
    end

    it "redirect on success" do
      post :update, params: { task: @task_params, id: @task2[:id] }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path(Task.find(@task2[:id])))
    end

    it "render :edit on fail" do
      allow_any_instance_of(Task).to receive(:update).and_return(false)
      post :update, params: { task: @task_params, id: @task2[:id] }
      expect(response).not_to have_http_status(302)
      expect(response).to render_template :edit
    end
  end

  describe "#destroy" do
    before(:each) do
      @task3 = @task2 || Task.create(title: 'title_3', content: 'content_3')
    end

    it "destroy record" do
      expect{ delete :destroy, params: { id: @task2[:id] } }.to change{ Task.all.count }.by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path(@task3[:id]))
      expect(flash[:notice]).to eq '刪除成功!'
    end

    it "destroy to fail" do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      expect{ delete :destroy, params: { id: @task2[:id] } }.to change{ Task.all.count }.by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path(Task.find(@task2[:id])))
      expect(flash[:notice]).to eq '刪除失敗!'
    end
  end
end