require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:task) { create(:task) }
  let(:task_params) { {title: "title_2", content: "content_2"} }
  
  describe "GET #index" do
    it "should show index page" do
      get :index
      with_http200
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "should show new page" do
      get :new
      with_http200
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "should show edit page" do
      get :edit, params: { id: task }
      with_http200
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
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

  describe "PUT #update" do
    it "changes record" do
      post :update, params: { task: task_params, id: task }
      task.reload
      expect(Task.find(task.id)[:title]).to eq "title_2"
      expect(Task.find(task.id)[:content]).to eq "content_2"
    end

    it "redirect on success" do
      post :update, params: { task: task_params, id: task }
      without_http200
      with_http302
      expect(response).to redirect_to(root_path(Task.find(task.id)))
    end

    it "render :edit on fail" do
      allow_any_instance_of(Task).to receive(:update).and_return(false)
      post :update, params: { task: task_params, id: task }
      without_http302
      expect(response).to render_template :edit
    end
  end

  describe "DELETE #destroy" do
    let(:task1) { create(:task) }
    let(:find_task1) { Task.find_by(id: task1.id) }
    let!(:task2) { task1 || create(:task) }

    it "destroy record" do
      expect{ delete :destroy, params: { id: task1 }}.to change{ Task.count }.by(-1)
      with_http302
      expect(find_task1).to be_blank
      expect(response).to redirect_to(root_path(task2.id))
      expect(flash[:notice]).to eq "刪除成功!"
    end

    it "destroy to fail" do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      expect{ delete :destroy, params: { id: task2 }}.to change{ Task.count }.by(0)
      with_http302
      expect(find_task1).not_to be_blank
      expect(response).to redirect_to(root_path(Task.find(task2.id)))
      expect(flash[:notice]).to eq "刪除失敗!"
    end
  end

  private

  def with_http200(tatus=200)
    expect(response).to have_http_status(tatus)
  end

  def without_http200(tatus=200)
    expect(response).not_to have_http_status(tatus)
  end

  def with_http302(tatus=302)
    expect(response).to have_http_status(tatus)
  end

  def without_http302(tatus=302)
    expect(response).not_to have_http_status(tatus)
  end
end